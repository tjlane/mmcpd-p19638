

import numpy as np
import gemmi as gm
import masks
import argparse

POLDER_CHAIN_A_MTZ = "/Users/tjlane/Desktop/pl-refinements/300ps/bond_testing/300ps_TT6_chainC_polder.mtz"
POLDER_CHAIN_B_MTZ = "/Users/tjlane/Desktop/pl-refinements/300ps/bond_testing/300ps_TT6_chainE_polder.mtz"


parser = argparse.ArgumentParser()
parser.add_argument('refine_mtz')
args = parser.parse_args()


refine_mtz = gm.read_mtz_file(args.refine_mtz)
fc_grid = refine_mtz.transform_f_phi_to_map('F-model', 'PHIF-model', sample_rate=3)
fc_chainA = masks.TT_chainA_region_only(fc_grid)
fc_chainB = masks.TT_chainB_region_only(fc_grid)


polder_mtz_A = gm.read_mtz_file(POLDER_CHAIN_A_MTZ)
polder_gridA = polder_mtz_A.transform_f_phi_to_map('mFo-DFc_polder', 'PHImFo-DFc_polder', exact_size=fc_grid.shape)
polder_chainA = masks.TT_chainA_region_only(polder_gridA)


polder_mtz_B = gm.read_mtz_file(POLDER_CHAIN_B_MTZ)
polder_gridB = polder_mtz_B.transform_f_phi_to_map('mFo-DFc_polder', 'PHImFo-DFc_polder', exact_size=fc_grid.shape)
polder_chainB = masks.TT_chainB_region_only(polder_gridB)


cc_a = np.corrcoef(
    np.array(fc_chainA, copy=True).flatten(),
    np.array(polder_chainA, copy=True).flatten()
)[0,1]

cc_b = np.corrcoef(
    np.array(fc_chainB, copy=True).flatten(),
    np.array(polder_chainB, copy=True).flatten()
)[0,1]

print(f'Chain A CC: {cc_a:02f}\t Chain B CC: {cc_b:02f}')
