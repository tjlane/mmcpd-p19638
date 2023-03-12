
import os
import sys
import pandas as pd
from glob import glob


STATS_FILES = [
    ('SNR.dat', None),
    ('CC.dat', 'CC'),
    ('CCstar.dat', 'CC*'),
    ('Rsplit.dat', 'Rsplit/%'),
]


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

    master_df.to_csv('table1.csv')
    print(master_df)
    print('wrote --> "table1.csv"')

    return


if __name__ == '__main__':
    main()
