reinitialize
delete all
space cmyk


## make background and overall style of protein ##

bg_col white
as cartoon
set cartoon_side_chain_helper, off
set cartoon_rect_length, 0.5
set cartoon_oval_length, 0.5
set stick_radius, 0.12
set cartoon_transparency, 0.85

set valence, 0

load superdark_deposit.pdb, mmcpd
load superdark_2mFextr-DFc.map, polder
load superdark_diff.map, diffmap

# load 3ps_deposit.pdb, mmcpd
# load 3ps_2mFextr-DFc.map, polder
# load 3ps_diff.map, diffmap

# load 3ns_deposit.pdb, mmcpd
# load 3ns_2mFextr-DFc.map, polder
# load 3ns_diff.map, diffmap


color purple, mmcpd

color atomic, (not elem C) 
select FAD, (c. A and r. FDA)
show sticks, FAD
hide cartoon

## maps ##

isomesh polder_mesh, polder, 1.5, mmcpd, selection=FAD, carve=1.8
map_double polder
map_double polder
color skyblue, polder_mesh

map_double diffmap
map_double diffmap
isomesh diff_pos, diffmap, 3.0, mmcpd, selection=FAD, carve=3.0
isomesh diff_neg, diffmap, -3.0, mmcpd, selection=FAD, carve=3.0
color green, diff_pos
color red, diff_neg


## coloring and selections, waters ##

hide ////HOH
hide ////SO4
hide ////PEG

## All maps ##

set mesh_width, 0.5
set mesh_quality, 6
set fog, 7

## misc ##

hide label, measure*
set ray_shadows, 0 
hide label

## set view to look at FAD ##

deselect

set_view (\
    -0.171282589,    0.744568229,   -0.645164132,\
     0.836648345,   -0.235849991,   -0.494309992,\
    -0.520210087,   -0.624452770,   -0.582564473,\
    -0.000750011,   -0.000496313,  -43.426551819,\
    16.726116180,   15.585981369,   -1.493986130,\
    17.565849304,   69.269989014,  -20.000000000 )

ray 2048,2048

