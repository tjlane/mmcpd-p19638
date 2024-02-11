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


load ./superdark_deposit.pdb, pl
#load ./swissfel.map, fofo_map
load ./euxfel.map, fofo_map


## coloring and selections, protein ##

color purple, pl

select TTD, (c. C and (i. 7 or i. 8))
show sticks, TTD
hide sticks, ///C/7/O5 or ///C/7/P or ///C/7/OP2 or ///C/7/OP1

## coloring and selections, waters ##

hide ////HOH
hide ////SO4
hide ////FDA
hide cartoon

## All maps ##

set mesh_width, 0.5
set mesh_quality, 6
set fog, 2


## DED map visualization ##
# map_double fofo_map
# map_double fofo_map

isomesh fofo_pos, fofo_map, 2, pl, selection=TTD, carve=2.2
isomesh fofo_neg, fofo_map, -2, pl, selection=TTD, carve=2.2
color teal, fofo_pos
color orange, fofo_neg

## misc ##

hide label, measure*
set ray_shadows, 0 


color skyblue, ///C/7+8
color lightblue, ///C/7+8/C4R+C5'+C3R+C2'+C1'
color lightblue, ///C/7+8/C1R+C3'+CA+C2R+C4'+C5R

color atomic, (not elem C) 

## set view to look at FAD ##

deselect

# set_view (\
#      0.825159132,   -0.441644669,   -0.352139384,\
#      0.484147817,    0.231877103,    0.843671083,\
#     -0.290944666,   -0.866666317,    0.405166358,\
#     -0.001272172,    0.000905931,  -45.661869049,\
#     25.805335999,   10.675458908,    3.354421377,\
#   -568.719421387,  660.401184082,  -20.000000000 )

# ray 1024,1024
# save 2sigma_top_view.png

set_view (\
    0.749465108,    0.434343696,   -0.499584973,\
    0.403505564,   -0.897978306,   -0.175383076,\
  -0.524790347,   -0.070144504,   -0.848287761,\
  -0.001443650,    0.000070117,  -33.667350769,\
  25.151193619,   12.852792740,    4.115354538,\
    9.091111183,   58.852390289,  -20.000000000 )

ray 1024,1024
save 2sigma_side_view.png
