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
FAD_AXIS = ["N5", "N10"]

NINA_DISTS = [
    ["C", "T8", "O4", "A", "FDA", "N6A",],
    ["A", "R256", "NH1", "C", "T8", "O2T",],
    ["A", "R256", "NH1", "C", "T8", "O2",],
    ["A", "E301", "OE1", "C", "T7", "N3",],
    ["A", "E301", "OE2", "C", "T8", "O4",],
    ["A", "E301", "OE2", "C", "T8", "O4T",],
    ["A", "N257", "OD1", "A", "R256", "NH1",],
    ["A", "FDA", "N5", "A", "N403", "OD1",],
    ["A", "FDA", "O4", "A", "N403", "ND2",],
    ["A", "G415", "CA", "A", "FDA", "N5",],
    ["A", "R378", "NH1", "A", "FDA", "N5",],
    ["A", "N403", "OD1", "A", "FDA", "N5",],
    ["A", "R378", "NH1", "A", "D407", "OE2",],
    ["A", "R378", "NH1", "A", "D409", "OD2",],
    ["A", "D409", "OD2", "A", "R378", "NH2",],
]


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
    
    selection = f'((chainid 2) or (chainid 3)) and ((resname TTD) or (resname TT6)) and ({atom_sele})'
    sele = trj.top.select(selection)

    if len(sele) == 0:
        selection = f'(chainid 2) and ((resSeq 7) or (resSeq 8)) and ({atom_sele})'
        sele = trj.top.select(selection)
    if len(sele) == 0:
        selection = f'(chainid 3) and ((resSeq 7) or (resSeq 8)) and ({atom_sele})'
        sele = trj.top.select(selection)

    #print([trj.top.atom(ai) for ai in sele])
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


def ttd_bond_distances(trj, carbon_index):

    atom_sele = f'name C{carbon_index} or name C{carbon_index}T'
    selection = f'((chainid 2) or (chainid 3)) and ((resname TTD) or (resname TT6)) and ({atom_sele})'
    sele = trj.top.select(selection)

    if len(sele) == 0:
        selection = f'(chainid 2) and (resSeq 7 or resSeq 8) and ({atom_sele})'
        sele = trj.top.select(selection)

    if len(sele) == 0:
        selection = f'(chainid 3) and (resSeq 7 or resSeq 8) and ({atom_sele})'
        sele = trj.top.select(selection)

    #print([trj.top.atom(ai) for ai in sele])
    assert len(sele) == 2, len(sele)

    xyz = trj.xyz[0,sele,:]
    dist = np.linalg.norm(xyz[0,:] - xyz[1,:]) * 10.0 # mdtraj uses nm

    return dist


def generic_distance(trj, chain1, res1, name1, chain2, res2, name2):

    chain_map = {
        'A': '(chainid 0)',
        'C': '((chainid 2) or (chainid 3))'
    }

    xyzs = []

    for chain, res, name in [[chain1, res1, name1], [chain2, res2, name2]]:

        if res.startswith('T'):
            atom_sele = f'(name {name}) and (resname DT) and (resSeq {res[1:]}) and ' + chain_map[chain]
            if len(trj.top.select(atom_sele)) == 0:
                atom_sele = f'(name {name}) and (resname TTD) and (resSeq 7) and ' + chain_map[chain]
            if len(trj.top.select(atom_sele)) == 0:
                atom_sele = f'(name {name}) and (resname TT6) and (resSeq 7) and ' + chain_map[chain]

        elif res == 'FDA':
            atom_sele = f'(name {name}) and (resname FDA) and ' + chain_map[chain]
        else:
            atom_sele = f'(name {name}) and (resSeq {res[1:]}) and ' + chain_map[chain]

        sele = trj.top.select(atom_sele)

        if len(sele) == 0:
            #print(atom_sele, sele)
            return -1
        assert len(sele) == 1, sele

        xyzs.append(trj.xyz[0,sele,:])

    dist = np.linalg.norm(xyzs[0] - xyzs[1]) * 10.0 # mdtraj uses nm

    return dist


