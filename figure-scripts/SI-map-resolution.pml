
from pymol import cmd, stored

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
set valence, 0


## loading dark structure ## 

load 3ns_deposit.pdb, 3ns
color purple, 3ns
color atomic, (not elem C) 


## coloring and selections, protein ##

select chainA, ///A
show sticks, ///A

select FAD, (c. A and r. FDA)
show sticks, FAD

select TTD, (c. C and i. 7-8)
show sticks, TTD


show spheres, ////HOH
set sphere_scale, 0.2
color red, 3ps and c. W

hide ////SO4
hide ///B
hide cartoon


## All maps ##

set mesh_width, 0.5
set mesh_quality, 6
set fog, 2

## misc ##

hide label, measure*
set ray_shadows, 0 
hide label

## set view to look at FAD ##

deselect
run SI-map-resolution.py
