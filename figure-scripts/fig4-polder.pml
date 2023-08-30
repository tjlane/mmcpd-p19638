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
color gray50, dark
set stick_transparency, 0.6, dark

# load 300ps_deposit.pdb, 300ps
# color purple, 300ps

load 1ns_deposit.pdb, 1ns
color grey90, 1ns


## coloring and selections, protein ##

color atomic, (not elem C) 

hide everything, c. C and i. 5-9
select TTD, (c. C and (i. 7 or i. 8))
show sticks, TTD

color skyblue, ///C/TT6
color lightblue, ///C/TT6/C4R+C5'+C3R+C2'+C1'
color lightblue, ///C/TT6/C1R+C3'+CA+C2R+C4'+C5R
color atomic, (not elem C) 

## coloring and selections, waters ##

hide ////HOH
hide ////SO4


set sphere_scale, 0.2
colour gray90, 3ps and c. W
colour red, 3ns and c. W


## All maps ##

set mesh_width, 0.9
set mesh_quality, 6
set fog, 2

## standard map visualization ##

load 1ns_ttd_polder.ccp4, polder

isomesh polder_mesh, polder, 6.0, 3ps, selection=TTD, carve=2.5
map_double polder
color blue, polder_mesh

hide cartoon
hide ////FDA
show sticks, ///C
set cartoon_gap_cutoff, 0


## misc ##

hide label, measure*
#dist /1ns//C/TT6`7/C5, /1ns//C/TT6`7/C5T
#set dash_width, 4
#set dash_color, grey
hide label

set ray_shadows, 0 


deselect

set_view (\
     0.722224236,   -0.653184295,   -0.227338567,\
     0.398728132,    0.124659434,    0.908527970,\
    -0.565096736,   -0.746823370,    0.350484908,\
    -0.001272172,    0.000905931,  -45.661869049,\
    25.805335999,   10.675458908,    3.354421377,\
  -568.719421387,  660.401184082,  -20.000000000 )

draw 2048,2048
save fig4_polder_view1.png

set_view (\
     0.749465108,    0.434343696,   -0.499584973,\
     0.403505564,   -0.897978306,   -0.175383076,\
     -0.524790347,   -0.070144504,   -0.848287761,\
     -0.001443650,    0.000070117,  -33.667350769,\
     25.151193619,   12.852792740,    4.115354538,\
     9.091111183,   58.852390289,  -20.000000000 )

draw 2048,2048
save fig4_polder_view2.png
