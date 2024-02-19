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
set mesh_width, 1.2
set mesh_quality, 6
set fog, 1
set valence, 0
set sphere_scale, 0.2
set movie_loop, off
hide label, measure*
set transparency, 0.5
set ray_shadows, 0
set surface_color, white
set surface_quality, 1


load superdark_deposit.pdb, dark
load 3ps_deposit.pdb, 3ps
load 300ps_deposit.pdb, 300ps
load 1ns_deposit.pdb, 1ns
load 3ns_deposit-tt-rename-noanisou.pdb, 3nsrename
load 3ns_deposit.pdb, 3ns
load 10ns_deposit.pdb, 10ns
load 30ns_deposit.pdb, 30ns
load 1us_deposit.pdb, 1us
load 10us_deposit.pdb, 10us
load 30us_deposit.pdb, 30us
load 100us_deposit.pdb, 100us
color purple, *

remove (not alt ''+B) and (/100us//C/DT`7/)
alter /100us//C/DT`7/, alt=''

morph morph1a, /dark//A+C, /3ps//A+C, method="linear", refinement=0
morph morph1b, /3ps//A+C, /300ps//A+C, method="linear", refinement=0
morph morph1c, /300ps//A+C, /1n//A+C, method="linear", refinement=0
morph morph1d, /1ns//A+C, /3nsrename//A+C, method="linear", refinement=0

morph morph2a, /3ns//A+C, /10ns//A+C, method="linear", refinement=0
morph morph2b, /10ns//A+C, /30ns//A+C, method="linear", refinement=0
morph morph2c, /30ns//A+C, /1us//A+C, method="linear", refinement=0
morph morph2d, /1us//A+C, /10us//A+C, method="linear", refinement=0

morph morph3a, /10us//A+C, /30us//A+C, method="linear", refinement=3, steps=60
morph morph3b, /30us//A+C, /100us//A+C, method="linear", refinement=3, steps=60

## coloring and selections, protein ##

color red, /////HOH

select TTD, ///C/7-8
select FAD, ///A/FDA
select fadresidues, ///A/378+403+409+268
select ttdresidues, ///A/256+257+301+305+379+421+376
select dnabinders, (c. A and i. 164+429+441+450+451+115+439+431)

hide ///B+E+F
hide ////HOH
hide ////SO4

show sticks, FAD
show sticks, TTD
show sticks, ///C/DC`9/P
show sticks, ttdresidues
show sticks, ///C+D
hide cartoon, ///C/7-8
color skyblue, TTD

# show spheres, ///W/HOH`51/O

# ribose
color lightblue, ///C/7-8/C4R+C5'+C3R+C2'+C1'
color lightblue, ///C/7-8/C4R+C5'+C3R+C2'+C1'
color lightblue, ///C/7-8/C1R+C3'+CA+C2R+C4'+C5R

color lightblue, ///C/1-6
color lightblue, ///C/9-14
color lightblue, ///D

color atomic, (not elem C)
deselect

### start movie, zoomed out overview of protein ###

mset 1x1200

# ### scene 001, zoomed out overview of protein ###

disable *
enable dark

set_view (\
     0.543579638,   -0.795227110,    0.268510729,\
    -0.525264561,   -0.571825027,   -0.630152524,\
     0.654649079,    0.201488197,   -0.728544831,\
    -0.000037171,   -0.000265352, -278.588714600,\
    16.262737274,   15.801385880,   -3.937240601,\
   124.570953369,  432.637542725,  -20.000000000 )

scene 001, store

# ### scene 002, zoom into FAD ###

set_view (\
    -0.653456986,    0.738794208,    0.164719641,\
     0.263321698,    0.425893098,   -0.865579426,\
    -0.709652543,   -0.522246122,   -0.472859383,\
     0.000000000,    0.000000000,  -56.387928009,\
    16.364500046,   13.473999977,   -4.323500156,\
    35.556224823,   77.219642639,  -20.000000000 )

scene 002, store

# ### scene 003, move to TTD ###

set_view (\
     0.755285740,   -0.631650627,    0.174692675,\
     0.343721777,    0.608748019,    0.715004206,\
    -0.557978749,   -0.479992092,    0.676909506,\
    -0.000131609,    0.000151294,  -56.331829071,\
    22.421852112,    9.106984138,   -0.546686649,\
    42.470817566,   70.305023193,  -20.000000000 )

scene 003, store

# ### scene 004 ###

set_view (\
    -0.669670522,   -0.312480867,   -0.673678756,\
    -0.614157677,    0.743017495,    0.265867174,\
     0.417475283,    0.591808677,   -0.689506233,\
     0.001245815,    0.000180461,  -54.487262726,\
    25.632261276,   13.054937363,    5.863877296,\
    -3.357263327,  112.522415161,  -20.000000000 )

hide cartoon
show surface, ttdresidues
hide sticks, ///C/1-6
hide sticks, ///C/9-14
hide sticks, ///D
hide sticks, FAD
hide sticks, ///A/376

hide surface, ///A/TRP`421/O
hide surface, ///A/ARG`256/C+CA

flag ignore, not ttdresidues, set
delete indicate
rebuild

# distance /dark//A/ARG`256/NH1, /dark//C/7/O2T
# distance /dark//A/GLU`301/OE2, /dark//C/7/N3
# distance /dark//A/GLU`301/OE1, /dark//C/7/O4
# distance /dark//C/TTD`7/N3T, /dark//W/HOH`51/O
# distance /dark//A/ASN`257/OD1, /dark//W/HOH`51/O

scene 004, store

# ### scene 005 - morph ###

disable dark
enable morph1a
scene 005, store

disable morph1a
enable morph1b
scene 006, store

disable morph1b
enable morph1c
scene 007, store

disable morph1c
enable morph1d
unbond /morph1d//C/TT6`7/C6, /morph1d//C/TT6`7/C6T
scene 008, store

disable morph1d
enable morph2a
scene 009, store

disable morph2a
enable morph2b
scene 010, store

disable morph2b
enable morph2c
scene 011, store

# ------ transition, rotate view

disable morph2c
enable morph2d

set_view (\
     0.771315396,   -0.238114357,    0.590182245,\
     0.195150882,    0.971164763,    0.136773363,\
    -0.605737865,    0.009688241,    0.795567453,\
     0.001245815,    0.000180461,  -71.303527832,\
    25.632261276,   13.054937363,    5.863877296,\
    51.405239105,   91.392509460,  -20.000000000 )

show sticks, ///C
show sticks, ////FDA
show cartoon, ///A

scene 012, store

# ------- base ejection

disable morph2d
enable morph3a
scene 013, store

disable morph3a
enable morph3b
scene 014, store


# -------- final view

disable morph3b
enable 100us

show sticks, ///D
set cartoon_ring_mode, 2
show cartoon, /100us//C+D

set_view (\
    -0.314410299,   -0.809003592,    0.496587455,\
     0.765197873,    0.093577482,    0.636919320,\
    -0.561748624,    0.580249369,    0.589652658,\
     0.001245815,    0.000180461,  -56.458126068,\
    25.632261276,   13.054937363,    5.863877296,\
    40.839660645,   72.267303467,  -20.000000000 )

scene 015, store


set_view (\
    -0.314410299,   -0.809003592,    0.496587455,\
     0.765197873,    0.093577482,    0.636919320,\
    -0.561748624,    0.580249369,    0.589652658,\
     0.001245815,    0.000180461, -187.106994629,\
    25.632261276,   13.054937363,    5.863877296,\
   171.488555908,  202.916168213,  -20.000000000 )

scene 016, store

# # ---------------------- #

mview store,   1, scene=001
mview store,  60, scene=001
mview store, 120, scene=002
mview store, 140, scene=002
mview store, 200, scene=003
mview store, 220, scene=003
mview store, 280, scene=004
mview store, 300, scene=004
mview store, 360, scene=004

mview store, 361, scene=005
mview store, 361, state=1, object=morph1a
mview store, 390, state=30, object=morph1a
mview store, 390, scene=005

mview store, 391, scene=006
mview store, 391, state=1, object=morph1b
mview store, 420, state=30, object=morph1b
mview store, 420, scene=006

mview store, 421, scene=007
mview store, 421, state=1, object=morph1c
mview store, 450, state=30, object=morph1c
mview store, 450, scene=007

mview store, 451, scene=008
mview store, 451, state=1, object=morph1d
mview store, 480, state=30, object=morph1d
mview store, 480, scene=008

mview store, 481, scene=009
mview store, 481, state=1, object=morph2a
mview store, 510, state=30, object=morph2a
mview store, 510, scene=009

mview store, 511, scene=010
mview store, 511, state=1, object=morph2b
mview store, 540, state=30, object=morph2b
mview store, 540, scene=010

mview store, 541, scene=011
mview store, 541, state=1, object=morph2c
mview store, 570, state=30, object=morph2c
mview store, 570, scene=011
mview store, 600, scene=011

mview store, 620, scene=012
mview store, 680, scene=012
mview store, 681, state=1, object=morph2d
mview store, 740, state=30, object=morph2d
mview store, 740, scene=012

mview store, 741, scene=013
mview store, 741, state=1, object=morph3a
mview store, 860, state=60, object=morph3a
mview store, 860, scene=013

mview store, 861, scene=014
mview store, 861, state=1, object=morph3b
mview store, 981, state=60, object=morph3b
mview store, 981, scene=014

mview store, 1010, scene=014
mview store, 1110, scene=015
mview store, 1200, scene=016

mview reinterpolate
set movie_fps, 30
movie.produce prod_release.mpeg, mode=draw, preserve=1, quality=100
