
reinitialize
delete all

bg_col white
as cartoon
#set cartoon_side_chain_helper, off
set cartoon_rect_length, 0.5
set cartoon_oval_length, 0.5
set stick_radius, 0.25
set cartoon_transparency, 0.3
set surface_color, grey

fetch 1fcd
fetch 1cf3
fetch 1fdr
fetch 1qlt
fetch 1ivh
fetch 1b5t
fetch 1qr2
fetch 8oet

remove /1fcd//B+D
remove /1qlt//B
remove /1ivh//B+C+D
remove /1b5t//B+C+D
remove /1qr2//B
remove /8oet//B+C+D+E+F

hide all
show cartoon
show sticks, ////FAD+FDA

color grey90
color orange, ////FAD+FDA
color purple, /8oet///FDA
color atomic, (not elem C)
set cartoon_transparency, 0.7

align /1cf3///FAD, /1fcd///FAD
align /1fdr///FAD, /1fcd///FAD
align /1qlt///FAD, /1fcd///FAD
align /1ivh///FAD, /1fcd///FAD
align /1b5t///FAD, /1fcd///FAD
align /1qr2///FAD, /1fcd///FAD
align /8oet///FDA, /1fcd///FAD


set_view (\
     0.366640180,   -0.308051884,    0.877881646,\
     0.063073508,    0.949651003,    0.306893289,\
    -0.928222179,   -0.057148524,    0.367610782,\
    -0.000002533,    0.000005919, -283.644775391,\
     1.304355145,   -6.877388000,   15.628826141,\
   223.627700806,  343.661834717,  -20.000000000 )


set ray_trace_mode, 1 

disable *

enable 1fcd
ray 1024,1024
save 1fcd.png
disable 1fcd

enable 1cf3
ray 1024,1024
save 1cf3.png
disable 1cf3

enable 1fdr
ray 1024,1024 
save 1fdr.png
disable 1fdr

enable 1qlt
ray 1024,1024
save 1qlt.png
disable 1qlt

enable 1ivh
ray 1024,1024
save 1ivh.png
disable 1ivh

enable 1b5t
ray 1024,1024
save 1b5t.png
disable 1b5t

enable 1qr2
ray 1024,1024
save 1qr2.png
disable 1qr2

enable 8oet
ray 1024,1024
save 8oet.png
disable 8oet
