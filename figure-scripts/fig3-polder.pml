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

# load 3ps_deposit.pdb, 3ps
# color gray90, 3ps
color atomic, (not elem C) 

# load 300ps_deposit.pdb, 300ps
# color purple, 300ps

load 1ns_deposit.pdb, 1ns
color purple, 1ns


## coloring and selections, protein ##

color atomic, (not elem C) 

hide everything, c. C and i. 5-9
select TTD, (c. C and (i. 7 or i. 8))
show sticks, TTD
# set stick_transparency, 0.8, TTD

# select FAD, (c. A and r. FDA)
# show sticks, FAD

# select ttdresidues, (c. A and i. 256+257+301+305+379)
# show sticks, ttdresidues
# select fadresidues, (c. A and i. 378+403+409+414)
# show sticks, fadresidues


## coloring and selections, waters ##

hide ////HOH
hide ////SO4
#select fadwater, ////HOH within 3.5 of ///A/FDA 
#show sphere, fadwater
#select ttdwater, ////HOH within 6. of ///C/7+8
#show sphere, ttdwater


set sphere_scale, 0.2
colour gray90, 3ps and c. W
colour red, 3ns and c. W


## All maps ##

set mesh_width, 0.5
set mesh_quality, 6
set fog, 2

## standard map visualization ##

load 1ns_ttd_polder.ccp4, polder

isomesh polder_mesh, polder, 6.0, 3ps, selection=TTD, carve=2.5
map_double polder
color skyblue, polder_mesh


## spherical ROI ##

#select /1ns//A within 8. of ///C/7+8
#hide sticks, not sele
#hide cartoon, not sele
#show cartoon, sele
hide cartoon
hide ////FDA
show sticks, ///C
set cartoon_gap_cutoff, 0
#set stick_transparency, 0.8, ////FDA

#hide cartoon


## misc ##

hide label, measure*
set ray_shadows, 0 


hide label
#hide ////FDA

## set view to look at FAD ##

deselect

set_view (\
     0.722224236,   -0.653184295,   -0.227338567,\
     0.398728132,    0.124659434,    0.908527970,\
    -0.565096736,   -0.746823370,    0.350484908,\
    -0.001272172,    0.000905931,  -45.661869049,\
    25.805335999,   10.675458908,    3.354421377,\
  -568.719421387,  660.401184082,  -20.000000000 )

ray 2048,2048
#set ray_trace_mode, on
