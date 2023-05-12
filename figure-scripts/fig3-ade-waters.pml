reinitialize
delete all
space cmyk


## make background and overall style of protein ##

bg_col white
as cartoon
set cartoon_side_chain_helper, off
set cartoon_rect_length, 0.5
set cartoon_oval_length, 0.5
set stick_radius, 0.15
set cartoon_transparency, 0.7


## loading dark structure ## 

load superdark_deposit.pdb, dark
load 3ps_deposit.pdb, 3ps

load 3ps_deposit_2fofc.map, dens

color gray90, dark
color purple, 3ps
color atomic, (not elem C) 


## coloring and selections, protein ##
hide ///B/FDA
select FAD, ///A/FDA
show sticks, FAD

select grp162, ///A/414
show sticks, grp162

select grp26, ///A/256
show sticks, grp26

select TTD, ///C/7+8
#show sticks, TTD
#set stick_transparency, 0.7, TTD

color atomic, (not elem C) 

## cartoons/surface ##
hide cartoon
hide cartoon, ////290-311
hide cartoon, ////162-172

## coloring and selections, waters ##

hide ////HOH
hide ////SO4

#select water, ////HOH within 6. of FAD
select water, /dark//W/46+14+51+26+5+162+129
select lightwater, /3ps//W/5+37+95+40
show sphere, water
show sphere, lightwater

set sphere_scale, 0.2
colour gray90, dark and c. W
colour red, 3ps and c. W

## All maps ##

set mesh_width, 0.5
set mesh_quality, 6
set fog, 2

isomesh dens_mesh, dens, 1.5, pl, selection=(water), carve=1.6
color skyblue, dens_mesh
map_double dens

load 3ps_fofo.map, 3ps_FoFomap
map_double 3ps_FoFomap

# isomesh 3ps_FoFomap_pos, 3ps_FoFomap, 4.5, 3ps, selection=(FAD), carve=2.5
# isomesh 3ps_FoFomap_neg, 3ps_FoFomap, -4.5, 3ps, selection=(FAD), carve=2.5
# color teal, 3ps_FoFomap_pos
# color orange, 3ps_FoFomap_neg

isomesh 3ps_FoFomap_pos_w, 3ps_FoFomap, 4.5, 3ps, selection=(water), carve=1.6
isomesh 3ps_FoFomap_neg_w, 3ps_FoFomap, -4.5, 3ps, selection=(water), carve=1.6
color teal, 3ps_FoFomap_pos_w
color orange, 3ps_FoFomap_neg_w


## misc ##


set ray_shadows, 0 
set ray_trace_mode, 0

distance /dark//W/HOH`162/O, /dark//A/FDA`470/N1A
distance /dark//W/HOH`162/O, /dark//A/ASN`414/O
distance /dark//W/HOH`162/O, /dark//W/HOH`129/O

distance /dark//W/HOH`26/O, /dark//A/FDA`470/N7A
distance /dark//W/HOH`26/O, /dark//W/HOH`46/O
distance /dark//W/HOH`26/O, /dark//A/ARG`256/NH2

color red, dist*
hide label
#set label_size, 18

## set view to look at FAD ##

deselect

set_view (\
     0.365054697,    0.831443608,    0.418719679,\
    -0.189358041,    0.506702006,   -0.841021895,\
    -0.911450028,    0.227758959,    0.342426389,\
     0.000751202,    0.000021594,  -49.661094666,\
    18.716186523,   16.178823471,   -0.939899683,\
    30.726455688,   66.966232300,  -20.000000000 )

# set_view (\
# -0.182034671,    0.515911222,    0.837010384,\
#     0.345453978,   -0.763420463,    0.545690358,\
#     0.920548558,    0.388500690,   -0.039241143,\
#     0.000364019,   -0.000057120,  -49.334007263,\
# 19.674449921,   16.941400528,   -0.086325467,\
# 38.680660248,   58.564327240,  -20.000000000 )

#draw 2048,2048
ray 2048,2048
