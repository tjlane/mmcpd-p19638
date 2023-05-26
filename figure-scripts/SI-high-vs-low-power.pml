
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

load superdark_deposit.pdb, dark
color gray90, dark
load 10ns_deposit.pdb, 10ns
color purple, 10ns
color atomic, (not elem C) 


## coloring and selections, protein ##

select chainA, ///A
show cartoon, ///A

select FAD, (c. A and r. FDA)
show sticks, FAD

select TTD, (c. C and i. 7-8)
show sticks, TTD

select arg, (c. A and i. 256)
show sticks, arg

hide ////HOH
hide ////SO4
hide ///B


## All maps ##

set mesh_width, 1.0
set mesh_quality, 6
set fog, 2

## misc ##

hide label, measure*
set ray_shadows, 0 
hide label

## set view to look at FAD ##

deselect
run SI-high-vs-low-power.py



