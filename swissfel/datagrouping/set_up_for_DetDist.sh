#!/bin/bash

# Set up submit_crystfel_SwissFEL_DetDist_reserv-DEFAULT.sh for every reservoir directory
MAINPATH=/sf/alvra/data/p19638/work/DetDist_opti

for ireserv in {4..59};do
        echo $MAINPATH/submit_crystfel_SwissFEL_DetDist_reserv-DEFAULT.sh
        cp $MAINPATH/submit_crystfel_SwissFEL_DetDist_reserv-DEFAULT.sh $MAINPATH/reserv_$ireserv/submit_crystfel_SwissFEL_DetDist_reserv-${ireserv}.sh
        cd reserv_$ireserv
        sed -i "s/DEFAULT/$ireserv/g" "submit_crystfel_SwissFEL_DetDist_reserv-${ireserv}.sh"
        cd $MAINPATH
done

