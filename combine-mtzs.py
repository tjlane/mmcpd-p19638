"""
combines 3 MTZs for submission:

    1. merged data from crystFEL
    2. star-aniso treated data
    3. extrapolated SFs

We also try to ingest and write the merging statistics
from crystFEL

Output: MTZ and mmCIF
"""


import os
import reciprocalspaceship as rs
import gemmi
import argparse
import subprocess

EXPECTED_COLUMNS = [
    'IMEAN',
    'SIGIMEAN',
    'F',
    'SIGF',
    'KFEXTR',
    'SIGKFEXTR',
    'F-model', 
    'PHIF-model',
    'R-free-flags',
    '2FOFCWT',
    'PH2FOFCWT',
    '2FOFCWT_no_fill',
    'PH2FOFCWT_no_fill',
    'FOFCWT',
    'PHFOFCWT',
]

# the value above which we do not fill
CUTOFF = 3.0

def mtz2cif(mtz_path, cif_path, id='xxxx'):
    """ unfortunately, we have to shell out to call this right now """
    cmd = [
        'gemmi',
        'mtz2cif',
        mtz_path,
        cif_path,
        '--spec=cif.spec',
        '--no-comments',
        f'--id={id}',
        '--block=reflections'
    ]
    subprocess.run(' '.join(cmd), shell=True)


def main():
    
    parser = argparse.ArgumentParser()
    parser.add_argument('staraniso_mtz')
    parser.add_argument('extrapolated_mtz')
    parser.add_argument('phenix_mtz')
    args = parser.parse_args()

    staraniso = rs.read_mtz(args.staraniso_mtz)
    extr = rs.read_mtz(args.extrapolated_mtz)
    phenix = rs.read_mtz(args.phenix_mtz)

    if not staraniso.spacegroup == gemmi.SpaceGroup('P 21 21 21'):
        print(f'changing spacegroup of {args.staraniso_mtz} from {staraniso.spacegroup} --> P 21 21 12')
        staraniso.spacegroup = gemmi.SpaceGroup('P 21 21 21')

    extr = extr.drop(columns=['FreeR_flag'])
    staraniso = staraniso.drop(columns=['E', 'SIGE', 'SA_flag', 'SIGNAL_value', 'SIGNAL_class'])
    phenix = phenix.drop(columns=['F-obs', 'SIGF-obs', 'F-obs-filtered', 'SIGF-obs-filtered'])

    # here: don't fill above CUTOFF angstroms
    # this prevents inappropriate filling of anisotropically trimmed HKLs
    dHKL = phenix.compute_dHKL()["dHKL"]
    phenix.loc[dHKL < CUTOFF, '2FOFCWT'] = phenix.loc[dHKL < CUTOFF, '2FOFCWT_no_fill']
    phenix.loc[dHKL < CUTOFF, 'PH2FOFCWT'] = phenix.loc[dHKL < CUTOFF, 'PH2FOFCWT_no_fill']

    combined = staraniso.join(extr, how='outer').dropna(how='all')
    combined = combined.join(phenix, how='outer').dropna(how='all')

    assert set(combined.columns) == set(EXPECTED_COLUMNS)

    mtz_ofn = 'combined.mtz'
    if os.path.exists(mtz_ofn):
        print(f'! warning, {mtz_ofn} exists')
    combined.write_mtz(mtz_ofn)
    print(f'Wrote: {mtz_ofn}')

    return

if __name__ == '__main__':
    main()
