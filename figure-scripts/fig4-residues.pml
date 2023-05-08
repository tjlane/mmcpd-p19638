reinitialize
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

load 3ns_deposit.pdb, 3ns
color gray90, 3ns
color atomic, (not elem C) 


## loading and visualising 3 ps model and FoFo map ##

# load 10us_deposit.pdb, 10us
# color purple, 10us

# load 30us_deposit.pdb, 30us
# color purple, 30us

load 100us_deposit.pdb, 100us
color purple, 100us


## coloring and selections, protein ##

color atomic, (not elem C) 

hide everything, c. C and i. 6-12
select TTD, (c. C and i. 6-12)
show sticks, TTD
select comp, (c. D and i. 4-10)
show sticks, comp
# select FAD, (c. A and r. FDA)
# show sticks, FAD

select ttdresidues, (c. A and i. 164+256+257+301+305+376+379+421+429+441+450+451+115+439+431)
show sticks, ttdresidues
# select fadresidues, (c. A and i. 265-268+378+403+409+414+415+422)
# show sticks, fadresidues

hide ////FDA
hide ////115
hide cartoon

## coloring and selections, waters ##

hide ////HOH
hide ////SO4
# select fadwater, ////HOH within 4. of ///A/FDA 
# show sphere, fadwater
# select ttdwater, ////HOH within 4. of ///C/7+8
# show sphere, ttdwater

set sphere_scale, 0.2
# colour gray90, dark and c. W
# colour purple, 3ps and c. W


## All maps ##

set mesh_width, 0.6
set mesh_quality, 6
set fog, 0.5


## DED map visualization ##

# load 3ps_grid.map, 3ps_FoFomap

# map_double 3ps_FoFomap
# map_double 3ps_FoFomap

# isomesh 3ps_FoFomap_pos, 3ps_FoFomap, 5, 3ps, selection=FAD, buffer=0
# isomesh 3ps_FoFomap_neg, 3ps_FoFomap, -5, 3ps, selection=FAD, buffer=0
# color teal, 3ps_FoFomap_pos
# color orange, 3ps_FoFomap_neg


## standard map visualization ##

# load 3ps_2fofc.map, 3ps_2FoFcmap
# isomesh 2fofc, 3ps_2fofc, 2.0, 3ps, selection=/3ps//W/99+101, carve=2.0
# color grey90, 2fofc


## spherical ROI ##

# select * within 8. of ///A/FDA or ///C/7+8
# hide sticks, not sele
# hide cartoon, not sele
# set cartoon_gap_cutoff, 0


## misc ##

hide label, measure*
set ray_shadows, 0 


## set view to look at FAD ##

deselect
set_view (\
     0.131047308,   -0.952364087,    0.275291294,\
     0.279101938,    0.301894784,    0.911553741,\
    -0.951242685,   -0.042620689,    0.305378735,\
    -0.000751114,    0.000274947, -123.109054565,\
    26.435565948,   14.342269897,    9.170843124,\
    27.435174942,  218.720230103,  -20.000000000 )

#ray 2048,2048
