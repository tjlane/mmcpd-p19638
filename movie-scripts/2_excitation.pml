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
set mesh_width, 0.5
set mesh_quality, 6
set fog, 1
set valence, 0
set sphere_scale, 0.2
set movie_loop, off
hide label, measure*
set ray_shadows, 0 


load superdark_deposit.pdb, dark
color purple, dark

load 3ps_deposit.pdb, 3ps
color purple, 3ps



## coloring and selections, protein ##

color atomic, (not elem C) 

hide everything, c. C and i. 5-9
select TTD, (c. C and i. 7)

select FAD, (c. A and r. FDA)
show sticks, FAD



#hide cartoon
# select * within 8. of ///A/FDA or ///C/7+8
# hide sticks, not sele
# hide cartoon, not sele
# set cartoon_gap_cutoff, 0

hide ///B+E+F
hide ////HOH
hide ////SO4

show sphere, /dark//W/136+138
show sphere, /3ps//W/99+101

colour gray90, dark and c. W
colour red, 3ps and c. W

hide /3ps
deselect

set_view (\
     0.543579638,   -0.795227110,    0.268510729,\
    -0.525264561,   -0.571825027,   -0.630152524,\
     0.654649079,    0.201488197,   -0.728544831,\
    -0.000037171,   -0.000265352, -278.588714600,\
    16.262737274,   15.801385880,   -3.937240601,\
   124.570953369,  432.637542725,  -20.000000000 )


mset 1 x480
scene 001, store

set_view (\
    -0.653456986,    0.738794208,    0.164719641,\
     0.263321698,    0.425893098,   -0.865579426,\
    -0.709652543,   -0.522246122,   -0.472859383,\
     0.000000000,    0.000000000,  -56.387928009,\
    16.364500046,   13.473999977,   -4.323500156,\
    35.556224823,   77.219642639,  -20.000000000 )
scene 002, store


select fadresidues, (c. A and i. 378+403+409+268)
show sticks, fadresidues
hide 3ps

distance /dark//A/ARG`378/NH1, /dark//A/FDA`470/N5
distance /dark//A/FDA`470/O2B, /dark//W/HOH`138/O
distance /dark//A/FDA`470/O3B, /dark//W/HOH`138/O
distance /dark//A/FDA`470/O2, /dark//W/HOH`138/O
color red, dist01
color red, dist02
color red, dist03
color red, dist04
hide label


scene 003, store

hide dist01
hide dist02
hide dist03
hide dist04

distance /3ps//W/HOH`99/O, /3ps//A/FDA`470/O2
distance /3ps//A/ASN`403/ND2, /3ps//A/FDA`470/O4
distance /3ps//A/ASN`403/OD1, /3ps//A/FDA`470/N5
distance /3ps//A/FDA`470/O2, /3ps//A/ASP`409/OD2
distance /3ps//A/FDA`470/O4, /3ps//A/ASP`409/OD1
distance /3ps//A/FDA`470/N3, /3ps//A/ASP`409/O
distance /3ps//A/SER`268/O, /3ps//W/HOH`99/O

distance /3ps//W/HOH`101/O, /3ps//W/HOH`99/O
distance /dark//W/HOH`138/O, /dark//W/HOH`136/O
color lightblue, dist12
color lightblue, dist13
hide label


scene 004, store

morph morphobject, dark, 3ps

scene 005, store

scene 006, store

mview store,   1, scene=001
mview store,  60, scene=001
mview store, 120, scene=002
mview store, 180, scene=003
mview store, 240, scene=004
mview store, 241, state=1, object=morphobject
mview store, 301, state=30, object=morphobject
mview store, 302, scene=005
mview store, 480, scene=006


mview reinterpolate
## set view to look at FAD ##
