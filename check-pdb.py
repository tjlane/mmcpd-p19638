""" should be run at the last step before submission """

import argparse
from pprint import pprint


one_to_three = {'V':'VAL', 'I':'ILE', 'L':'LEU', 'E':'GLU', 'Q':'GLN', \
'D':'ASP', 'N':'ASN', 'H':'HIS', 'W':'TRP', 'F':'PHE', 'Y':'TYR',    \
'R':'ARG', 'K':'LYS', 'S':'SER', 'T':'THR', 'M':'MET', 'A':'ALA',    \
'G':'GLY', 'P':'PRO', 'C':'CYS'}


EXPECTED_RESIDUES = "ALA CYS ASP GLU PHE GLY HIS ILE LYS LEU MET ASN PRO GLN ARG SER THR VAL TRP TYR".split()
EXPECTED_RESIDUES += "DA DT DG DC".split()
EXPECTED_RESIDUES += [
    'TTD',
    'FDA',
    'SO4',
    'HOH',
]


EXPECTED_CHAINS = ["A", "B", "C", "D", "E", "F", "W"]


EXPECTED_LINK_RECORDS = [
    "LINK         O3'  DC C   6                 P   TTD C   7",
    "LINK         P    DC C   9                 O3' TTD C   7",
    "LINK         O3'  DC E   6                 P   TTD E   7",
    "LINK         P    DC E   9                 O3' TTD E   7",
]


# I added the C-terminal tag
mmCPD_uniprot = """
MIMNPKRIRALKSGKQGDGPVVYWMSRDQRAEDNWALLFSRAIAKEANVPVVVVFCLTDE
FLEAGIRQYEFMLKGLQELEVSLSRKKIPSFFLRGDPGEKISRFVKDYNAGTLVTDFSPL
RIKNQWIEKVISGISIPFFEVDAHNVVPCWEASQKHEYAAHTFRPKLYALLPEFLEEFPE
LEPNSVTPELSAGAGMVETLSDVLETGVKALLPERALLKNKDPLFEPWHFEPGEKAAKKV
MESFIADRLDSYGALRNDPTKNMLSNLSPYLHFGQISSQRVVLEVEKAESNPGSKKAFLD
EILIWKEISDNFCYYNPGYDGFESFPSWAKESLNAHRNDVRSHIYTLEEFEAGKTHDPLW
NASQMELLSTGKMHGYMRMYWAKKILEWSESPEKALEIAICLNDRYELDGRDPNGYAGIA
WSIGGVHDRAWGEREVTGKIRYMSYEGCKRKFDVKLYIEKYSALDKLAAALEHHHHHH"""

ttd_strand = [
    'DA',
    'DT',
    'DC',
    'DG',
    'DG',
    'DC',
    'TTD',
    'TTD',
    'DC',
    'DG',
    'DC',
    'DG',
    'DC',
    'DA'
 ]

comp_strand = [
    'DT',
    'DT',
    'DG',
    'DC',
    'DG',
    'DC',
    'DG',
    'DA',
    'DA',
    'DG',
    'DC',
    'DC',
    'DG',
    'DA'
 ]

SEQUENCE = {
    'A' : [ one_to_three[r] for r in mmCPD_uniprot if r != '\n' ],
    'B' : [ one_to_three[r] for r in mmCPD_uniprot if r != '\n' ],
    'C' : ttd_strand,
    'D' : comp_strand,
    'E' : ttd_strand,
    'F' : comp_strand,
}


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


def shift_sequence_numbering(pdb_file_text, chain, shift):
    newlines = []
    for l in pdb_file_text:
        if (l[_RECORD] in ['ATOM  ', 'ANISOU', 'HETATM']) and l[_CHAIN_ID].strip() == chain:
            new_num = int(l[_RESIDUE_NUMBER]) + shift
            new_l = l[:22] + f'{new_num}'.rjust(4) + l[26:]
            assert len(new_l) == len(l)
            newlines.append(new_l)
        else:
            newlines.append(l)
    return newlines


def make_water_chain(pdb_file_text, chain_name):

    running_water_counter = 0
    newlines = []

    for l in pdb_file_text:
        if l[_RECORD] == 'HETATM' and l[_RESIDUE_NAME] == 'HOH':
            running_water_counter += 1

            new_l = l[:20] + f' {chain_name}' + f'{running_water_counter}'.rjust(4) + l[26:]
            assert len(new_l) == len(l)
            newlines.append(new_l)

        else:
            newlines.append(l)

    return newlines


