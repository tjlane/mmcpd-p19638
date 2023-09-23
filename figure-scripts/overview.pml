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
set cartoon_gap_cutoff, 0


## loading and visualising 3 ps model and FoFo map ##

load 3ps_deposit.pdb, 3ps
color purple, 3ps
load 3ps_fofo.map, FoFomap

# load 3ns_deposit.pdb, 3ns
# color purple, 3ns
# load 3ns_fofo.map, FoFomap

# load 100us_deposit.pdb, 100us
# color purple, 100us
# load 100us_fofo.map, FoFomap


## coloring and selections, protein ##

select TTD, (c. C and i. 7-8)
show sticks, TTD
show sticks, ///C/DC`6/O3'
show sticks, ///C/DC`9/P
color skyblue, TTD

# ribose
color lightblue, ///C/TTD`7/C4R+C5'+C3R+C2'+C1'
color lightblue, ///C/TTD`7/C1R+C3'+CA+C2R+C4'+C5R

select complexA, ///A+C+D
select FAD, (c. A and r. FDA)
show sticks, FAD

color atomic, (not elem C) 

hide ///B+E+F
hide ////HOH
hide ////SO4


## All maps ##

set mesh_width, 0.3
set mesh_quality, 6
set fog, 1


## DED map visualization ##

map_double FoFomap

isomesh FoFomap_pos, FoFomap, 4.5, 3ps, selection=complexA, carve=4
isomesh FoFomap_neg, FoFomap, -4.5, 3ps, selection=complexA, carve=4

# isomesh FoFomap_pos, FoFomap, 4, 3ns, selection=complexA, carve=2
# isomesh FoFomap_neg, FoFomap, -4, 3ns, selection=complexA, carve=2

# map_double FoFomap
# isomesh FoFomap_pos, FoFomap, 4, 100us, selection=complexA, carve=4
# isomesh FoFomap_neg, FoFomap, -4, 100us, selection=complexA, carve=4

color teal, FoFomap_pos
color orange, FoFomap_neg


## misc ##

hide label, measure*
set ray_shadows, 0 
hide label

## set view to look at FAD ##

deselect

set_view (\
     0.543579638,   -0.795227110,    0.268510729,\
    -0.525264561,   -0.571825027,   -0.630152524,\
     0.654649079,    0.201488197,   -0.728544831,\
    -0.000037171,   -0.000265352, -278.588714600,\
    16.262737274,   15.801385880,   -3.937240601,\
   124.570953369,  432.637542725,  -20.000000000 )

ray 4096,4096

