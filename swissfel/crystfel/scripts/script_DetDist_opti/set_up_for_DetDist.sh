#!/bin/bash

# Set up submit_crystfel_SwissFEL_DetDist_reserv-DEFAULT.sh for every reservoir directory
MAINPATH=/sf/alvra/data/p19638/work/DetDist_opti

for ireserv in {9..59};do 
	echo $MAINPATH/submit_crystfel_SwissFEL_DetDist_reserv-DEFAULT.sh
	cp $MAINPATH/submit_crystfel_SwissFEL_DetDist_reserv-DEFAULT.sh $MAINPATH/reserv_$ireserv/submit_crystfel_SwissFEL_DetDist_reserv-${ireserv}.sh
	cd reserv_$ireserv
	cat *.lst >>reserv_${ireserv}_all.lst
	sed -i "s/DEFAULT_RES/$ireserv/g" "submit_crystfel_SwissFEL_DetDist_reserv-${ireserv}.sh"
	sed -i "s/DEFAULT_TYPE/d+l/g" "submit_crystfel_SwissFEL_DetDist_reserv-${ireserv}.sh"
	cd $MAINPATH


done