def check_chains(pdb_file_text):
    for l in pdb_file_text:
        if l[_RECORD].strip() in ['ATOM', 'HETATM']:
            assert l[_CHAIN_ID] in EXPECTED_CHAINS, l
    return


def check_atom_numbering(pdb_file_text):
    counter = 0
    for l in pdb_file_text:
        if l[_RECORD].strip() in ['ATOM', 'HETATM']:
            counter += 1
            assert int(l[_ATOM_NUMBER]) == counter, (counter, l)
    return


def check_for_ions(pdb_file_text):
    for l in pdb_file_text:
        if l[_RECORD] in ["ATOM  ", "HETATM"]:
            if l[_RESIDUE_NAME].strip() not in EXPECTED_RESIDUES:
                raise IOError(f'found unexpected residue: {l[_RESIDUE_NAME]}')
    return


def check_dna_termini(pdb_file_text):
    chains_to_check = ['C', 'D', 'E', 'F']
    for l in pdb_file_text:
        if l[_RECORD].strip() == 'ATOM' and l[_CHAIN_ID] in chains_to_check:
            if int(l[_RESIDUE_NUMBER]) == 1:
                assert l[_ATOM_NAME].strip() != 'P', l
    return


def check_sequence(pdb_file_text):
    # should also check numbering...

    for l in pdb_file_text:
        if l.startswith('ATOM'):

            chain = l[_CHAIN_ID]
            index = int(l[_RESIDUE_NUMBER])
            got = l[_RESIDUE_NAME].strip()

            if index > len(SEQUENCE[chain]):
                print(
                    '! extra residue in model (vs sequence)',
                    chain, index, got,
                )

            else:
                # regarding index: python zero indexing, but PDB 1 indexing!
                expected = SEQUENCE[chain][index-1]
                if expected == 'TTD':
                    expected = 'DT'
                if got != expected:
                    raise ValueError(
                        f'! sequence mismatch: chain={chain}, res={index}, got={got}, expected={expected}',
                    )

    return


def check_low_occupancy(pdb_file_text, cutoff=0.2):
    for l in pdb_file_text:
        if l[_RECORD] in ["ATOM  ", "HETATM"]:
            if float(l[_OCCUPANCY]) < cutoff:
                raise ValueError(f'occupancy < {cutoff}', l)
            elif float(l[_OCCUPANCY]) != 1:
                print('check occupancy, not 1:', l.strip()) 
    return


def check_link_records(pdb_file_text):
    for lr in EXPECTED_LINK_RECORDS:
        if lr not in [l.strip() for l in pdb_file_text]:
            pprint('if this is a T<>T model, add LINK records:')
            for r in EXPECTED_LINK_RECORDS:
                print(r)
                return
            # raise ValueError(f'missing link: {lr}')
    return


def main():

    parser = argparse.ArgumentParser()
    parser.add_argument('initial_pdb')
    parser.add_argument('--no-shift-prot', action='store_true', default=False)
    parser.add_argument('--no-shift-dna', action='store_true', default=False)
    args = parser.parse_args()

    with open(args.initial_pdb, 'r') as f:
        pdb_file_text = f.readlines()

    if not args.no_shift_prot:
        pdb_file_text = shift_sequence_numbering(pdb_file_text, 'A', 1)
        pdb_file_text = shift_sequence_numbering(pdb_file_text, 'B', 1)

    if not args.no_shift_dna:
        pdb_file_text = shift_sequence_numbering(pdb_file_text, 'D', 1)
        pdb_file_text = shift_sequence_numbering(pdb_file_text, 'F', 1)

    pdb_file_text = make_water_chain(pdb_file_text, 'W')
    check_for_ions(pdb_file_text)
    check_dna_termini(pdb_file_text)
    check_sequence(pdb_file_text)

    check_chains(pdb_file_text)
    #check_atom_numbering(pdb_file_text)
    check_low_occupancy(pdb_file_text)
    check_link_records(pdb_file_text)

    final_pdb_path = args.initial_pdb[:-4] + '_checked.pdb'
    with open(final_pdb_path, 'w') as f:
        f.writelines(pdb_file_text)

    print('checks passed')
    print(f'{args.initial_pdb} --> {final_pdb_path}')

    return


if __name__ == '__main__':
    main()