def FAD_ring_angle(trj):

    xyzs = []

    expected_atoms = [2, 8, 8]
    for i,atoms in enumerate([[], FAD_BENZENE, FAD_PYRIMIDINE]):

        atom_sele = 'name ' + ' or name '.join(atoms + FAD_AXIS)
        selection = f'(chainid 0) and (resname FDA) and ({atom_sele})'
        sele = trj.top.select(selection)

        #print([trj.top.atom(ai) for ai in sele])
        assert len(sele) == expected_atoms[i], len(sele)

        xyz = trj.xyz[0,sele,:]
        xyzs.append(xyz)

    axis = xyzs[0][1] - xyzs[0][0]
    p1 = plane_from_points(xyzs[1])
    p2 = plane_from_points(xyzs[2])

    # this is just the dihedral around the N5-N10 axis
    butterfly_angle = angle_between_vectors(np.cross(p1, axis),
                                            np.cross(p2, axis))
    
    if butterfly_angle > 90.0:
        butterfly_angle -= 180

    assert butterfly_angle > -90.0
    assert butterfly_angle < 90.0

    # small issue with this way of computing things
    # p1 and p2 can invert
    # so no easy way to assign the sign of the angle

    return np.abs(butterfly_angle)


def simple_FAD_ring_angle(trj):

    mid_points = []

    expected_atoms = [2, 2, 2]

    for i,atoms in enumerate([FAD_AXIS, ["C2", "N3"], ["C7", "C8"]]):

        atom_sele = 'name ' + ' or name '.join(atoms)
        selection = f'(chainid 0) and (resname FDA) and ({atom_sele})'
        sele = trj.top.select(selection)

        #print([trj.top.atom(ai) for ai in sele])
        assert len(sele) == expected_atoms[i], len(sele)

        xyz = trj.xyz[0,sele,:]
        mid_points.append((xyz[0] + xyz[1]) / 2.0)

    # angle between vector pointing from middle of N5/N10 to C2/N3 and C7/C8
    p1 = mid_points[0] - mid_points[1]
    p2 = mid_points[0] - mid_points[2]
    butterfly_angle = angle_between_vectors(p1, -p2)

    return butterfly_angle


def fad_asu_angles(trj):

    n5_n10_vectors = []

    expected_atoms = [2, 2]

    for i,atoms in enumerate([FAD_AXIS, FAD_AXIS]):

        atom_sele = 'name ' + ' or name '.join(atoms)
        selection = f'(chainid {i}) and (resname FDA) and ({atom_sele})'
        sele = trj.top.select(selection)

        #print([trj.top.atom(ai) for ai in sele])

        if (len(sele) != expected_atoms[i]) and (i == 1):
            selection = f'(chainid {i+1}) and (resname FDA) and ({atom_sele})'
            sele = trj.top.select(selection)

        assert len(sele) == expected_atoms[i], len(sele)

        xyz = trj.xyz[0,sele,:]
        n5_n10_vectors.append(xyz[1] - xyz[0])

    fad_fad_angle = angle_between_vectors(
        n5_n10_vectors[0],
        n5_n10_vectors[1]
    )

    return fad_fad_angle


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
    print(trj.top.to_dataframe())
    print(TT_angle(trj))
    print(ttd_bond_distances(trj, '5'))
    print(ttd_bond_distances(trj, '6'))
    print(FAD_ring_angle(trj))


def main():

    ap = argparse.ArgumentParser()
    ap.add_argument('pdbfiles', type=str, nargs='+')
    args = ap.parse_args()

    rows = []
    for path in args.pdbfiles:
        print(path)
        trj = md.load_pdb(path)
        payload = {
            'filename' : path,
            'C5-C5 dist' : ttd_bond_distances(trj, '5'),
            'C6-C6 dist' : ttd_bond_distances(trj, '6'),
            'TTD angle' : TT_angle(trj),
            'FAD angle' : FAD_ring_angle(trj),
            'smpl FAD angle' : simple_FAD_ring_angle(trj),
            'FAD-A to FAD-B angle' : fad_asu_angles(trj),
        }

        for nd in NINA_DISTS:
            header = '/'.join(nd[:3]) + '-' + '/'.join(nd[3:])
            payload[header] = generic_distance(trj, *nd)

        rows.append(payload)

    df = pd.DataFrame(rows)
    df.to_csv('pl-geoms.csv')
    print(df)
    print('wrote --> pl-geoms.csv')

    return


if __name__ == "__main__":
    main()
