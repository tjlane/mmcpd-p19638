
import os
import sys
import pandas as pd
from tabulate import tabulate
from glob import glob

#pd.set_option('display.float_format', lambda x: '%.03f' % x)
pd.set_option('display.max_colwidth', None)


STATS_FILES = [
    ('SNR.dat', None),
    ('CC.dat', 'CC'),
    ('CCstar.dat', 'CC*'),
    ('Rsplit.dat', 'Rsplit/%'),
]


def to_fwf(df, fname):
    content = tabulate(df.values.tolist(), list(df.columns), tablefmt="plain")
    open(fname, "w").write(content)


def main():

    wd = sys.argv[-1]

    for sf_ending, col in STATS_FILES:

        sf = glob(os.path.join(wd, '*' + sf_ending))

        if len(sf) != 1:
            raise RuntimeError(f'ambiguous seach for stats file: {sf}')
        else:
            sf = sf[0]

        if sf_ending == 'SNR.dat':
            master_df = pd.read_table(sf, delimiter='\s+', skiprows=1)
            master_df.columns = ['1/d centre', '# refs', 'Possible', 'Compl', 'No. Meas', 'Redundancy', 'SNR', 'Std dev', 'Mean', 'd(A)', 'Min 1/nm', 'Max 1/nm']

        else:
            df = pd.read_table(sf, delimiter='\s+', skiprows=1, usecols=(0,1))
            df.columns = ['1/d centre', col]
            master_df = master_df.merge(df, on='1/d centre', how='left')

    # reorder columns into a more sensible format
    master_df = master_df[
        ['1/d centre', 'd(A)', 'Min 1/nm', 'Max 1/nm', 
        '# refs', 'Possible', 'Compl', 'No. Meas', 'Redundancy',
        'Mean', 'Std dev', 'SNR',
        'CC', 'CC*', 'Rsplit/%']
    ]

    #master_df.to_csv('table1.csv', sep='\t')
    print(master_df)
    #to_fwf(master_df, 'table1.txt')
    with open('table1.txt', 'w') as f:
        print(master_df, file=f)
    print('wrote --> "table1.txt"')

    return


if __name__ == '__main__':
    main()
