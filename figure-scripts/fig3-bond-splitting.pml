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
color atomic, (not elem C) 

# load 300ps_deposit.pdb, 300ps
# color purple, 300ps

load 3ns_deposit.pdb, 3ns
color purple, 3ns


## coloring and selections, protein ##

color atomic, (not elem C) 

hide everything, c. C and i. 5-9
select TTD, (c. C and (i. 7 or i. 8))
show sticks, TTD
# set stick_transparency, 0.8, TTD

# select FAD, (c. A and r. FDA)
# show sticks, FAD

select ttdresidues, (c. A and i. 256+257+301+305+379)
show sticks, ttdresidues
# select fadresidues, (c. A and i. 378+403+409+414)
# show sticks, fadresidues


## coloring and selections, waters ##

hide ////HOH
hide ////SO4
#select fadwater, ////HOH within 3.5 of ///A/FDA 
#show sphere, fadwater
#select ttdwater, ////HOH within 6. of ///C/7+8

# + /3ns//W/41 + /3ps//W/37
select ttdwater, /3ps//W/40 
show sphere, ttdwater


set sphere_scale, 0.2
colour gray90, 3ps and c. W
colour red, 3ns and c. W


## All maps ##

set mesh_width, 0.5
set mesh_quality, 6
set fog, 2



## DED map visualization ##

load 3ns_fofo.map, fofo_map
map_double fofo_map

isomesh fofo_pos, fofo_map, 3.5, 3ns, selection=(TTD or ttdwater or ttdresidues), carve=2.1
isomesh fofo_neg, fofo_map, -3.5, 3ns, selection=(TTD or ttdwater or ttdresidues), carve=2.1
color teal, fofo_pos
color orange, fofo_neg


## standard map visualization ##

# load 3ps_2fofc.map, 3ps_2FoFcmap
# isomesh 2fofc, 3ps_2fofc, 2.0, 3ps, selection=/3ps//W/99+101, carve=2.0
# color grey90, 2fofc


## spherical ROI ##

# select * within 8. of ///C/7+8
# hide sticks, not sele
# hide cartoon, not sele
# set cartoon_gap_cutoff, 0

hide cartoon


## misc ##

hide label, measure*
set ray_shadows, 0 

# distance /3ps//W/HOH`99/O, /3ps//A/FDA`470/O2

distance /3ns//C/DT`8/O2, /3ns//A/ASN`257/OD1
# distance /3ns//C/DT`7/N3, /3ns//A/GLU`301/OE2
# distance /3ns//A/GLU`301/OE1, /3ns//C/DT`7/O4
distance /3ns//A/ARG`256/NH2, /3ns//C/DT`8/O2
distance /3ns//A/ARG`256/NH2, /3ns//C/DT`7/O2

distance /3ps//C/TTD`7/N3T, /3ps//W/HOH`40/O
color red, dist04
distance /3ps//W/HOH`40/O, /3ps//A/ASN`257/OD1
color red, dist05
distance /3ps//A/ARG`256/NH2, /3ps//W/HOH`40/O
color red, dist06


hide label
hide ////FDA

## set view to look at FAD ##

deselect

set_view (\
    -0.873361111,   -0.144526005,   -0.465077043,\
    -0.406422466,    0.742440343,    0.532496691,\
     0.268326670,    0.654098153,   -0.707168400,\
     0.001421881,   -0.000339076,  -49.161575317,\
    24.705289841,   14.229559898,    5.704463482,\
    33.767406464,   64.939041138,  -20.000000000 )

ray 2048,2048
#set ray_trace_mode, on
