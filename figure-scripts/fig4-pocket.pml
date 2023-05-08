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

# load 1us_deposit.pdb, pl
#load 10us_deposit.pdb, pl
#load 30us_deposit.pdb, pl
load 100us_deposit.pdb, pl

# color gray90, 1us
# color gray90, 10us
# color gray90, 30us
#color gray90, 100us


## color one purple
color gray90, pl


## coloring and selections, protein ##



select TTD, (c. C and i. 7-8)
show sticks, TTD
select FAD, (c. A and r. FDA)
show sticks, FAD
select DNA, (c. C and i. 1-14)
show sticks, DNA

# color grey90, DNA
color purple, TTD

color atomic, (not elem C) 

# select ttdresidues, (c. A and i. 164+256+257+301+305+376+379+421+429+441+450+451+115+439+431)
# show sticks, ttdresidues
# select fadresidues, (c. A and i. 265-268+378+403+409+414+415+422)
# show sticks, fadresidues

hide sticks, ///B
hide sticks, ////115

## cartoons/surface ##

hide cartoon

create chainA, ///A
color grey80, chainA
set surface_quality, 1
set surface_mode, 1
set solvent_radius, 1.2

set transparency, 0
# set surface_color, grey60

show surface, chainA


## coloring and selections, waters ##

hide ////HOH
hide ////SO4

select ttdwater, ////HOH within 5. of ///C/7+8
show sphere, ttdwater

set sphere_scale, 0.2
colour gray90, dark and c. W
colour purple, 3ps and c. W


## All maps ##

set mesh_width, 0.6
set mesh_quality, 6
set fog, 1


## misc ##

hide label, measure*
set ray_shadows, 0 
set ray_trace_mode, 1

## set view to look at FAD ##

deselect
# set_view (\
#      0.717704475,    0.692083001,    0.076590940,\
#     -0.696316302,    0.713127732,    0.081046805,\
#      0.001470000,   -0.111490831,    0.993742228,\
#      0.000786628,   -0.001140254,  -78.950065613,\
#     30.157497406,   13.374934196,    6.671710014,\
#     32.058479309,  125.767204285,  -20.000000000 )

set_view (\
     0.568411410,    0.662006438,    0.488448501,\
    -0.278531671,    0.713498056,   -0.642897904,\
    -0.774119198,    0.229402512,    0.589958608,\
    -0.000846151,   -0.001308002,  -63.410465240,\
    27.606801987,   11.363485336,    8.861503601,\
    24.909330368,  101.477142334,  -20.000000000 )

ray 2048,2048
