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

EXPECTED_COLUMNS = ['IMEAN', 'SIGIMEAN', 'F', 'SIGF', 'KFEXTR', 'SIGKFEXTR', 'FreeR_flag']


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
    args = parser.parse_args()

    staraniso = rs.read_mtz(args.staraniso_mtz)
    extr = rs.read_mtz(args.extrapolated_mtz)

    if not staraniso.spacegroup == gemmi.SpaceGroup('P 21 21 21'):
        print(f'changing spacegroup of {args.staraniso_mtz} from {staraniso.spacegroup} --> P 21 21 12')
        staraniso.spacegroup = gemmi.SpaceGroup('P 21 21 21')

    staraniso = staraniso.drop(columns=['E', 'SIGE', 'SA_flag', 'SIGNAL_value', 'SIGNAL_class'])
    staraniso = staraniso.join(extr, check_isomorphous=False).dropna(how='all')

    assert set(staraniso.columns) == set(EXPECTED_COLUMNS)

    mtz_ofn = 'combined.mtz'
    cif_ofn = 'combined.cif'

    if os.path.exists(mtz_ofn):
        print(f'! warning, {mtz_ofn} exists')
    staraniso.write_mtz(mtz_ofn)
    print(f'Wrote: {mtz_ofn}')

    if os.path.exists(cif_ofn):
        print(f'! warning, {cif_ofn} exists')
    mtz2cif(mtz_ofn, cif_ofn)
    print(f'Wrote: {cif_ofn}')

    return

if __name__ == '__main__':
    main()
