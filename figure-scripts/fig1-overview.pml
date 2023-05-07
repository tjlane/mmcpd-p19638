reinitialize
delete all
space cmyk


## make background and overall style of protein ##

bg_col white
as cartoon
#set cartoon_side_chain_helper, off
set cartoon_rect_length, 0.5
set cartoon_oval_length, 0.5
set stick_radius, 0.25
set cartoon_transparency, 0.3
set surface_color, grey

## loading dark structure ## 

load superdark_deposit.pdb, dark
color gray90, dark
color atomic, (not elem C) 
#color purple, dark


## coloring and selections, protein ##



hide everything, c. C and i. 7-8
select TTD, (c. C and i. 7-8)
show sticks, TTD
show sticks, /dark//C/DC`6/O3'
show sticks, /dark//C/DC`9/P
color skyblue, TTD

# ribose
color lightblue, /dark//C/TTD`7/C4R+C5'+C3R+C2'+C1'
color lightblue, /dark//C/TTD`7/C1R+C3'+CA+C2R+C4'+C5R

select FAD, (c. A and r. FDA)
show sticks, FAD
color purple, FAD

select PL, (c. A)
# show surface, PL
# set transparency, 0.9

# select ttdresidues, (c. A and i. 164+256+257+301+305+376+379+421+429+441+450+451+115+439+431)
# show sticks, ttdresidues
# select fadresidues, (c. A and i. 265-268+378+403+409+414+415+422)
# show sticks, fadresidues


## coloring and selections, waters ##

hide ////HOH
hide ////SO4
hide ///B+E+F
# select fadwater, ////HOH within 4. of ///A/FDA 
# show sphere, fadwater
# select ttdwater, ////HOH within 4. of ///C/7+8
# show sphere, ttdwater

# set sphere_scale, 0.2
# colour gray90, dark and c. W
# colour purple, 3ps and c. W


## All maps ##

set mesh_width, 0.6
set mesh_quality, 6
set fog, 0.5



color atomic, (not elem C) 

## misc ##

hide label, measure*
set ray_shadows, 0 


## set view to look at FAD ##

deselect

set_view (\
     0.543579638,   -0.795227110,    0.268510729,\
    -0.525264561,   -0.571825027,   -0.630152524,\
     0.654649079,    0.201488197,   -0.728544831,\
    -0.000037171,   -0.000265352, -278.588714600,\
    16.262737274,   15.801385880,   -3.937240601,\
   124.570953369,  432.637542725,  -20.000000000 )

set ray_trace_mode, 1
ray 2048,2048
#set ray_trace_mode, on
