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

load 3ps_deposit.pdb, 3ps
color gray90, 3ps

# load superdark_deposit.pdb, dark
# color gray90, dark

load 1ns_deposit.pdb, 1ns
color purple, 1ns


## coloring and selections, protein ##

color skyblue, ///C/TT6
color lightblue, ///C/TT6/C4R+C5'+C3R+C2'+C1'
color lightblue, ///C/TT6/C1R+C3'+CA+C2R+C4'+C5R
hide /dark//C/TTD

color atomic, (not elem C) 

hide everything, c. C and i. 5-9
select TTD, (c. C and i. 7-8)
show sticks, TTD
# select FAD, (c. A and r. FDA)
# show sticks, FAD

select ttdresidues, (c. A and i. 256+257+301+305+379)
show sticks, ttdresidues
# select fadresidues, (c. A and i. 265-268+414+415)
# show sticks, fadresidues

hide ////FDA
hide sticks, ///C/TTD


## coloring and selections, waters ##

hide ////HOH
hide ////SO4

## All maps ##

set mesh_width, 0.5
set mesh_quality, 6
set fog, 2

## DED map visualization ##

#load 300ps_fofo.map, fofo_map
load 300ps-3ps_fofo.map, fofo_map
map_double fofo_map

isomesh fofo_pos, fofo_map, 3.0, 300ps, selection=(TTD or ttdresidues), carve=2.5
isomesh fofo_neg, fofo_map, -3.0, 300ps, selection=(TTD or ttdresidues), carve=2.5
color teal, fofo_pos
color orange, fofo_neg

load 1ns_ttd_polder.ccp4, polder

isomesh polder_mesh, polder, 6.0, 3ps, selection=TTD, carve=2.5
map_double polder
color skyblue, polder_mesh

hide cartoon


## misc ##
hide label, measure*
set ray_shadows, 0 

# distance /3ps//W/HOH`99/O, /3ps//A/FDA`470/O2

hide label

## set view to look at FAD ##

deselect

set_view (\
     0.831430852,   -0.451909214,    0.323170573,\
     0.433798343,    0.891472995,    0.130546108,\
    -0.347089738,    0.031656615,    0.937258959,\
    -0.001511747,   -0.000103580,  -68.545837402,\
    20.899427414,   14.103139877,    1.151998043,\
    44.152343750,   93.272956848,  -20.000000000 )

#ray 2048,2048
#set ray_trace_mode, on
