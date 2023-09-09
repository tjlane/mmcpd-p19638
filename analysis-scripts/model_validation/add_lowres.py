
import argparse
import reciprocalspaceship as rs

CUTOFF = 5.0

parser = argparse.ArgumentParser()
parser.add_argument('phenix_mtz')
args = parser.parse_args()

phenix = rs.read_mtz(args.phenix_mtz)

dHKL = phenix.compute_dHKL()["dHKL"]
phenix.loc[dHKL < CUTOFF, '2FOFCWT'] = phenix.loc[dHKL < CUTOFF, '2FOFCWT_no_fill']
phenix.loc[dHKL < CUTOFF, 'PH2FOFCWT'] = phenix.loc[dHKL < CUTOFF, 'PH2FOFCWT_no_fill']

phenix.write_mtz(args.phenix_mtz[:-4] + '_filled.mtz')
