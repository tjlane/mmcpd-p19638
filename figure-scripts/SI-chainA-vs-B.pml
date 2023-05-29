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

# load 300ps_deposit.pdb, 300ps
# color purple, 300ps

load 3ns_deposit.pdb, 300ps
color purple, 300ps



## coloring and selections, protein ##

select TTD, (c. C and (i. 7 or i. 8))
show sticks, TTD
hide sticks, ///C/7/O5 or ///C/7/P or ///C/7/OP2 or ///C/7/OP1

select TTDe, (c. E and (i. 7 or i. 8))
show sticks, TTDe
hide sticks, ///E/7/O5 or ///E/7/P or ///E/7/OP2 or ///E/7/OP1

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

#load 300ps_fofo_mapmasked.map, fofo_map
load 3ns_fofo_mapmasked.map, fofo_map
map_double fofo_map

isomesh fofo_pos, fofo_map, 4, 3ns, selection=(TTD or TTDe), carve=2
isomesh fofo_neg, fofo_map, -4, 3ns, selection=(TTD or TTDe), carve=2
color teal, fofo_pos
color orange, fofo_neg


## misc ##

hide label, measure*
set ray_shadows, 0 


color skyblue, /300ps//C/7+8
color lightblue, /300ps//C/7+8/C4R+C5'+C3R+C2'+C1'
color lightblue, /3ns//C/7+8/C1R+C3'+CA+C2R+C4'+C5R

color skyblue, /300ps//E/7+8
color lightblue, /300ps//E/7+8/C4R+C5'+C3R+C2'+C1'
color lightblue, /300ps//E/7+8/C1R+C3'+CA+C2R+C4'+C5R

color atomic, (not elem C) 

## set view to look at FAD ##

deselect

set_view (\
    -0.776360691,   -0.169301346,   -0.607080281,\
    -0.513225377,    0.728897512,    0.453053027,\
     0.365794241,    0.663320661,   -0.652783155,\
     0.001183273,   -0.000202941,  -28.760576248,\
    24.628717422,   12.328876495,    4.138642311,\
    16.630815506,   41.335811615,  -20.000000000 )

ray 2048,2048
save chainA_ttd_3ns.png


set_view (\
    -0.333411545,   -0.453245491,   -0.826651573,\
     0.874584436,   -0.476065248,   -0.091728434,\
    -0.351960033,   -0.753577828,    0.555132210,\
    -0.000205496,   -0.001482788,  -31.127168655,\
    18.635181427,  -17.935745239,  -34.833625793,\
  -3388.039062500, 3450.372558594,  -20.000000000 )

ray 2048,2048
save chainB_ttd_3ns.png
