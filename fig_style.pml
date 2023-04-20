delete all
space cmyk

### make background and overall style of protein ###
bg_col white

as cartoon
set cartoon_side_chain_helper, off
set cartoon_rect_length, 0.7
set cartoon_oval_length, 0.7
set stick_radius, 0.15
set cartoon_transparency, 0.7

## loading dark structure ## 

load superdark_deposit.pdb, dark
color gray80, dark
color atomic, (not elem C) 

## loading and visualising 3 ps model and FoFo map ##

load 3ps_deposit.pdb, 3ps

color limegreen, 3ps
color atomic, (not elem C) 

load 3ps_grid.map, 3ps_FoFomap

isomesh 3ps_FoFomap_pos, 3ps_FoFomap, 4, 3ps, carve=2.4
isomesh 3ps_FoFomap_neg, 3ps_FoFomap, -4, 3ps, carve=2.4
color orange, 3ps_FoFomap_pos
color blue, 3ps_FoFomap_neg

hide everything, c. C and i. 5-9
select TTD, (c. C and i. 5-9)
show sticks, TTD
select FAD, (c. A and r. FDA)
show sticks, FAD
select residues, (c. A and i. 162-164+253-257+263-268+301+305+376-379+400-403+406-410)
show sticks, residues


## make sure water are spheres and model color instead of red (from atomic colouring) ###
#as spheres, r. hoh
hide ////HOH 
select ////HOH within 5. of ////FDA or ///C+E/7+8
show sphere, sele
set sphere_scale, 0.2
colour gray80, dark and c. W
colour red, 3ps and c. W

set cartoon_side_chain_helper, on
set mesh_width, 0.3
set mesh_quality, 6
set fog, 0.5

#### set view to look at FAD ##### 

set_view (\
     0.382947296,    0.757058084,   -0.529347658,\
     0.921122193,   -0.356249958,    0.156873375,\
    -0.069822066,   -0.547670543,   -0.833769083,\
    -0.000159881,    0.000004459,  -55.423095703,\
    14.991762161,   12.919754028,   -4.758465290,\
    50.456428528,   60.392276764,  -20.000000000 )

set ray_shadows, 0 
#set ray_trace_mode, on
