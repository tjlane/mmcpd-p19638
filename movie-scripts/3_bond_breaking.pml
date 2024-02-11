reinitialize
delete all
space cmyk

cd /Users/tjlane/My\ Drive\ (thomas.joseph.lane@gmail.com)/Research/Research Projects/photolyases/PL\ CPD/PL\ mmCPD/mmcpd-paper/movies/3_bond_breaking


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

load 300ps_deposit.pdb, 300ps
color purple, 300ps

load 1ns_deposit.pdb, 1ns
color purple, 1ns

load 3ns_deposit-tt-rename-noanisou.pdb, 3ns
color purple, 3ns



morph morph1, /dark//C/7, /3ps//C/7, method="linear", refinement=0
morph morph2, /3ps//C/7, /300ps//C/7, method="linear", refinement=0
morph morph3, /300ps//C/7, /1ns//C/7, method="linear", refinement=0
morph morph4, /1ns//C/7, /3ns//C/7, method="linear", refinement=0

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
deselect

### start movie, zoomed out overview of protein ###

deselect
mset 1x1200


# ### scene 001, zoomed out overview of protein ###

enable dark
disable 3ps
disable 300ps
disable 1ns
disable 3ns

disable morph1
disable morph2
disable morph3
disable morph4


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
     0.790886343,   -0.608831823,    0.061472304,\
     0.427410096,    0.621504307,    0.656508505,\
    -0.437907457,   -0.492954880,    0.751779318,\
    -0.000131609,    0.000151294,  -56.331829071,\
    22.421852112,    9.106984138,   -0.546686649,\
    46.076141357,   66.699737549,  -20.000000000 )

scene 003, store

# ### scene 004, load dark map, rock ###

load superdark_2mFextr-DFc.map, densmap
map_double densmap
#map_double densmap
isomesh ttd_mesh, densmap, 2.5, mmcpd, selection=TTD, carve=1.5
color skyblue, ttd_mesh

set_view (\
     0.790886343,   -0.608831823,    0.061472304,\
     0.427410096,    0.621504307,    0.656508505,\
    -0.437907457,   -0.492954880,    0.751779318,\
    -0.000131609,    0.000151294,  -56.331829071,\
    22.421852112,    9.106984138,   -0.546686649,\
    46.076141357,   66.699737549,  -20.000000000 )

#movie.rock 8, 45, start=230, stop=300, loop="on"

scene 004, store

# ### scene 005, remove dark map, rock ###

disable ttd_mesh
hide sticks, /dark//C/7
show sticks, /dark//C/TTD`7/O3'
show sticks, /dark//C/TTD`7/O3'
enable morph1

scene 005, store

# ### scene 006 ###

disable morph1
enable morph2

scene 006, store

# ### scene 007 ###

disable morph2
enable morph3

scene 007, store

# ### scene 008 -- 1 ns map & rock ###


load 1ns_ttd_polder.map, 1nsdensmap
map_double 1nsdensmap
isomesh 1ns_mesh, 1nsdensmap, 6.0, mmcpd, selection=TTD, carve=1.6
color skyblue, 1ns_mesh
set_view (\
     0.790886343,   -0.608831823,    0.061472304,\
     0.427410096,    0.621504307,    0.656508505,\
    -0.437907457,   -0.492954880,    0.751779318,\
    -0.000131609,    0.000151294,  -56.331829071,\
    22.421852112,    9.106984138,   -0.546686649,\
    46.076141357,   66.699737549,  -20.000000000 )

scene 008, store

disable 1ns_mesh
scene 009, store

# ### scene 009 ###

disable morph3
enable morph4
unbond /morph4//C/TT6`7/C6, /morph4//C/TT6`7/C6T

scene 010, store


load 3ns_ttd_polder.map, 3nsdensmap
map_double 3nsdensmap
isomesh 3ns_mesh, 3nsdensmap, 4.5, mmcpd, selection=TTD, carve=1.6
color skyblue, 3ns_mesh
set_view (\
     0.790886343,   -0.608831823,    0.061472304,\
     0.427410096,    0.621504307,    0.656508505,\
    -0.437907457,   -0.492954880,    0.751779318,\
    -0.000131609,    0.000151294,  -56.331829071,\
    22.421852112,    9.106984138,   -0.546686649,\
    46.076141357,   66.699737549,  -20.000000000 )


scene 011, store

# # ---------------------- #

mview store,   1, scene=001
mview store,  60, scene=001
mview store, 120, scene=002
mview store, 140, scene=002
mview store, 180, scene=003
mview store, 200, scene=004
movie.rock first=200, last=320, angle=360, axis=y, loop=0, phase=90
mview store, 360, scene=004

mview store, 361, scene=005
mview store, 361, state=1, object=morph1
mview store, 400, state=30, object=morph1
mview store, 400, scene=005

mview store, 401, scene=006
mview store, 401, state=1, object=morph2
mview store, 460, state=30, object=morph2
mview store, 460, scene=006

mview store, 461, scene=007
mview store, 461, state=1, object=morph3
mview store, 500, state=30, object=morph3
mview store, 500, scene=007

mview store, 550, scene=008
movie.rock first=580, last=700, angle=360, axis=y, loop=0, phase=90
mview store, 740, scene=008
mview store, 761, scene=009

mview store, 800, scene=009
mview store, 801, scene=010
mview store, 801, state=1, object=morph4
mview store, 840, state=30, object=morph4
mview store, 840, scene=010

mview store, 880, scene=010
mview store, 900, scene=011
movie.rock first=900, last=1020, angle=360, axis=y, loop=0, phase=90
mview store, 1200, scene=011

mview reinterpolate
movie.produce bondbreaking.mpeg, mode=draw, quality=1
