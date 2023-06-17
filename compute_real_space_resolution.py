
import os
import re
import subprocess
import tempfile

import pandas as pd


def get_mtriage_stats(pdb_path, mtz_path):

    stats = {}
    curdir = os.getcwd()

    with tempfile.TemporaryDirectory() as tempdir:

        os.chdir(tempdir)

        map_path = 'mtz.map'

        sf2map_cmd = [
            'gemmi',
            'sf2map',
            '-s 3',
            '-f 2FOFCWT',
            '-p PH2FOFCWT',
            mtz_path,
            map_path,
        ]
        r = subprocess.run(' '.join(sf2map_cmd), shell=True, capture_output=True, text=True)
        assert os.path.exists(map_path)

        mtriage_cmd = [
            'phenix.mtriage',
            map_path,
            pdb_path,
        ]
        r = subprocess.run(' '.join(mtriage_cmd), shell=True, capture_output=True, text=True)

        g_d99 = re.search(r"using map alone \(d99\)\s+:\s+(\d+.\d+)\s+(\d+.\d+)", r.stdout)
        stats["d99"] = float(g_d99.group(2))
        stats["d99_masked"] = float(g_d99.group(1))

        g_d_model = re.search(r"comparing with model \(d_model\)\s+:\s+(\d+.\d+)\s+(\d+.\d+)", r.stdout)
        stats["d_model"] = float(g_d_model.group(2))
        stats["d_model_masked"] = float(g_d_model.group(1))

        g_d_model_b0 = re.search(r"comparing with model \(d_model_b0\):\s+(\d+.\d+)\s+(\d+.\d+)", r.stdout)
        stats["d_model_b0"] = float(g_d_model_b0.group(2))
        stats["d_model_b0_masked"] = float(g_d_model_b0.group(1))

        g_fsc_map_model_05 = re.search(r"FSC\(map,model map\)=0\.5\s+:\s+(\d+.\d+)\s+(\d+.\d+)", r.stdout)
        stats["fsc_map_model_05"] = float(g_fsc_map_model_05.group(2))
        stats["fsc_map_model_05_masked"] = float(g_fsc_map_model_05.group(1))

    os.chdir(curdir)

    return stats


def main():

    TIMEPOINTS = ['superdark', '3ps', '300ps', '1ns', '3ns', '10ns', '30ns', '1us', '10us', '30us', '100us']
    BASEDIR = "/Users/tjlane/Desktop/PL-workshop/pdb-depositions/"

    all_stats = []

    for it, timepoint in enumerate(TIMEPOINTS):
        data_dir = os.path.join(BASEDIR, f"{it+1}_{timepoint}")
        print(data_dir)
        stats = get_mtriage_stats(
            os.path.join(data_dir, f"{timepoint}_deposit.pdb"),
            os.path.join(data_dir, f"{timepoint}_deposit.mtz"),
        )
        all_stats.append(stats)

    df = pd.DataFrame(all_stats)
    print(df)
    df.to_csv("real_space_resolutions.csv")

    return


if __name__ == "__main__":
    main()