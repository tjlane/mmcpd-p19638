

import os
import re
import numpy as np
import argparse
import subprocess
import shutil
import multiprocessing as mp

TEST_MODE = False


def run_paired_refinement(args):

    print(args)
    pdb, mtz, ttdcif, fadcif, r_free_mtz, evaluated_resolutions, rescut = args

    name, resulting_pdb_path, ref_mtz = run_refinement(pdb, mtz, ttdcif, fadcif, r_free_mtz, rescut)

    rfactor_table = []

    for res in evaluated_resolutions:
        r_work, r_free = get_rfactors(resulting_pdb_path, ref_mtz, res)
        rfactor_table.append([res, r_work, r_free])

    np.savetxt(f'{name}_refined{rescut}_rfactor_table.tsv', rfactor_table, fmt="%.3f")

    return


def run_refinement(pdb, mtz, ttdcif, fadcif, r_free_mtz, rescut):

    if TEST_MODE:
        num_cycles = 0
    else:
        num_cycles = 5

    name = os.path.basename(pdb).split("_")[0]

    pdb = os.path.abspath(pdb)
    mtz = os.path.abspath(mtz)
    ttdcif = os.path.abspath(ttdcif)
    fadcif = os.path.abspath(fadcif)
    r_free_mtz = os.path.abspath(r_free_mtz)

    current_dir = os.curdir
    working_dir = f"{name}-paired-ref-res{rescut}"

    if os.path.exists(working_dir):
        shutil.rmtree(working_dir)

    os.mkdir(working_dir)
    os.chdir(working_dir)

    cmd = f"""phenix.refine \
{pdb} \
{mtz} \
{fadcif} {ttdcif} \
xray_data.r_free_flags.file_name={r_free_mtz} \
xray_data.labels="KFEXTR,SIGKFEXTR" \
main.number_of_macro_cycles={num_cycles} \
refinement.refine.strategy=individual_sites+tls+individual_adp+occupancies \
refinement.refine.adp.tls="chain 'A' or chain 'C' or chain 'D'" \
refinement.refine.adp.tls="chain 'B' or chain 'F' or chain 'E'" \
xray_data.high_resolution={rescut} \
hydrogens.refine=riding main.nqh_flips=False --overwrite > phenix.log 2>&1
"""

    try:
        subprocess.call(cmd, shell=True)
        resulting_pdb_path = os.path.abspath(f"{name}_deposit_refine_001.pdb")
    except Exception as e:
        print(e)
    finally:
        os.chdir(current_dir)

    assert os.path.exists(resulting_pdb_path)

    return name, resulting_pdb_path, mtz


def get_rfactors(pdb_path, data_mtz_path, rescut):

    cmd = [
        'phenix.model_vs_data',
        pdb_path,
        data_mtz_path,
        f'high_res={rescut}'
    ]

    print(cmd)

    r = subprocess.run(' '.join(cmd), shell=True, capture_output=True, text=True)

    g_work = re.search(r'r_work:\s+(\d+\.\d+)', r.stdout)
    g_free = re.search(r'r_free:\s+(\d+\.\d+)', r.stdout)

    r_work = float(g_work.group(1))
    r_free = float(g_free.group(1))

    return r_work, r_free


def main():

    parser = argparse.ArgumentParser(description='Description of your program')
    parser.add_argument('-p', '--pdb', required=True)
    parser.add_argument('-m', '--mtz', required=True)
    parser.add_argument('-c', '--ttdcif', default="/Users/tjlane/Desktop/PL-workshop/pl-refinements/TTD.restraints.cif")
    parser.add_argument('-d', '--fadcif', default="/Users/tjlane/Desktop/PL-workshop/pl-refinements/FDA.restraints.semirelaxed.cif")
    parser.add_argument('-f', '--rfree', default="/Users/tjlane/Desktop/PL-workshop/pl-refinements/Rfree_DO_refine44.mtz")
    args = parser.parse_args()

    if TEST_MODE:
        rescuts = [2.0, 3.0]
    else:
        rescuts = np.linspace(2.0, 3.0, 11)

    evaluated_resolutions = rescuts

    static_args = [args.pdb, args.mtz, args.fadcif, args.ttdcif, args.rfree, evaluated_resolutions]
    jobs_to_run = [static_args + [rescut] for rescut in rescuts]

    with mp.Pool(len(jobs_to_run)) as pool:
        pool.map(run_paired_refinement, jobs_to_run)

    return


if __name__ == "__main__":
    main()
