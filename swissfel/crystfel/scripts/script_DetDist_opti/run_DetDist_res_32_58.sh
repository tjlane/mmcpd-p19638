#!/bin/bash

MAINPATH=/sf/alvra/data/p19638/work/DetDist_opti
for ires in {32..59}; do
	RUNPATH=$MAINPATH/reserv_$ires
	cd $RUNPATH
	chmod +x submit_crystfel_SwissFEL_DetDist_reserv-${ires}.sh
	./submit_crystfel_SwissFEL_DetDist_reserv-${ires}.sh
	cd $MAINPATH
done	
