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

# load 3ns_deposit.pdb, 3ns
load superdark_deposit.pdb, dark
color gray90, dark
color atomic, (not elem C) 


## loading and visualising 3 ps model and FoFo map ##

# load 10us_deposit.pdb, 10us
# color purple, 10us

# load 30us_deposit.pdb, 30us
# color purple, 30us

load 100us_deposit.pdb, 100us
color purple, 100us


## coloring and selections, protein ##

select TTD, (c. C and i. 7-8)
show sticks, TTD
select DNA, (c. C and i. 6-12)
# show sticks, DNA
select comp, (c. D and i. 4-10)
# show sticks, comp


color atomic, (not elem C) 
color lightblue, ///C+D
color grey90, /dark//C/7+8
color atomic, (not elem C and TTD) 
color atomic, (elem P)

select ttdresidues, (c. A and i. 164+429+441+450+451+115+439+431)
show sticks, ttdresidues

# hide /dark//C/7+8
hide ////FDA
hide ////115
hide cartoon

set cartoon_ring_mode, 2
show cartoon, /100us//C+D

select dna_shown, /100us//C/9+10+12 or /100us//D/8+9+10
show sticks, dna_shown
color atomic, (not elem C and dna_shown)

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
distance /100us//C/DG`10/P  /100us//A/LYS`451/NZ
distance /100us//C/DC`9/P , /100us//A/LYS`451/NZ
distance /100us//A/ARG`164/NH1, /100us//C/DT`7/P`A
distance /100us//D/DG`10/P, /100us//A/LYS`439/NZ
distance /100us//D/DA`9/N3, /100us//A/ARG`429/NH2
distance /100us//D/DA`8/N1, /100us//A/ARG`429/NH1
distance /100us//C/DG`12/C6, /100us//A/ARG`450/NH2
distance /100us//C/DG`12/N7, /100us//A/ARG`450/NH1

distance /dark//A/ARG`441/NH1, /dark//C/TTD`7/O4P
distance /dark//A/ARG`441/NH2, /dark//C/TTD`7/O4P
color red, dist08
color red, dist09

hide label, dist*
set ray_shadows, 0 


## set view to look at FAD ##

deselect
set_view (\
     0.232944414,   -0.621391177,    0.748037875,\
     0.959642231,    0.271393269,   -0.073386699,\
    -0.157404408,    0.734954476,    0.659539163,\
    -0.000286740,    0.000291985, -106.755409241,\
    23.253513336,    6.587289333,    7.462270737,\
    11.010910034,  202.295989990,  -20.000000000 )

set ray_trace_mode, 1
ray 2048,2048
