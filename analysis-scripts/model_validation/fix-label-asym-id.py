
import sys

chain_to_asym_id = {
    'C' : 'F',
    'D' : 'G',
    'E' : 'H',
    'F' : 'I',
    'W' : 'J',
}

CHAIN_IDX = 5
ASYM_IDX  = 15

cif_lines = []
in_atom_loop = False

input_file = sys.argv[-1]

with open(input_file, 'r') as f:

    for line in f:

        if line.startswith('   ATOM') or line.startswith('   HETATM'):

            split_line = line.split()
            chain_id = split_line[CHAIN_IDX]

            if chain_id in chain_to_asym_id.keys():
                split_line[ASYM_IDX] = chain_to_asym_id[chain_id]

            updated_line = '   ' + ' '.join(split_line) + '\n'
            cif_lines.append(updated_line)

        else:
            cif_lines.append(line)

output_file = 'fixed.cif'
with open(output_file, 'w') as f:
    f.writelines(cif_lines)

print(input_file, '-->', output_file)
