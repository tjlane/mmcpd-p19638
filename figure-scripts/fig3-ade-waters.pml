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
#show sticks, FAD

sele /dark//A/FDA`470/O5B or \
/dark//A/FDA`470/C5B or \
/dark//A/FDA`470/C4B or \
/dark//A/FDA`470/C3B or \
/dark//A/FDA`470/O3B or \
/dark//A/FDA`470/O2B or \
/dark//A/FDA`470/C2B or \
/dark//A/FDA`470/C1B or \
/dark//A/FDA`470/O4B or \
/dark//A/FDA`470/N9A or \
/dark//A/FDA`470/C8A or \
/dark//A/FDA`470/N7A or \
/dark//A/FDA`470/C5A or \
/dark//A/FDA`470/C4A or \
/dark//A/FDA`470/N3A or \
/dark//A/FDA`470/C2A or \
/dark//A/FDA`470/N1A or \
/dark//A/FDA`470/C6A or \
/dark//A/FDA`470/N6A

set_name sele, ADE
show sticks, ADE

select residues, ///A/414 + ///A/256 # -257
show sticks, residues

select TTD, ///C/7+8
show sticks, TTD
#set stick_transparency, 0.7, TTD

hide sticks, ///A/FDA`470/P
hide sticks, ///A/FDA`470/O1P
hide sticks, ///A/FDA`470/O2P
hide sticks, ///A/FDA`470/O5'
hide sticks, ///A/FDA`470/C5'
hide sticks, ///A/FDA`470/O4'
hide sticks, ///A/FDA`470/C4'
hide sticks, ///A/FDA`470/C3'
hide sticks, ///A/FDA`470/O3'
hide sticks, ///A/FDA`470/C2'
hide sticks, ///A/FDA`470/O2'
hide sticks, ///A/FDA`470/C1'
hide sticks, ///A/FDA`470/N10
hide sticks, ///A/FDA`470/C9A
hide sticks, ///A/FDA`470/C9
hide sticks, ///A/FDA`470/C8
hide sticks, ///A/FDA`470/C8M
hide sticks, ///A/FDA`470/C7M
hide sticks, ///A/FDA`470/C6
hide sticks, ///A/FDA`470/C5X
hide sticks, ///A/FDA`470/C7
hide sticks, ///A/FDA`470/N5
hide sticks, ///A/FDA`470/C4X
hide sticks, ///A/FDA`470/C10
hide sticks, ///A/FDA`470/N1
hide sticks, ///A/FDA`470/C2
hide sticks, ///A/FDA`470/N3
hide sticks, ///A/FDA`470/C4
hide sticks, ///A/FDA`470/O4
hide sticks, ///A/FDA`470/O2

# hide sticks, ///C/TTD`7/O4
# hide sticks, ///C/TTD`7/C4
# hide sticks, ///C/TTD`7/N3
# hide sticks, ///C/TTD`7/C5
# hide sticks, ///C/TTD`7/C5A
# hide sticks, ///C/TTD`7/C2
# hide sticks, ///C/TTD`7/O2

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

color skyblue, /3ps///TTD
color atomic, (not elem C) 

color gray90, dark and c. W
color red, 3ps and c. W

## All maps ##

set mesh_width, 0.8
set mesh_quality, 6
set fog, 2

#isomesh dens_mesh, dens, 1.5, pl, selection=(water), carve=1.6
#color skyblue, dens_mesh
#map_double dens

load 3ps_fofo.map, 3ps_FoFomap
map_double 3ps_FoFomap

isomesh 3ps_FoFomap_pos_w, 3ps_FoFomap, 4.5, 3ps, selection=(water or ADE or TTD), carve=2.0
isomesh 3ps_FoFomap_neg_w, 3ps_FoFomap, -4.5, 3ps, selection=(water or ADE or TTD), carve=2.0
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

distance /dark//W/HOH`26/O, /dark//W/HOH`51/O
distance /dark//W/HOH`51/O, /dark//W/HOH`14/O

color red, dist*

distance /dark//A/FDA`470/N6A, /dark//C/TTD`7/O4T
distance /dark//W/HOH`51/O, /dark//C/TTD`7/N3T

hide label
#set label_size, 18

## set view to look at FAD ##

deselect

set_view (\
    -0.288780630,    0.656928122,    0.696341932,\
     0.666090310,   -0.384524882,    0.639018714,\
     0.687579215,    0.648418725,   -0.326526016,\
     0.000491910,   -0.001407549,  -37.817428589,\
    20.718524933,   15.873752594,   -0.232067108,\
  -2750.992431641, 2820.099365234,  -20.000000000 )

# set_view (\
#     -0.386517107,    0.541380048,    0.746568680,\
#      0.517798662,   -0.542450190,    0.661454678,\
#      0.763103187,    0.642282188,   -0.070636921,\
#      0.000875482,    0.000274428,  -48.565685272,\
#     18.465948105,   15.781648636,    0.062743902,\
#     30.351612091,   64.271095276,  -20.000000000 )

#draw 2048,2048
ray 2048,2048
