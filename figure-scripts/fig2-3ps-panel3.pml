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


## loading dark structure ## 

load superdark_deposit.pdb, dark
color gray90, dark
color atomic, (not elem C) 


## loading and visualising 3 ps model and FoFo map ##

load 3ps_deposit.pdb, 3ps
color purple, 3ps


## coloring and selections, protein ##

color atomic, (not elem C) 

hide everything, c. C and i. 5-9

select FAD, (c. A and r. FDA)
show sticks, FAD

select fadresidues, (c. A and i. 403)
show sticks, fadresidues

hide cartoon


## coloring and selections, waters ##

hide ////HOH
hide ////SO4

select waters, /dark//W/136+138+162 + /3ps//W/99+101
show sphere, waters  

set sphere_scale, 0.2
colour gray90, dark and c. W
colour red, 3ps and c. W


## All maps ##

set mesh_width, 0.5
set mesh_quality, 6
set fog, 2



## DED map visualization ##

load 3ps_fofo.map, 3ps_FoFomap
map_double 3ps_FoFomap

isomesh 3ps_FoFomap_pos, 3ps_FoFomap, 4.5, 3ps, selection=(FAD), carve=2.5
isomesh 3ps_FoFomap_neg, 3ps_FoFomap, -4.5, 3ps, selection=(FAD), carve=2.5
isomesh 3ps_FoFomap_pos_w, 3ps_FoFomap, 4.5, 3ps, selection=(waters), carve=1.5
isomesh 3ps_FoFomap_neg_w, 3ps_FoFomap, -4.5, 3ps, selection=(waters), carve=1.5
color teal, 3ps_FoFomap_pos
color orange, 3ps_FoFomap_neg
color teal, 3ps_FoFomap_pos_w
color orange, 3ps_FoFomap_neg_w


## spherical ROI ##

select * within 8. of ///A/FDA or ///C/7+8
hide sticks, not sele
hide cartoon, not sele
set cartoon_gap_cutoff, 0


## misc ##

hide label, measure*
set ray_shadows, 0 


hide label

## set view to look at FAD ##

deselect

set_view (\
    -0.107271068,    0.806359410,    0.581580937,\
     0.780586839,    0.430586904,   -0.453026444,\
    -0.615726709,    0.405390054,   -0.675634265,\
     0.000000000,    0.000000000,  -56.387928009,\
    16.364500046,   13.473999977,   -4.323500156,\
    19.228746414,   93.547080994,  -20.000000000 )

ray 2048,2048
#set ray_trace_mode, on
