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

fetch 8oet, dark
#color gray90, dark
color purple, dark
color atomic, (not elem C) 


## coloring and selections, protein ##

select TTD, (c. C and i. 7-8) or (c. C and i. 9)
show sticks, TTD
select DNA, (c. C and i. 6-12)
select comp, (c. D and i. 4-10)


color atomic, (not elem C) 
color lightblue, ///C+D
color skyblue, ///C/7+8/C2+C3+C4+C5+C6+C7
color grey90, /dark//C/7+8
color atomic, (not elem C and TTD) 
color atomic, (elem P)

select ttdresidues, (c. A and i. 164+429+441+450+451+115+439+431)
show sticks, ttdresidues

hide ////FDA
hide ////115
hide cartoon

set cartoon_ring_mode, 2
show cartoon, /dark//C+D

select dna_shown, /dark//C/9+10+12 or /dark//D/8+9+10
show sticks, dna_shown
color atomic, (not elem C and dna_shown)

## coloring and selections, waters ##

hide ////HOH
hide ////SO4

## All maps ##


set mesh_width, 0.6
set mesh_quality, 6
set fog, 0.5

## misc ##

distance /dark//A/ARG`164/NH1, /dark//C/7/OP2
distance /dark//D/DG`10/P, /dark//A/LYS`439/NZ
distance /dark//D/DA`9/N3, /dark//A/ARG`429/NH1
distance /dark//D/DA`8/N1, /dark//A/ARG`429/NH2
distance /dark//C/DG`12/C6, /dark//A/ARG`450/NH2
distance /dark//C/DG`12/N7, /dark//A/ARG`450/NH1
distance /dark//C/DG`10/P  /dark//A/LYS`451/NZ
distance /dark//C/DG`10/P, /dark//A/LYS`451/NZ

distance /dark//C/DC`9/P , /dark//A/LYS`451/NZ
distance /dark//A/ARG`441/NH1, /dark//C/7/O4P
distance /dark//A/ARG`441/NH2, /dark//C/7/O4P
# color red, dist08
# color red, dist09
# color red, dist10

hide label, dist*
set ray_shadows, 0 


## set view to look at FAD ##

deselect
set_view (\
     0.247142300,   -0.599403441,    0.761306167,\
     0.957883239,    0.269575000,   -0.098703325,\
    -0.146059677,    0.753647327,    0.640787721,\
    -0.000420153,    0.000655442, -193.030563354,\
    27.613819122,    6.417916298,    2.374462128,\
    97.185455322,  288.470611572,  -20.000000000 )
set ray_trace_mode, 1
ray 2048,4096

