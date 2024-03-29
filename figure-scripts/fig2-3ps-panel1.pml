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


## loading and visualising 3 ps model and FoFo map ##

load 3ps_deposit.pdb, 3ps
color purple, 3ps


## coloring and selections, protein ##

color atomic, (not elem C) 

hide everything, c. C and i. 5-9
select TTD, (c. C and i. 7)
# show sticks, TTD
# set stick_transparency, 0.8, TTD

select FAD, (c. A and r. FDA)
show sticks, FAD

#select ttdresidues, (c. A and i. 256+257+301+305+376+379+421+441+450+115+439+431)
#show sticks, ttdresidues
select fadresidues, (c. A and i. 378+403+409+268)
show sticks, fadresidues

hide cartoon


## coloring and selections, waters ##

hide ////HOH
hide ////SO4
#select fadwater, ////HOH within 3.5 of ///A/FDA 
show sphere, fadwater
#select ttdwater, ////HOH within 4. of ///C/7+8
show sphere, ttdwater

show sphere, /dark//W/136+138
show sphere, /3ps//W/99+101

set sphere_scale, 0.2
colour gray90, dark and c. W
colour red, 3ps and c. W


## All maps ##

set mesh_width, 0.5
set mesh_quality, 6
set fog, 1



## DED map visualization ##

# load 3ps_fofo.map, 3ps_FoFomap
# map_double 3ps_FoFomap

# isomesh 3ps_FoFomap_pos, 3ps_FoFomap, 5, 3ps, selection=FAD, buffer=2
# isomesh 3ps_FoFomap_neg, 3ps_FoFomap, -5, 3ps, selection=FAD, buffer=2
# color teal, 3ps_FoFomap_pos
# color orange, 3ps_FoFomap_neg


## standard map visualization ##

# load 3ps_2fofc.map, 3ps_2FoFcmap
# isomesh 2fofc, 3ps_2fofc, 2.0, 3ps, selection=/3ps//W/99+101, carve=2.0
# color grey90, 2fofc


## spherical ROI ##

select * within 8. of ///A/FDA or ///C/7+8
hide sticks, not sele
hide cartoon, not sele
set cartoon_gap_cutoff, 0


## misc ##

hide label, measure*
set ray_shadows, 0 

distance /3ps//W/HOH`99/O, /3ps//A/FDA`470/O2
distance /3ps//A/ASN`403/ND2, /3ps//A/FDA`470/O4
distance /3ps//A/ASN`403/OD1, /3ps//A/FDA`470/N5
distance /3ps//A/FDA`470/O2, /3ps//A/ASP`409/OD2
distance /3ps//A/FDA`470/O4, /3ps//A/ASP`409/OD1
distance /3ps//A/FDA`470/N3, /3ps//A/ASP`409/O
distance /3ps//A/SER`268/O, /3ps//W/HOH`99/O

distance /3ps//W/HOH`101/O, /3ps//W/HOH`99/O
distance /dark//W/HOH`138/O, /dark//W/HOH`136/O
color lightblue, dist08
color lightblue, dist09

distance /dark//A/ARG`378/NH1, /dark//A/FDA`470/N5
distance /dark//A/FDA`470/O2B, /dark//W/HOH`138/O
distance /dark//A/FDA`470/O3B, /dark//W/HOH`138/O
distance /dark//A/FDA`470/O2, /dark//W/HOH`138/O
color red, dist10
color red, dist11
color red, dist12
color red, dist13

hide label

## set view to look at FAD ##

deselect

set_view (\
    -0.653456986,    0.738794208,    0.164719641,\
     0.263321698,    0.425893098,   -0.865579426,\
    -0.709652543,   -0.522246122,   -0.472859383,\
     0.000000000,    0.000000000,  -56.387928009,\
    16.364500046,   13.473999977,   -4.323500156,\
    35.556224823,   77.219642639,  -20.000000000 )

ray 2048,2048
#set ray_trace_mode, on
