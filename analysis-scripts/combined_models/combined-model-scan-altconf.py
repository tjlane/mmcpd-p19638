
"""
Logic:

Read two PDBs: one light, one dark

for all atoms in light model:
  1. scale occupancy

for dark model:
  1. for chains A, B, C, D, E, F:
       altlocs --> X,Y,Z
  2. else, just scale occupancy


"""

_ALT_LOC_IND = 16
_CHAIN_ID  = 21
_OCCUPANCY = slice(54, 59)

import re
import argparse
import subprocess
import numpy as np


def set_occupancy(pdb_text, occupancy):

    newlines = []

    for line in pdb_text.split('\n'):
        if line.startswith('ATOM') or line.startswith('HETATM'):
            newline = line[:54] + '  %.2f' % occupancy + line[60:]
            newlines.append(newline)

        # > no ANISOU records for now
        # > duplicate ANISOU seem to inflate R-factors by ~1%
        # elif line.startswith('ANISOU'):
        #     newlines.append(newline)

    return '\n'.join(newlines)


def remove_altconfs(pdb_file_text, set_altconf_to=" "):
    # set_altconf_to is the altconf of the final model, "A", "B", ...

    assert len(set_altconf_to) == 1

    subset_pdb = []

    for l in pdb_file_text.split('\n'):
        if l.startswith('ATOM') or l.startswith('HETATM') or l.startswith('ANISOU'):

            new_l = l[:_ALT_LOC_IND] + set_altconf_to + l[_ALT_LOC_IND+1:]

            if l[_ALT_LOC_IND] in [' ', 'A']:
                 subset_pdb.append(new_l)

        else:
            subset_pdb.append(l)

    return '\n'.join(subset_pdb)


def combine_pdbs(text1, text2):
    return text1.removesuffix('\nEND') + '\n' + text2


def get_rfactors(pdb_path, data_mtz_path):

    cmd = [
        'phenix.model_vs_data',
        pdb_path,
        data_mtz_path,
    ]

    r = subprocess.run(' '.join(cmd), shell=True, capture_output=True, text=True)

    g_work = re.search(r'r_work:\s+(\d+\.\d+)', r.stdout)
    g_free = re.search(r'r_free:\s+(\d+\.\d+)', r.stdout)

    r_work = float(g_work.group(1))
    r_free = float(g_free.group(1))

    return r_work, r_free


def get_rfactors_no_solvent(pdb_path, data_mtz_path):

    cmd = [
        'phenix.refine',
        pdb_path,
        data_mtz_path,
        'FDA.restraints.semirelaxed.cif',
        'TTD.restraints.cif',
        'main.bulk_solvent_and_scale=false',
        'main.number_of_macro_cycles=0',
        'refinement.pdb_interpretation.clash_guard.nonbonded_distance_threshold=None',
        '--overwrite',
    ]

    r = subprocess.run(' '.join(cmd), shell=True, capture_output=True, text=True)

    try:
        g_r = re.search(r'Final R-work = (\d+\.\d+), R-free = (\d+\.\d+)', r.stdout)
        r_work = float(g_r.group(1))
        r_free = float(g_r.group(2))
    except:
        print(r.stdout)
        return 0.0, 0.0

    return r_work, r_free


def main():

    parser = argparse.ArgumentParser()
    parser.add_argument('dark_pdb')
    parser.add_argument('light_pdb')
    parser.add_argument('data_mtz')
    args = parser.parse_args()

    fraction_light = list(np.arange(1,40) * 0.01) + [0.5, 0.6, 0.7, 0.8, 0.9]

    with open(args.dark_pdb, 'r') as f:
        dark_pdb_text = f.read()
    with open(args.light_pdb, 'r') as f:
        light_pdb_text = f.read()

    print('')
    print('l-oc\tr-work\tr-free')
    print('----\t------\t------')

    with open("rfactors.tsv", "w") as log:

        for fraction_light in fraction_light:

            model1 = remove_altconfs(dark_pdb_text, set_altconf_to="A")
            model2 = remove_altconfs(light_pdb_text, set_altconf_to="B")

            model1 = set_occupancy(model1, 1.0-fraction_light)
            model2 = set_occupancy(model2, fraction_light)

            combined_pdb_text = combine_pdbs(model1, model2)

            combined_pdb_path = 'combined_%.2f.pdb' % fraction_light
            with open(combined_pdb_path, 'w') as f:
                f.write(combined_pdb_text)

            r_work, r_free = get_rfactors(combined_pdb_path, args.data_mtz)

            log_string = '%.2f\t%.4f\t%.4f' % (fraction_light, r_work, r_free)
            print(log_string)
            log.write(log_string + '\n')

    return


if __name__ == '__main__':
    main()
