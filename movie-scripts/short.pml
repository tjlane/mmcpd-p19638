reinitialize
delete all
space cmyk

# 1080p widescreen
viewport 1920, 1080

## make background and overall style of protein ##


bg_col white
as cartoon
set cartoon_side_chain_helper, off
set cartoon_rect_length, 0.5
set cartoon_oval_length, 0.5
set cartoon_gap_cutoff, 0
set cartoon_transparency, 0.7
set cartoon_color, grey50
set stick_radius, 0.12
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


morph morph1a, /dark//A+C, /3ps//A+C, method="linear", refinement=3, steps=60
morph morph1b, /3ps//A+C, /300ps//A+C, method="linear", refinement=0, steps=30
morph morph1c, /300ps//A+C, /1n//A+C, method="linear", refinement=0, steps=30
morph morph1d, /1ns//A+C, /3nsrename//A+C, method="linear", refinement=0, steps=30

morph morph2a, /3ns//A+C, /10ns//A+C, method="linear", refinement=0, steps=30
morph morph2b, /10ns//A+C, /30ns//A+C, method="linear", refinement=0, steps=30
morph morph2c, /30ns//A+C, /1us//A+C, method="linear", refinement=0, steps=30
morph morph2d, /1us//A+C, /10us//A+C, method="linear", refinement=0, steps=30

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

hide cartoon, ///C+D


deselect

### start movie, zoomed out overview of protein ###

mset 1x1260

# ### scene 001, zoomed out overview of protein ###

disable *
hide sticks, ttdresidues
hide sticks, fadresidues
enable dark

set_view (\
    -0.553948820,    0.602683246,   -0.574331462,\
     0.600941598,   -0.187959343,   -0.776846230,\
    -0.576154888,   -0.775488377,   -0.258075565,\
    -0.000124957,   -0.000779778, -169.282318115,\
    18.592552185,   14.307555199,   -3.344673872,\
  -105.538856506,  445.155395508,  -20.000000000 )

scene 001, store

### scene 002, zoom into FAD ###

# FAD viewed from above
# set_view (\
#     -0.653456986,    0.738794208,    0.164719641,\
#      0.263321698,    0.425893098,   -0.865579426,\
#     -0.709652543,   -0.522246122,   -0.472859383,\
#      0.000000000,    0.000000000,  -56.387928009,\
#     16.364500046,   13.473999977,   -4.323500156,\
#     35.556224823,   77.219642639,  -20.000000000 )

# straight-on FAD view
set_view (\
    -0.183454648,    0.711812198,   -0.677945614,\
     0.832818806,   -0.253829241,   -0.491866827,\
    -0.522205234,   -0.654854476,   -0.546267748,\
    -0.000849493,   -0.000815576,  -43.361202240,\
    17.654739380,   14.739628792,   -1.816699982,\
    37.182384491,   50.566673279,  -20.000000000 )

scene 002, store

# ---------------------------------------------------

# splice in FAD excitation

### scene 004, hide cartoon ###

hide cartoon
hide sticks, ///C+D
hide sticks, fadresidues
hide sticks, ttdresidues
hide sticks, dnabinders

scene 104, store

### scene 005, morph dark --> 3 ps ###

disable dark
enable morph1a
hide dashes, dist*

# start of morph
scene 105, store


disable morph1a
enable 3ps
scene 003, store

# ---------------------------------------------------
### scene 003, move to TTD ###


show sticks, TTD
show surface, ttdresidues

# hide sticks, ///C/1-6
# hide sticks, ///C/9-14
# hide sticks, ///D
# hide sticks, ///A/376
# hide surface, ///A/TRP`421/O
# hide surface, ///A/ARG`256/C+CA

flag ignore, not ttdresidues, set
delete indicate
rebuild

scene 004, store

### scene 005, rotate to TTD

set_view (\
     0.773784280,   -0.556369722,    0.302750230,\
     0.515828192,    0.830891013,    0.208550721,\
    -0.367582053,   -0.005200058,    0.929945886,\
    -0.001346722,    0.000129901,  -54.507091522,\
    24.743465424,   14.245048523,    5.938860893,\
    -3.357263327,  112.522415161,  -20.000000000 )
scene 005, store


### scene 006 hide TTD
hide sticks, FAD
disable 3ps
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
#show cartoon, /100us//C+D

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

mview store, 170, scene=104
mview store, 180, scene=105
mview store, 181, state=1, object=morph1a
mview store, 240, state=60, object=morph1a
mview store, 241, scene=105

mview store, 260, scene=105
mview store, 280, scene=003
mview store, 300, scene=004
mview store, 380, scene=005
mview store, 400, scene=006

mview store, 451, scene=006
mview store, 451, state=1, object=morph1b
mview store, 480, state=30, object=morph1b
mview store, 480, scene=006

mview store, 481, scene=007
mview store, 481, state=1, object=morph1c
mview store, 510, state=30, object=morph1c
mview store, 510, scene=007

mview store, 511, scene=008
mview store, 511, state=1, object=morph1d
mview store, 540, state=30, object=morph1d
mview store, 540, scene=008

mview store, 541, scene=009
mview store, 541, state=1, object=morph2a
mview store, 570, state=30, object=morph2a
mview store, 570, scene=009

mview store, 571, scene=010
mview store, 571, state=1, object=morph2b
mview store, 600, state=30, object=morph2b
mview store, 600, scene=010

mview store, 601, scene=011
mview store, 601, state=1, object=morph2c
mview store, 630, state=30, object=morph2c
mview store, 630, scene=011
mview store, 660, scene=011

mview store, 680, scene=012
mview store, 740, scene=012
mview store, 741, state=1, object=morph2d
mview store, 800, state=30, object=morph2d
mview store, 800, scene=012

mview store, 801, scene=013
mview store, 801, state=1, object=morph3a
mview store, 920, state=60, object=morph3a
mview store, 920, scene=013

mview store, 921, scene=014
mview store, 921, state=1, object=morph3b
mview store, 1041, state=60, object=morph3b
mview store, 1041, scene=014

mview store, 1070, scene=014
mview store, 1170, scene=015
mview store, 1260, scene=016

mview reinterpolate
set movie_fps, 30
movie.produce short.mpeg, mode=draw, preserve=1, quality=100
