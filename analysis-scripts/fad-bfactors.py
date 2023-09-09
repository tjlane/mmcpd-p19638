"""
* FAD bend
* TT planarity
* C5/C5 and C6/C6 distances

note on strategy:
  first, sort into TTD/TT6 vs split
  get atoms accordingly
  then, it's easy
  for FAD, think

note on chains:
  everything is chain A + C
  to change, search "chainid"

"""

import numpy as np
import mdtraj as md
import pandas as pd
import argparse
from natsort import natsorted

# --- PDB slices for ATOM and HETATM records
# https://www.cgl.ucsf.edu/chimera/docs/UsersGuide/tutorials/pdbintro.html
_RECORD         = slice( 0,  6)
_ATOM_NUMBER    = slice( 6, 11)
_ATOM_NAME      = slice(11, 16)
_ALT_LOC_IND    =       16
_RESIDUE_NAME   = slice(17, 20)
_CHAIN_ID       =       21
_RESIDUE_NUMBER = slice(22, 26)
_COORDINATES    = slice(31, 54)
_OCCUPANCY      = slice(54, 59)
_BFACTOR        = slice(60, 65)

FAD_ISOALLOX = ["C6", "C7", "C8", "C9", "C9A", "C5X", "C4X", "C10", "N1", "C2", "N3", "C4", "N5", "N10", "O2", "O4", "C7M", "C8M"]
ADENINE = ["N1A", "N3A", "N7A", "N9A", "C2A", "C4A", "C5A", "C6A", "C8A"]


def compute_fad_bfactors(pdb_string):

    isoallox_sum = 0.0
    adenine_sum = 0.0

    for l in pdb_string.split('\n'):
        if (l[_RECORD].startswith("HETATM")) and (l[_RESIDUE_NAME] == 'FDA') and (l[_CHAIN_ID] == "A"):
            if l[_ATOM_NAME].strip() in FAD_ISOALLOX:
                isoallox_sum += float(l[_BFACTOR])
            elif l[_ATOM_NAME].strip() in ADENINE:
                adenine_sum += float(l[_BFACTOR])

    return isoallox_sum / float(len(FAD_ISOALLOX)), adenine_sum / float(len(ADENINE))


def compute_residue_bfactors(pdb_string, resname: str, resatoms=None, chain="A", resnum=None):

    b_sum = 0.0
    n_atoms = 0

    for l in pdb_string.split('\n'):
        if (l[_RECORD].startswith("HETATM") or l[_RECORD].startswith("ATOM")) and (l[_RESIDUE_NAME] == resname) and (l[_CHAIN_ID] == chain):

            if resnum:
                if int(l[_RESIDUE_NUMBER]) != int(resnum):
                    continue

            if resatoms:
                if l[_ATOM_NAME].strip() in resatoms:
                    b_sum += float(l[_BFACTOR])
                    n_atoms += 1
            else:
                b_sum += float(l[_BFACTOR])
                n_atoms += 1

    if resatoms:
        assert n_atoms == len(resatoms)

    return b_sum / float(n_atoms)


def main():

    ap = argparse.ArgumentParser()
    ap.add_argument('pdbfiles', type=str, nargs='+')
    args = ap.parse_args()

    rows = []
    for path in natsorted(args.pdbfiles):

        with open(path, 'r') as f:
            pdb_string = f.read()
            payload = {
                'file': path,
                'isoallox': compute_residue_bfactors(pdb_string, "FDA", resatoms=FAD_ISOALLOX),
                'adenine': compute_residue_bfactors(pdb_string, "FDA", resatoms=ADENINE),
                'Tyr376': compute_residue_bfactors(pdb_string, "TYR", resnum=376),
                'Ile491': compute_residue_bfactors(pdb_string, "ILE", resnum=419),
            }
        rows.append(payload)

    df = pd.DataFrame(rows)
    df.to_csv('pl-bfactors.csv')
    print(df)
    print('wrote --> pl-bfactors.csv')

    return


if __name__ == "__main__":
    main()
