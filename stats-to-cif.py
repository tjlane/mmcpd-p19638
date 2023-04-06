#!/usr/bin/env python

import argparse
import pandas as pd
from pprint import pprint


def print_authors():

    text="""loop_
_audit_author.name 
_audit_author.pdbx_ordinal 
_audit_author.identifier_ORCID 
'Lane, T.J.'	        1	0000-0003-2627-4432
'Christou, N.-E.'	    2	0000-0002-0177-8012
'Melo, D.V.M.'	        3	0000-0002-7417-3479
'Apostolopoulou, V.'	4	0009-0002-2773-4111
'Henkel, A.'	        5	0000-0002-9288-5373
'Sprenger, J.'	        6	0000-0001-7977-3484
'Oberthür, D.'	        7	0000-0002-0894-9590
'Gunther, S.'	        8	0000-0002-7329-6653
'Fadini, A.'	        9	0000-0001-5246-9124
'Pateras, A.'	        10	0000-0001-5642-7669
'Mashhour, A.R.'	    11	0000-0001-9177-5589
'Galchenkova, M.'	    12	0000-0001-5488-0160
'Yefanov, O.N.'	        13	0000-0001-8676-0091
'Reinke, P.Y.A.'	    14	0000-0002-7354-0839
'Kremling, V.'	        15	0000-0002-4877-2902
'Scheer, T.E.S.'	    16	0009-0000-2377-3127
'Lange, E.'	            17	
'Middendorf, P.'	    18	0000-0003-3590-3480
'Sellberg, J.A.'	    19	0000-0003-2793-5052
'Schubert, R.'	        20	0000-0002-6213-2872
'Bacellar, C.'	        21	0000-0003-2166-241X
'Cirelli, C.'	        22	0000-0003-4576-3805
'Beale, E.V.'	        23	0000-0002-7814-734X
'Johnson, P.'	        24	
'Dworkowski, F.'	    25	0000-0001-5004-8684
'Ozerov, D.'	        26	0000-0002-3274-1124
'Bertrand, Q.'	        27	0000-0003-3476-1775
'Wranik, M.'	        28	
'De Zitter, E.'	        29	0000-0001-6325-7354
'Turk, D.'	            30	0000-0003-0205-6609
'Bajt, S.'	            31	0000-0002-7163-7602
'Chapman, H.'	        32	0000-0002-4655-1743
    """
    print(text)
    return


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

            elif field == 'Rsplit (%)':
                value = sp[1].strip().split()
                overall_stats[field] = str( round( float(value[0]) / 100.0, 4 ) )

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

    # print('')
    # print('# --> insert this block near top of file')
    # print('')
    # print_authors()

    return


if __name__ == '__main__':
    main()
