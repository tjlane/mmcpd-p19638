#!/bin/bash

 #Script that makes lst of images for DARK data set to use as input for the detector distance optimasation. 
 #the savepath-s have been grouped by the number of the reservoir (i.e. injector). E.g. reserv_4 corresponds to 
 #runs 19 to 20, resev_47 corresponds to runs 153 to 155 etc. A full list of the reservoirs that change during the 
 #experiment and the corresponding runs, can be found: 
 #https://github.com/virginia4/Swissfel_beamtime_pn-19638/pl_reserv_grouped.csv


DATAPATH=/sf/alvra/data/p19638/work/online
RUNPATH=/sf/alvra/data/p19638/work/DetDist_opti
for res in {32..59};do
SAVEPATH=/sf/alvra/data/p19638/work/DetDist_opti/reserv_$res


cd $DATAPATH
echo $DATAPATH 

        if (($res == 32));then
                echo 'Listing images for reservoir' $res
		echo 'From run 110 to 113'
		printf 'reserv_RUNS=0110-0113\nreserv_DELAY=30e-6' >> $SAVEPATH/conf_reserv_${res}.txt      
        elif (($res == 33));then 
                echo 'Listing images for reservoir' $res
		echo 'Listing images for reservoir' $res
                echo 'From run 114 to 115'
                printf 'reserv_RUNS=0114-0115\nreserv_DELAY=30e-6' >> $SAVEPATH/conf_reserv_${res}.txt                
      elif (($res == 34));then
               echo 'Listing images for reservoir' $res
               echo 'From run 116 to 117'
               printf 'reserv_RUNS=0116-0117\nreserv_DELAY=30e-6' >> $SAVEPATH/conf_reserv_${res}.txt
       elif (($res == 36));then
               echo 'Listing images for reservoir' $res
	       printf 'reserv_RUNS=0118-0121\nreserv_DELAY=10e-5' >> $SAVEPATH/conf_reserv_${res}.txt
      elif (($res == 37));then
               echo 'Listing images for reservoir' $res
	       printf 'reserv_RUNS=0122-0128\nreserv_DELAY=10e-5' >> $SAVEPATH/conf_reserv_${res}.txt
       elif (($res == 38));then
               echo 'Listing images for reservoir' $res
		printf 'reserv_RUNS=0129-0133\nreserv_DELAY=10e-5' >> $SAVEPATH/conf_reserv_${res}.txt
       elif (($res == 39));then
               echo 'Listing images for reservoir' $res
         	printf 'reserv_RUNS=0135\nreserv_DELAY=10e-5' >> $SAVEPATH/conf_reserv_${res}.txt 
       elif (($res == 40));then
               echo 'Listing images for reservoir' $res
		printf 'reserv_RUNS=0136\nreserv_DELAY=10e-5' >> $SAVEPATH/conf_reserv_${res}.txt              
       elif (($res == 41));then
               echo 'Listing images for reservoir' $res
	printf 'reserv_RUNS=0137\nreserv_DELAY=10e-5' >> $SAVEPATH/conf_reserv_${res}.txt               
       elif (($res == 42));then
               echo 'Listing images for reservoir' $res
		printf 'reserv_RUNS=0138-0141\nreserv_DELAY=10e-5+10e-9' >> $SAVEPATH/conf_reserv_${res}.txt               
       elif (($res == 43));then
               echo 'Listing images for reservoir' $res
		printf 'reserv_RUNS=0143-145\nreserv_DELAY=10e-9' >> $SAVEPATH/conf_reserv_${res}.txt       
       elif (($res == 44));then
               echo 'Listing images for reservoir' $res
        	printf 'reserv_RUNS=0146-148\nreserv_DELAY=10e-9+1e-9' >> $SAVEPATH/conf_reserv_${res}.txt       
       elif (($res == 45));then
               echo 'Listing images for reservoir' $res
		printf 'reserv_RUNS=0149\nreserv_DELAY=1e-9' >> $SAVEPATH/conf_reserv_${res}.txt               
       elif (($res == 46));then
               echo 'Listing images for reservoir' $res
		printf 'reserv_RUNS=0150-152\nreserv_DELAY=1e-9' >> $SAVEPATH/conf_reserv_${res}.txt               
       elif (($res == 47));then
               echo 'Listing images for reservoir' $res
		printf 'reserv_RUNS=0153-155\nreserv_DELAY=1e-9+3e-9' >> $SAVEPATH/conf_reserv_${res}.txt              
       elif (($res == 48));then
               echo 'Listing images for reservoir' $res
	       echo "NOTE::::: run0156 doesn't exists"
		printf 'reserv_RUNS=0157-158\nreserv_DELAY=3e-9' >> $SAVEPATH/conf_reserv_${res}.txt               
       elif (($res == 49));then
               echo 'Listing images for reservoir' $res
		printf 'reserv_RUNS=0159\nreserv_DELAY=3e-9' >> $SAVEPATH/conf_reserv_${res}.txt               
       elif (($res == 50));then
               echo 'Listing images for reservoir' $res
		printf 'reserv_RUNS=0160-162\nreserv_DELAY=3e-9' >> $SAVEPATH/conf_reserv_${res}.txt               
       elif (($res == 51));then
               echo 'Listing images for reservoir' $res
		printf 'reserv_RUNS=0163-166\nreserv_DELAY=3e-9' >> $SAVEPATH/conf_reserv_${res}.txt       
       elif (($res == 52));then
               echo 'Listing images for reservoir' $res
		printf 'reserv_RUNS=0167-169\nreserv_DELAY=3e-9+30e-11' >> $SAVEPATH/conf_reserv_${res}.txt       
       elif (($res == 53));then
               echo 'Listing images for reservoir' $res
	       echo "NOTE::::: run0172 doesn't exists"
		printf 'reserv_RUNS=0170-173\nreserv_DELAY=30e-11' >> $SAVEPATH/conf_reserv_${res}.txt               
       elif (($res == 54));then
               echo 'Listing images for reservoir' $res
               echo "NOTE::::: run0174 doesn't exists"
		printf 'reserv_RUNS=0175\nreserv_DELAY=30e-11' >> $SAVEPATH/conf_reserv_${res}.txt	       
       elif (($res == 55));then
               echo 'Listing images for reservoir' $res
		printf 'reserv_RUNS=0176-178\nreserv_DELAY=30e-11+10e-6' >> $SAVEPATH/conf_reserv_${res}.txt       
       elif (($res == 56));then
               echo 'Listing images for reservoir' $res
		printf 'reserv_RUNS=0179\nreserv_DELAY=10e-6' >> $SAVEPATH/conf_reserv_${res}.txt               
       elif (($res == 57));then
               echo 'Listing images for reservoir' $res
		printf 'reserv_RUNS=0181\nreserv_DELAY=10e-6' >> $SAVEPATH/conf_reserv_${res}.txt       
       elif (($res == 58));then
               echo 'Listing images for reservoir' $res
		printf 'reserv_RUNS=0182-183\nreserv_DELAY=10e-6' >> $SAVEPATH/conf_reserv_${res}.txt       
       elif (($res == 59));then
               echo 'Listing images for reservoir' $res
		printf 'reserv_RUNS=0184-185\nreserv_DELAY=10e-6+10e-9' >> $SAVEPATH/conf_reserv_${res}.txt       
       fi
done
