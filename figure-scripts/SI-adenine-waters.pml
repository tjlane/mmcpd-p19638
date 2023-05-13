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


load superdark_deposit_2fofo.map, dens
# load 3ps_deposit_2fofo.map, dens
# load 300ps_deposit_2fofo.map, dens
# load 1ns_deposit_2fofo.map, dens
# load 3ns_deposit_2fofo.map, dens
# load 10ns_deposit_2fofo.map, dens
# load 30ns_deposit_2fofo.map, dens
# load 1us_deposit_2fofo.map, dens
# load 10us_deposit_2fofo.map, dens
# load 30us_deposit_2fofo.map, dens
# load 100us_deposit_2fofo.map, dens

color gray90, all


## coloring and selections, protein ##
hide ///B/FDA
select FAD, ///A/FDA
show sticks, FAD

color atomic, (not elem C) 

## cartoons/surface ##
hide cartoon

## coloring and selections, waters ##

hide ////HOH
hide ////SO4

#select water, ////HOH within 6. of FAD
select water, /dark//W/9+46+14+51+26+5+162+129+9
show sphere, water

select adenine, /dark//A/FDA/N9A+C8A+N7A+C5A+C4A+N3A+C2A+N1A+C6A+N6A

set sphere_scale, 0.2

## All maps ##

set mesh_width, 1.2
set mesh_quality, 6
set fog, 1


isomesh dens_mesh, dens, 1.0, pl, selection=(water or adenine), carve=1.8
color blue, dens_mesh

map_double dens


## misc ##

hide label, measure*
set ray_shadows, 0 
set ray_trace_mode, 1

## set view to look at FAD ##

deselect

# houdini water 1
# set_view (\
#     -0.248137891,    0.934826136,    0.253869772,\
#      0.824866056,    0.066495135,    0.561384320,\
#      0.507930458,    0.348725796,   -0.787609756,\
#      0.000000000,    0.000000000,  -49.423862457,\
#     17.706659317,   17.175621033,   -1.793716908,\
#     43.389709473,   55.458168030,  -20.000000000 )

# houdini water 2
set_view (\
     0.449499130,    0.532948434,    0.716821432,\
    -0.053269904,    0.817056417,   -0.574067593,\
    -0.891646981,    0.219878465,    0.395663410,\
    -0.001297981,   -0.000909101,  -58.444110870,\
    19.183797836,   15.194115639,   -1.567492723,\
    51.643764496,   64.965736389,  -20.000000000 )

draw 2048,2048
#ray 2048,2048
