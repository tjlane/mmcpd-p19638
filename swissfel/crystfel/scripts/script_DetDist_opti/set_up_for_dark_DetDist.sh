#!/bin/bash

# Set up submit_crystfel_SwissFEL_DetDist_reserv-DEFAULT.sh for every reservoir directory
MAINPATH=/sf/alvra/data/p19638/work/DetDist_opti

for ireserv in {4..59};do
	DARKPATH=/sf/alvra/data/p19638/work/DetDist_opti/reserv_${ireserv}/dark_DetDist
	cp $MAINPATH/DetDist_pl.py $DARKPATH
        cp $MAINPATH/DetDist_pl.sh $DARKPATH
	echo $MAINPATH/submit_crystfel_SwissFEL_DetDist_reserv_dark-DEFAULT.sh
	# cd reserv_$ireserv
	#mkdir dark_DetDist
	cp $MAINPATH/submit_crystfel_SwissFEL_DetDist_reserv_dark-DEFAULT.sh $MAINPATH/reserv_$ireserv/dark_DetDist/submit_crystfel_SwissFEL_DetDist_reserv_dark-${ireserv}.sh
	cd reserv_$ireserv
#	rm dark_DetDist
	#cp $MAINPATH/reserv_$ireserv/dark_reserv_${ireserv}.lst $DARKPATH
	cp $MAINPATH/reserv_$ireserv/conf_reserv_${ireserv}.txt $DARKPATH
	cd dark_DetDist
	sed -i "s/DEFAULT_RES/$ireserv/g" "submit_crystfel_SwissFEL_DetDist_reserv_dark-${ireserv}.sh"
	sed -i "s/DEFAULT_TYPE/d/g" "submit_crystfel_SwissFEL_DetDist_reserv_dark-${ireserv}.sh"
	cd $MAINPATH


done



