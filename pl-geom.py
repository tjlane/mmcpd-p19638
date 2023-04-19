"""
* FAD bend
* TT planarity
* C5/C5 and C6/C6 distances

note on strategy:
  first, sort into TTD/TT6 vs split
  get atoms accordingly
  then, it's easy
  for FAD, think

note on chains:
  everything is chain A + C
  to change, search "chainid"

"""

import numpy as np
import mdtraj as md
import pandas as pd
import argparse


THYMINE_RING_ATOMS = ["N1", "C2", "N3", "C4", "C5", "C6"]
FAD_BENZENE = ["C6", "C7", "C8", "C9", "C9A", "C5X"]
FAD_PYRIMIDINE = ["C4X", "C10", "N1", "C2", "N3", "C4"]


def plane_from_points(xyz):

    # barycenter of the points
    G = xyz.sum(axis=0) / xyz.shape[0]

    # run SVD
    _, _, vh = np.linalg.svd(xyz - G)

    # unitary normal vector
    normal_vector = vh[2, :]

    return normal_vector


def angle_between_vectors(v1, v2):
    ndp = np.dot(v1, v2) / (np.linalg.norm(v1) * np.linalg.norm(v2))
    angle = np.degrees(np.arccos(ndp))
    return angle


def TT_angle(trj):

    atom_sele = 'name ' + ' or name '.join(THYMINE_RING_ATOMS)
    atom_sele += ' or name ' + ' or name '.join([atom_name + 'T' for atom_name in THYMINE_RING_ATOMS])

    selection = f'(chainid 3) and ((resSeq 7) or (resSeq 8)) and ({atom_sele})'
    sele = trj.top.select(selection)
    assert len(sele) == 6 * 2, len(sele)

    xyz = trj.xyz[0,sele,:]

    p1 = plane_from_points(xyz[:6])
    p2 = plane_from_points(xyz[6:])

    angle = angle_between_vectors(p1, p2)
    if angle > 90.0:
        angle = angle_between_vectors(-p1, p2)

    assert angle > 0.0
    assert angle < 90.0

    return angle


def bond_distances(trj, carbon_index):

    atom_sele = f'name C{carbon_index} or name C{carbon_index}T'
    selection = f'(chainid 3) and ((resSeq 7) or (resSeq 8)) and ({atom_sele})'

    sele = trj.top.select(selection)
    assert len(sele) == 2, len(sele)

    xyz = trj.xyz[0,sele,:]
    dist = np.linalg.norm(xyz[0,:] - xyz[1,:]) * 10.0 # mdtraj uses nm

    return dist


def FAD_ring_angle(trj):

    xyzs = []

    for atoms in [FAD_BENZENE, FAD_PYRIMIDINE]:

        atom_sele = 'name ' + ' or name '.join(atoms)
        selection = f'(chainid 0) and (resname FDA) and ({atom_sele})'
        sele = trj.top.select(selection)
        assert len(sele) == 6, len(sele)

        xyz = trj.xyz[0,sele,:]
        xyzs.append(xyz)

    p1 = plane_from_points(xyzs[0])
    p2 = plane_from_points(xyzs[1])

    angle = angle_between_vectors(p1, p2)
    if angle > 90.0:
        angle = angle_between_vectors(-p1, p2)

    assert angle > 0.0
    assert angle < 90.0

    return angle


def test():
    xyz = np.array([[0., 0., 0.],
                    [1., 0., 0.],
                    [0., 1., 0.],
                    [1., 1., 0.]])

    assert np.all(plane_from_points(xyz) == np.array([0., 0., 1.]))

    assert angle_between_vectors([1, 0, 0], [0, 2, 0]) == 90.0
    assert angle_between_vectors([3, 0, 0], [1, 0, 0]) == 0.0
    assert angle_between_vectors([3, 0, 0], [-1, 0, 0]) == 180.0


def example():
    trj = md.load_pdb('./pltest.pdb')
    print(TT_angle(trj))
    print(bond_distances(trj, '5'))
    print(bond_distances(trj, '6'))
    print(FAD_ring_angle(trj))


def main():

    ap = argparse.ArgumentParser()
    ap.add_argument('pdbfiles', type=str, nargs='+')
    args = ap.parse_args()

    print(args)

    rows = []
    for path in args.pdbfiles:
        trj = md.load_pdb(path)
        rows.append({
            'filename' : path,
            'C5-C5 dist' : bond_distances(trj, '5'),
            'C6-C6 dist' : bond_distances(trj, '5'),
            'TTD angle' : TT_angle(trj),
            'FAD angle' : FAD_ring_angle(trj),
        })

    print(pd.DataFrame(rows))

    return


if __name__ == "__main__":
    main()