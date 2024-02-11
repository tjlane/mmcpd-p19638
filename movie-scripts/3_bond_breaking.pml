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

# load 3ps_fdaA_polder.ccp4, polder
# map_double polder

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

# deselect
# mset 1x560


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

# scene 001, store

# ### scene 002, zoom into FAD ###

set_view (\
    -0.653456986,    0.738794208,    0.164719641,\
     0.263321698,    0.425893098,   -0.865579426,\
    -0.709652543,   -0.522246122,   -0.472859383,\
     0.000000000,    0.000000000,  -56.387928009,\
    16.364500046,   13.473999977,   -4.323500156,\
    35.556224823,   77.219642639,  -20.000000000 )

# scene 002, store

# unbond /morph4//C/TT6`7/C6, /morph4//C/TT6`7/C6T

# # ---------------------- #


# mview store,   1, scene=001
# mview store,  60, scene=001
# mview store, 120, scene=002
# mview store, 180, scene=003
# mview store, 230, scene=004
# mview store, 241, scene=005
# mview store, 241, state=1, object=morph1
# mview store, 300, state=30, object=morph1
# mview store, 301, scene=006
# mview store, 302, scene=007


#mview reinterpolate

#movie.produce bondbreaking.mpeg, mode=draw, quality=1
