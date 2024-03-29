
"""
Need to read in two PDBs: one light, one dark, and then write out a "super" PDB
of them cat'd together, but each with their occupancies multiplied by a
specific faction.

Then, run phenix.model_vs_data and grep R-factors out of the result.
"""

_ALT_LOC_IND = 16
_CHAIN_ID  = 21
_OCCUPANCY = slice(54, 59)

import re
import argparse
import subprocess


def change_occupancy_by_multiple(pdb_text, fraction):

    newlines = []

    for line in pdb_text.split('\n'):
        if line.startswith('ATOM') or line.startswith('HETATM'):
            old_occupancy = float(line[_OCCUPANCY])
            new_occupancy = old_occupancy * fraction
            newline = line[:54] + '  %.2f' % new_occupancy + line[60:]
            newlines.append(newline)

    return '\n'.join(newlines)


def chain_remap(pdb_text, mapping={'A':'H', 'B':'I', 'C':'J', 'D':'K', 'E':'L', 'F':'M', 'G':'N', 'W':'X'}):

    newlines = []

    for line in pdb_text.split('\n'):
        if line.startswith('ATOM') or line.startswith('HETATM'):
            new_chain = mapping[line[_CHAIN_ID]]
            newline = line[:21] + new_chain + line[22:]
            newlines.append(newline)
        else:
            newlines.append(newline)

    return '\n'.join(newlines)


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

    fractions_dark = [1.00, 0.99, 0.98, 0.97, 0.96, 0.95, 0.94, 0.93,
                      0.92, 0.91, 0.9, 0.88, 0.86, 0.84, 0.82, 0.8,
                      0.7, 0.6, 0.5, 0.25, 0.0]

    with open(args.dark_pdb, 'r') as f:
        dark_pdb_text = f.read()
    with open(args.light_pdb, 'r') as f:
        light_pdb_text = f.read()

    print('')
    print('occu\tr-work\tr-free')
    print('----\t------\t------')

    for fraction_dark in fractions_dark:

        pt1 = change_occupancy_by_multiple(dark_pdb_text, fraction_dark)
        pt2 = change_occupancy_by_multiple(light_pdb_text, 1.0-fraction_dark)
        pt2 = chain_remap(pt2)
        combined_pdb_text = combine_pdbs(pt1, pt2)

        combined_pdb_path = 'combined_%.2f.pdb' % fraction_dark
        with open(combined_pdb_path, 'w') as f:
            f.write(combined_pdb_text)

        r_work, r_free = get_rfactors(combined_pdb_path, args.data_mtz)

        print('%.2f\t%.4f\t%.4f' % (fraction_dark, r_work, r_free))

    return


if __name__ == '__main__':
    main()
