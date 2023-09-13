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

load models/3ps_deposit.pdb, mmcpd
load 2mFoFc_maps/3ps.map, densmap
load FeFc_maps/3ps_diff.map, diffmap

color grey90, mmcpd


## coloring and selections, protein ##

color atomic, (not elem C) 

select TTD, (c. C and (i. 7 or i. 8))
show sticks, TTD
hide sticks, ///C/7/O5 or ///C/7/P or ///C/7/OP2 or ///C/7/OP1

hide ////HOH
hide ////SO4
hide ////FDA
hide cartoon

color skyblue, ///C/7+8
color lightblue, ///C/7+8/C4R+C5'+C3R+C2'+C1'
color lightblue, ///C/7+8/C1R+C3'+CA+C2R+C4'+C5R
color atomic, (not elem C) 


## All maps ##

set mesh_width, 0.5
set mesh_quality, 6
set fog, 2

## standard map visualization ##
isomesh densmap_mesh, densmap, 2.0, mmcpd, selection=TTD, carve=1.8
map_double densmap
map_double densmap
color blue, densmap_mesh


map_double diffmap
map_double diffmap
isomesh diff_pos, diffmap, 2.5, mmcpd, selection=TTD, carve=3.0
isomesh diff_neg, diffmap, -2.5, mmcpd, selection=TTD, carve=3.0
color green, diff_pos
color red, diff_neg

hide label, measure*
set ray_shadows, 0 

deselect

set_view (\
     0.825159132,   -0.441644669,   -0.352139384,\
     0.484147817,    0.231877103,    0.843671083,\
    -0.290944666,   -0.866666317,    0.405166358,\
    -0.001272172,    0.000905931,  -45.661869049,\
    25.805335999,   10.675458908,    3.354421377,\
  -568.719421387,  660.401184082,  -20.000000000 )

ray 1024,1024

#set ray_trace_mode, on
