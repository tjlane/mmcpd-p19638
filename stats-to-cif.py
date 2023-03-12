
import argparse
import pandas as pd
from pprint import pprint


def parse_overall_stats(path):

    overall_stats = {}

    with open(path, 'r') as f:
        for l in f:

            sp = l.split(';')
            field = sp[0]

            if field == 'Resolution':
                value = sp[1].strip().split()
                overall_stats['res_low']  = value[0]
                overall_stats['res_high'] = value[2]

            elif len(sp) > 1:
                value = sp[1].strip().split()
                if len(value) > 0:
                    overall_stats[field] = value[0]

    return overall_stats


def main():

    parser = argparse.ArgumentParser()
    parser.add_argument('summary')
    parser.add_argument('by_shell')
    args = parser.parse_args()


    ov_st = parse_overall_stats(args.summary)

    overall_statistics = """_reflns.pdbx_diffrn_id 1
_reflns.d_resolution_low {0[res_low]}
_reflns.d_resolution_high {0[res_high]}
_reflns.pdbx_number_measured_all {0[Total Measurements]}
_reflns.number_obs {0[Unique Reflections]}
_reflns.pdbx_netI_over_sigmaI {0[SNR]}
_reflns.percent_possible_obs {0[Completeness (%)]}
_reflns.pdbx_redundancy {0[Multiplicity]}
_reflns.pdbx_CC_half {0[CC1/2]}
_reflns.pdbx_CC_star {0[CC*]}
_reflns.pdbx_R_split {0[Rsplit (%)]}""".format(ov_st)
    
    print('')
    print('# --> insert this block below any other _reflns.* entry')
    print('')
    print(overall_statistics)

    column_order = ['Min 1/nm', 'Max 1/nm', 'Possible', 'refs', 'Compl', 'Redundancy', 'SNR', 'CC', 'CC*', 'Rsplit/%']
    transformations = [
        lambda x : round(10.0 / x, 4),
        lambda x : round(10.0 / x, 4),
        int,
        int,
        lambda x : x,
        lambda x : x,
        lambda x : x,
        lambda x : x,
        lambda x : x,
        lambda x : round(x / 100.0, 3),
    ]

    loop_header="""loop_
  _reflns_shell.pdbx_ordinal
  _reflns_shell.d_res_low
  _reflns_shell.d_res_high
  _reflns_shell.number_unique_all
  _reflns_shell.number_unique_obs
  _reflns_shell.percent_possible_all
  _reflns_shell.pdbx_redundancy
  _reflns_shell.meanI_over_sigI_obs
  _reflns_shell.pdbx_CC_half
  _reflns_shell.pdbx_CC_star
  _reflns_shell.pdbx_R_split"""

    assert len(column_order) == len(transformations)
    assert len(column_order) == len(loop_header.split('\n')) - 2, len(loop_header.split('\n'))

    print('')
    print('# --> insert this block most anywhere')
    print('')
    print(loop_header)

    df = pd.read_fwf(args.by_shell).drop(columns=['Unnamed: 0', '1/d', '#'])
    for i,row in df.iterrows():
        row_data = row[column_order]
        print(' ', i, ' '.join([str( transformations[i](x) ) for i,x in enumerate(row_data)]))

    return


if __name__ == '__main__':
    main()
