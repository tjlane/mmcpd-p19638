delete all
space cmyk


## make background and overall style of protein ##

bg_col white
as cartoon
set cartoon_side_chain_helper, off
set cartoon_rect_length, 0.5
set cartoon_oval_length, 0.5
set stick_radius, 0.15
set cartoon_transparency, 0.7


## loading dark structure ## 

load superdark_deposit.pdb, dark
color gray80, dark
color atomic, (not elem C) 


## loading and visualising 3 ps model and FoFo map ##

load 3ps_deposit.pdb, 3ps
color limegreen, 3ps


## coloring and selections, protein ##

color atomic, (not elem C) 

hide everything, c. C and i. 5-9
select TTD, (c. C and i. 5-9)
show sticks, TTD
select FAD, (c. A and r. FDA)
show sticks, FAD

select ttdresidues, (c. A and i. 164+256+257+301+305+376+379+421+429+441+450+451+115+439+431)
show sticks, ttdresidues
select fadresidues, (c. A and i. 265-268+378+403+409+414+415+422)
show sticks, fadresidues


## coloring and selections, waters ##

hide ////HOH
hide ////SO4
select fadwater, ////HOH within 4. of ///A/FDA 
show sphere, fadwater
select ttdwater, ////HOH within 4. of ///C/7+8
show sphere, ttdwater

set sphere_scale, 0.2
colour gray80, dark and c. W
colour red, 3ps and c. W


## map visualization ##

load 3ps_grid.map, 3ps_FoFomap

map_double 3ps_FoFomap
map_double 3ps_FoFomap

isomesh 3ps_FoFomap_pos, 3ps_FoFomap, 5, 3ps, selection=FAD, buffer=0
isomesh 3ps_FoFomap_neg, 3ps_FoFomap, -5, 3ps, selection=FAD, buffer=0
color orange, 3ps_FoFomap_pos
color blue, 3ps_FoFomap_neg

set mesh_width, 0.5
set mesh_quality, 6
set fog, 1.0


## spherical ROI ##

select * within 8. of ///A/FDA or ///C/7+8
hide sticks, not sele
hide cartoon, not sele
set cartoon_gap_cutoff, 0


## misc ##

#hide label, measure*


## set view to look at FAD ##

set_view (\
    -0.515445530,    0.846860230,   -0.130789295,\
     0.390019625,    0.095959187,   -0.915780187,\
    -0.762987554,   -0.523040891,   -0.379765719,\
    -0.000037171,   -0.000265352,  -55.716960907,\
    16.262737274,   15.801385880,   -3.937240601,\
   -31.215253830,  142.680191040,  -20.000000000 )

set ray_shadows, 0 
draw 2048,2048
#set ray_trace_mode, on