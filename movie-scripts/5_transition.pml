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


load 3ps_deposit.pdb, 3ps
color purple, 3ps

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
mset 1x120


### scene 001, zoomed out overview of protein ###

enable 3ps

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
scene 001, store

# -------------------------------------------------------------

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


set_view (\
     0.755285740,   -0.631650627,    0.174692675,\
     0.343721777,    0.608748019,    0.715004206,\
    -0.557978749,   -0.479992092,    0.676909506,\
    -0.000131609,    0.000151294,  -56.331829071,\
    22.421852112,    9.106984138,   -0.546686649,\
    42.470817566,   70.305023193,  -20.000000000 )
scene 002, store

# ---------------------- #


mview store,   1, scene=001
mview store,  60, scene=002
mview store,  120, scene=002


mview reinterpolate
set movie_fps, 30

movie.produce transition.mpeg, mode=draw, quality=100, preserve=1
