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

load superdark_deposit.pdb, dark

load 10us_deposit.pdb, pl
#load 30us_deposit.pdb, pl
#load 100us_deposit.pdb, pl


## color one purple
color gray90, dark
color purple, pl


## coloring and selections, protein ##

select TTD, (c. C and i. 7-8)
show sticks, TTD
select DNA, (c. C and i. 1-14)
#show sticks, DNA

# color grey90, DNA
color lightblue, TTD
color lightblue, DNA
color skyblue, ///C/7+8/C2+C3+C4+C5+C6+C7

color atomic, (not elem C) 

hide sticks, ///B
hide sticks, ////115
hide ////FDA

select trpmet, /pl//A/379+305
show sticks, trpmet
show sticks, /dark//A/379+305
hide sticks, /dark//C

## cartoons/surface ##

hide cartoon

create chainA, ///A
color grey80, chainA
# set surface_quality, 1
# set surface_mode, 1
# set solvent_radius, 1.2

set transparency, 0
# set surface_color, grey60

#show surface, chainA


## coloring and selections, waters ##

hide ////HOH
hide ////SO4
hide /pl//W/143

select ttdwater, /pl///HOH within 2.2 of ///C/7+8
show sphere, ttdwater

set sphere_scale, 0.2

## All maps ##

set mesh_width, 1.2
set mesh_quality, 6
set fog, 1

load 10us_2fofo.map, dens
load 10us_fofo.map, diff

# load 30us_2fofo.map, dens
# load 30us_fofo.map, diff

# load 100us_2fofo.map, dens
# load 100us_fofo.map, diff

isomesh dens_mesh, dens, 1.0, pl, selection=(TTD or ttdwater), carve=1.8
map_double dens
color blue, dens_mesh

map_double diff

isomesh diff_pos, diff, 3, pl, selection=(TTD or ttdwater), carve=1.8
isomesh diff_neg, diff, -3, pl, selection=(TTD or ttdwater), carve=1.8
color green, diff_pos
color red, diff_neg


## misc ##

hide label, measure*
set ray_shadows, 0 
set ray_trace_mode, 1

## set view to look at FAD ##

deselect

set_view (\
     0.746236622,    0.402381659,    0.530231655,\
    -0.271716326,    0.911343157,   -0.309194654,\
    -0.607641697,    0.086677194,    0.789425969,\
    -0.001355413,   -0.001100931,  -49.423862457,\
    28.661016464,   11.776062965,    8.546073914,\
    10.811647415,   87.379455566,  -20.000000000 )

#ray 2048,2048
