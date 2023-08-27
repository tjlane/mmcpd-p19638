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
set cartoon_transparency, 0.75

set valence, 0


## loading dark structure ## 

load superdark_deposit.pdb, dark
color purple, dark
color atomic, (not elem C) 

## coloring and selections, protein ##

color atomic, (not elem C) 

select TTD, (c. C and i. 5-9)
show sticks, TTD

# select FAD, (c. A and r. FDA)
# show sticks, FAD

#select ttdresidues, (c. A and i. 256+257+301+305+376+379+421+441+450+115+439+431)
#show sticks, ttdresidues
# select fadresidues, (c. A and i. 378+403+409+268)
# show sticks, fadresidues


## coloring and selections, waters ##

hide ////HOH
hide ////SO4


set sphere_scale, 0.2
colour gray90, dark and c. W
colour red, 3ps and c. W


## All maps ##

set mesh_width, 0.5
set mesh_quality, 6
set fog, 1



## DED map visualization ##

load truedark-minus-superdark_mkFoFo.map, td_sd_map
map_double td_sd_map

isomesh FoFomap_pos, td_sd_map, 3, dark
isomesh FoFomap_neg, td_sd_map, -3, dark
color teal, FoFomap_pos
color orange, FoFomap_neg


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

# FAD
# set_view (\
#     -0.233999431,    0.732222617,   -0.639569163,\
#      0.820275784,   -0.204417229,   -0.534144700,\
#     -0.521854937,   -0.649622381,   -0.552810133,\
#      0.000000000,    0.000000000,  -56.387928009,\
#     16.364500046,   13.473999977,   -4.323500156,\
#     35.556224823,   77.219642639,  -20.000000000 )

# TT
set_view (\
     0.722224236,   -0.653184295,   -0.227338567,\
     0.398728132,    0.124659434,    0.908527970,\
    -0.565096736,   -0.746823370,    0.350484908,\
    -0.001272172,    0.000905931,  -45.661869049,\
    25.805335999,   10.675458908,    3.354421377,\
    36.008239746,   55.671600342,  -20.000000000 )

ray 2048,2048
#set ray_trace_mode, on
