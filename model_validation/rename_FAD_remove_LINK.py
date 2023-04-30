import argparse
from pathlib import Path
from pprint import pprint

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


def rename_FAD(pdb_file_text):

    newlines = []

    for l in pdb_file_text.split('\n'):
        if l[_RESIDUE_NAME] == 'FAD':
            newlines.append( l[:17] + 'FDA' + l[20:] )
        else:
            newlines.append(l)

    return '\n'.join(newlines)


def remove_links(pdb_file_text):

    newlines = []

    for l in pdb_file_text.split('\n'):
        if l[_RECORD].startswith('LINK'):
            print('not including:')
            pprint(l, width=84)
        else:
            newlines.append(l)

    return '\n'.join(newlines)


def main():

    parser = argparse.ArgumentParser()
    parser.add_argument('pdb')
    args = parser.parse_args()

    print('reading:', args.pdb)
    with open(args.pdb, 'r') as f:
        pdb_text = f.read()

        print('... renaming FAD -> FDA')
        pdb_text = rename_FAD(pdb_text)

        print('... removing LINK records')
        pdb_text = remove_links(pdb_text)

    output_fn = str(Path(args.pdb).stem) + '_fda_nolink.pdb'
    print(f'WRITING: {output_fn}')
    with open(output_fn, 'w') as f:
        f.write(pdb_text)

    print('done.')

    return


if __name__ == '__main__':
    main()
