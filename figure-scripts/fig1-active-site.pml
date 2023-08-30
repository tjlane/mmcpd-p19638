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
set cartoon_transparency, 0.6
set cartoon_gap_cutoff, 0
set valence, 0

load superdark_deposit.pdb, mmcpd
load superdark_2mFextr-DFc.map, densmap

color purple, mmcpd

set mesh_width, 0.3
set mesh_quality, 6
set fog, 1.2

select TTD, (c. C and (i. 7 or i. 8))
show sticks, TTD

hide ////HOH
hide ////SO4
hide ///B+E+F

hide cartoon, ///C+D
show sticks, ///C+D
color grey90, ///C+D

# select water, /mmcpd//W/46+14+51+26+5
# show sphere, water
# set sphere_scale, 0.2
# color red, water

color atomic, (not elem C) 
select FAD, (c. A and r. FDA)
show sticks, FAD

color skyblue, ///C/TTD
color lightblue, ///C/TTD/C4R+C5'+C3R+C2'+C1'
color lightblue, ///C/TTD/C1R+C3'+CA+C2R+C4'+C5R

color atomic, (not elem C)

set cartoon_color, grey80

map_double densmap
map_double densmap
isomesh fad_mesh, densmap, 2.5, mmcpd, selection=FAD, carve=1.8
isomesh ttd_mesh, densmap, 2.5, mmcpd, selection=TTD, carve=1.7
color skyblue, fad_mesh
color skyblue, ttd_mesh

## misc ##

hide label, measure*
set ray_shadows, 0 

deselect

set_view (\
     0.758623421,    0.650228798,   -0.040203668,\
    -0.605634451,    0.726650000,    0.324240535,\
     0.240045756,   -0.221616745,    0.945081174,\
    -0.001188875,   -0.001171963,  -52.709800720,\
    20.205085754,   14.755264282,   -1.526154399,\
    44.548629761,   61.164005280,  -20.000000000 )

ray 2048,1200
