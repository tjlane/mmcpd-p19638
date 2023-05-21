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

load superdark_deposit.pdb, dark
load 3ps_deposit.pdb, 3ps

load 3ps_deposit_2fofc.map, dens

color gray90, dark
color purple, 3ps
color atomic, (not elem C) 


## coloring and selections, protein ##
hide ///B/FDA
select FAD, ///A/FDA
show sticks, FAD

select residues, ///A/414 + ///A/256-257
show sticks, residues

select TTD, ///C/7+8
show sticks, TTD
#set stick_transparency, 0.7, TTD

color atomic, (not elem C) 

## cartoons/surface ##
hide cartoon
hide cartoon, ////290-311
hide cartoon, ////162-172

## coloring and selections, waters ##

hide ////HOH
hide ////SO4

#select water, ////HOH within 6. of FAD
select water, /dark//W/46+14+51+26+5+162+129
select lightwater, /3ps//W/5+37+95+40
show sphere, water
show sphere, lightwater

set sphere_scale, 0.2
colour gray90, dark and c. W
colour red, 3ps and c. W

## All maps ##

set mesh_width, 0.8
set mesh_quality, 6
set fog, 2

#isomesh dens_mesh, dens, 1.5, pl, selection=(water), carve=1.6
#color skyblue, dens_mesh
#map_double dens

load 3ps_fofo.map, 3ps_FoFomap
map_double 3ps_FoFomap

# isomesh 3ps_FoFomap_pos, 3ps_FoFomap, 4.5, 3ps, selection=(FAD), carve=2.5
# isomesh 3ps_FoFomap_neg, 3ps_FoFomap, -4.5, 3ps, selection=(FAD), carve=2.5
# color teal, 3ps_FoFomap_pos
# color orange, 3ps_FoFomap_neg

isomesh 3ps_FoFomap_pos_w, 3ps_FoFomap, 5, 3ps, selection=(water or residues or FAD or TTD), carve=2.5
isomesh 3ps_FoFomap_neg_w, 3ps_FoFomap, -5, 3ps, selection=(water or residues or FAD or TTD), carve=2.5
color teal, 3ps_FoFomap_pos_w
color orange, 3ps_FoFomap_neg_w


## misc ##
set ray_shadows, 0 
set ray_trace_mode, 0

distance /dark//W/HOH`162/O, /dark//A/FDA`470/N1A
distance /dark//W/HOH`162/O, /dark//A/ASN`414/O
distance /dark//W/HOH`162/O, /dark//W/HOH`129/O

distance /dark//W/HOH`26/O, /dark//A/FDA`470/N7A
distance /dark//W/HOH`26/O, /dark//W/HOH`46/O
distance /dark//W/HOH`26/O, /dark//A/ARG`256/NH2

color red, dist*
hide label
#set label_size, 18

## set view to look at FAD ##

deselect

set_view (\
    -0.386517107,    0.541380048,    0.746568680,\
     0.517798662,   -0.542450190,    0.661454678,\
     0.763103187,    0.642282188,   -0.070636921,\
     0.000875482,    0.000274428,  -48.565685272,\
    18.465948105,   15.781648636,    0.062743902,\
    30.351612091,   64.271095276,  -20.000000000 )

#draw 2048,2048
ray 2048,2048
