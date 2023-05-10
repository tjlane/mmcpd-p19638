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
# load 3ps_deposit.pdb, 3ps
# load 300ps_deposit.pdb, 300ps
# load 1ns_deposit.pdb, 1ns
# load 3ns_deposit.pdb, 3ns
# load 10ns_deposit.pdb, 10ns
# load 30ns_deposit.pdb, 30ns
# load 1us_deposit.pdb, 1us
# load 10us_deposit.pdb, 10us

# load superdark_deposit_2fofo.map, dens
# load 3ps_deposit_2fofo.map, dens
# load 300ps_deposit_2fofo.map, dens
# load 1ns_deposit_2fofo.map, dens
# load 3ns_deposit_2fofo.map, dens
# load 10ns_deposit_2fofo.map, dens
# load 30ns_deposit_2fofo.map, dens
# load 1us_deposit_2fofo.map, dens
load 10us_deposit_2fofo.map, dens

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

select water, ////HOH within 3. of FAD
show sphere, water

set sphere_scale, 0.2

## All maps ##

set mesh_width, 1.2
set mesh_quality, 6
set fog, 1


isomesh dens_mesh, dens, 1.5, pl, selection=(FAD + water), carve=2.5
color blue, dens_mesh

map_double dens


## misc ##

hide label, measure*
set ray_shadows, 0 
set ray_trace_mode, 1

## set view to look at FAD ##

deselect

set_view (\
    -0.248137891,    0.934826136,    0.253869772,\
     0.824866056,    0.066495135,    0.561384320,\
     0.507930458,    0.348725796,   -0.787609756,\
     0.000000000,    0.000000000,  -49.423862457,\
    17.706659317,   17.175621033,   -1.793716908,\
    43.389709473,   55.458168030,  -20.000000000 )

draw 2048,2048
#ray 2048,2048
