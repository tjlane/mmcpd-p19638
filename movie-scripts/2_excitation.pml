reinitialize
delete all
space cmyk


## make background and overall style of protein ##

bg_col white
as cartoon
set cartoon_side_chain_helper, off
set cartoon_rect_length, 0.5
set cartoon_oval_length, 0.5
set cartoon_gap_cutoff, 0
set stick_radius, 0.12
set cartoon_transparency, 0.7
set mesh_width, 0.8
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

load 3ps_fdaA_polder.ccp4, polder
map_double polder

morph morphobject, dark, 3ps

## coloring and selections, protein ##

color red, /////HOH

select TTD, ///C/7-8
select FAD, ///A/FDA
select fadresidues, ///A/378+403+409+268

hide ///B+E+F
hide ////HOH
hide ////SO4

show sticks, FAD

show sticks, TTD
show sticks, /dark//C/DC`6/O3'
show sticks, /dark//C/DC`9/P
color skyblue, TTD

# ribose
color lightblue, /dark//C/TTD`7/C4R+C5'+C3R+C2'+C1'
color lightblue, /dark//C/TTD`7/C1R+C3'+CA+C2R+C4'+C5R

color atomic, (not elem C)

### start movie, zoomed out overview of protein ###

deselect
mset 1x560


### scene 001, zoomed out overview of protein ###

enable dark
disable 3ps
disable morphobject


set_view (\
     0.543579638,   -0.795227110,    0.268510729,\
    -0.525264561,   -0.571825027,   -0.630152524,\
     0.654649079,    0.201488197,   -0.728544831,\
    -0.000037171,   -0.000265352, -278.588714600,\
    16.262737274,   15.801385880,   -3.937240601,\
   124.570953369,  432.637542725,  -20.000000000 )

scene 001, store

### scene 002, zoom into FAD ###

set_view (\
    -0.653456986,    0.738794208,    0.164719641,\
     0.263321698,    0.425893098,   -0.865579426,\
    -0.709652543,   -0.522246122,   -0.472859383,\
     0.000000000,    0.000000000,  -56.387928009,\
    16.364500046,   13.473999977,   -4.323500156,\
    35.556224823,   77.219642639,  -20.000000000 )

scene 002, store


### scene 003, show local environment ###

show sticks, fadresidues
show sphere, /dark//W/136+138

distance /dark//A/ARG`378/NH1, /dark//A/FDA`470/N5
distance /dark//A/FDA`470/O2B, /dark//W/HOH`138/O
distance /dark//A/FDA`470/O3B, /dark//W/HOH`138/O
distance /dark//A/FDA`470/O2, /dark//W/HOH`138/O
distance /dark//W/HOH`138/O, /dark//W/HOH`136/O

distance /dark//A/ASN`403/ND2, /dark//A/FDA`470/O4
distance /dark//A/ASN`403/OD1, /dark//A/FDA`470/N5
distance /dark//A/FDA`470/O2, /dark//A/ASP`409/OD2
distance /dark//A/FDA`470/O4, /dark//A/ASP`409/OD1
distance /dark//A/FDA`470/N3, /dark//A/ASP`409/O

enable dist*

hide label

scene 003, store


### scene 004, hide cartoon ###

hide cartoon
hide sticks, TTD
scene 004, store


### scene 005, morph dark --> 3 ps ###

disable dark
enable morphobject
hide dashes, dist*

# start of morph
scene 005, store
# end of morph
scene 006, store

### scene 007, 3 ps interactions ###

enable 3ps
disable morphobject

show sphere, /3ps//W/99+101

distance /3ps//W/HOH`99/O, /3ps//A/FDA`470/O2
distance /3ps//A/ASN`403/ND2, /3ps//A/FDA`470/O4
distance /3ps//A/ASN`403/OD1, /3ps//A/FDA`470/N5
distance /3ps//A/FDA`470/O2, /3ps//A/ASP`409/OD2
distance /3ps//A/FDA`470/O4, /3ps//A/ASP`409/OD1
distance /3ps//A/FDA`470/N3, /3ps//A/ASP`409/O
distance /3ps//A/SER`268/O, /3ps//W/HOH`99/O
distance /3ps//W/HOH`101/O, /3ps//W/HOH`99/O
hide label

enable dist*

# color lightblue, dist12
# color lightblue, dist13
# hide label

scene 007, store


### scene 008, turn off interactions, show polder ###

disable dist*
isomesh polder_mesh, polder, 5.0, 3ps, selection=FAD, carve=2.5
color skyblue, polder_mesh
scene 008, store


### scene 009, hide sidechains ###

hide sticks, fadresidues
hide ////HOH
scene 009, store


set_view (\
    -0.137154013,    0.794568539,    0.591442585,\
     0.796988130,    0.443073779,   -0.410425544,\
    -0.588167846,    0.415095419,   -0.694042802,\
     0.000000000,    0.000000000,  -45.591896057,\
    16.364500046,   13.473999977,   -4.323500156,\
    37.801540375,   53.382263184,  -20.000000000 )
scene 010, store


set_view (\
    -0.132129997,    0.778094113,   -0.614057243,\
     0.864116549,   -0.213063866,   -0.455915868,\
    -0.485581160,   -0.590865433,   -0.644229293,\
     0.000000000,    0.000000000,  -45.591896057,\
    16.364500046,   13.473999977,   -4.323500156,\
    38.365959167,   52.817844391,  -20.000000000 )
scene 011, store


hide mesh, polder_mesh
show cartoon
show sticks, TTD

set_view (\
    -0.653456986,    0.738794208,    0.164719641,\
     0.263321698,    0.425893098,   -0.865579426,\
    -0.709652543,   -0.522246122,   -0.472859383,\
     0.000000000,    0.000000000,  -56.387928009,\
    16.364500046,   13.473999977,   -4.323500156,\
    35.556224823,   77.219642639,  -20.000000000 )
scene 012, store


# ---------------------- #


mview store,   1, scene=001
mview store,  60, scene=001
mview store, 120, scene=002
mview store, 180, scene=003
mview store, 230, scene=004
mview store, 241, scene=005
mview store, 241, state=1, object=morphobject
mview store, 300, state=30, object=morphobject
mview store, 301, scene=006
mview store, 302, scene=007
mview store, 340, scene=008
mview store, 400, scene=009
mview store, 440, scene=010
mview store, 480, scene=011
mview store, 520, scene=011
mview store, 560, scene=012
mview store, 560, scene=012


mview reinterpolate
## set view to look at FAD ##

movie.produce 3ps.mpeg, mode=draw, quality=1
