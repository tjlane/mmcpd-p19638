
import numpy as np
import gemmi as gm


def mask_map(
    map_grid : gm.FloatGrid,
    position : np.array,
    r : float) -> gm.FloatGrid:

    mask = map_grid.clone()

    mask.fill(0)
    mask.set_points_around(gm.Position(position[0], position[1], position[2]), radius=r, value=1)
    mask.symmetrize_max()
    
    return gm.FloatGrid( np.array(map_grid, copy=True) * np.array(mask, copy=True) )


def mask_solvent(
        pdb_path : str, 
        map_grid : gm.FloatGrid) -> gm.FloatGrid:

    st = gm.read_structure(pdb_path)
    
    masker = gm.SolventMasker(gm.AtomicRadiiSet.Cctbx)

    # Ali's masker
    #masker         = gm.SolventMasker(gm.AtomicRadiiSet.Constant, 1.5)
    #masker.rprobe  = 0.9
    #masker.rshrink = 1.1

    mask = map_grid.clone()
    masker.put_mask_on_float_grid(mask, st[0])

    return gm.FloatGrid( np.array(map_grid, copy=True) * np.array(mask, copy=True) )


def grid_to_PL_map(grid : gm.FloatGrid, map_file_name : str) -> None:
    ccp4 = gm.Ccp4Map()
    ccp4.grid = grid
    ccp4.grid.unit_cell.set(70.2, 117.76, 170.47, 90, 90, 90)
    ccp4.grid.spacegroup = gm.SpaceGroup('P212121')
    ccp4.update_ccp4_header()
    ccp4.write_ccp4_map(map_file_name)
    return


def TT_chainA_region_only(grid : gm.FloatGrid) -> gm.FloatGrid:
    TTD_O4R_XYZ = np.array([24.771, 12.083,   6.837]) 
    radius = 8.0
    masked_grid = mask_map(grid, TTD_O4R_XYZ, radius)
    return masked_grid


def TT_chainB_region_only(grid : gm.FloatGrid) -> gm.FloatGrid:
    TTD_O4R_XYZ = np.array([17.872, -17.329, -36.986]) 
    radius = 8.0
    masked_grid = mask_map(grid, TTD_O4R_XYZ, radius)
    return masked_grid


def FDA_chainA_region_only(grid : gm.FloatGrid) -> gm.FloatGrid:
    FAD_N10_XYZ = np.array([16.950, 14.541,  -3.135])
    radius = 6.5
    masked_grid = mask_map(grid, FAD_N10_XYZ, radius)
    return masked_grid


def FDA_and_TT_chainA_region_only(grid : gm.FloatGrid) -> gm.FloatGrid:
    FAD_N6A_XYZ = np.array([21.113, 14.578,  -0.602])
    radius = 11.0
    masked_grid = mask_map(grid, FAD_N6A_XYZ, radius)
    return masked_grid


if __name__ == '__main__':

    pdb_file = '/Users/tjlane/Desktop/PL-workshop/DEDs-svd/Super_dark_swissFEL_refine_33.pdb'
    mtz_file = '/Users/tjlane/Desktop/PL-workshop/DEDs-svd/3ps_LIGHT_staraniso_unityDO_Rfree_mkFoFo.mtz'

    F   = 'KFOFOWT'
    PHI = 'PHIKFOFOWT'

    mtz = gm.read_mtz_file(mtz_file)
    grid = mtz.transform_f_phi_to_map(F, PHI, sample_rate=3)

    #masked_grid = TT_chainA_region_only(grid)
    #masked_grid = FDA_chainA_region_only(grid)
    #masked_grid = FDA_and_TT_chainA_region_only(grid)
    masked_grid = mask_solvent(pdb_file, grid)

    grid_to_PL_map(masked_grid, 'masked.ccp4')

