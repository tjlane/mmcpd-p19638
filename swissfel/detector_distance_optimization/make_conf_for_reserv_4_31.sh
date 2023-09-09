#!/bin/bash

#Make configuations file for each reservoir -->4 to 31 (another script will take care of 32 to 59). 
#The configution file is then read from 
#submit_crystfel_SwissFEL_DetDist_reserv-DEFAULT.sh and takes the valeus runs and laser delay. 
#These variables are used to then name the output files (stream and log)

DATAPATH=/sf/alvra/data/p19638/work/online
RUNPATH=/sf/alvra/data/p19638/work/DetDist_opti
for res in {4..31};do
SAVEPATH=/sf/alvra/data/p19638/work/DetDist_opti/reserv_$res


cd $DATAPATH
echo $DATAPATH 

        if (($res == 4));then
                echo 'Listing images for reservoir' $res
		printf 'reserv_RUNS=0019-0020\nreserv_DELAY=30e-6' >> $SAVEPATH/conf_reserv_${res}.txt      
        elif (($res == 5));then 
                echo 'Listing images for reservoir' $res
                printf 'reserv_RUNS=0021-0022\nreserv_DELAY=30e-6' >> $SAVEPATH/conf_reserv_${res}.txt                
      elif (($res == 6));then
               echo 'Listing images for reservoir' $res
               printf 'reserv_RUNS=0023-0033\nreserv_DELAY=30e-6' >> $SAVEPATH/conf_reserv_${res}.txt
       elif (($res == 7));then
               echo 'Listing images for reservoir' $res
	       printf 'reserv_RUNS=0034-0037\nreserv_DELAY=10e-5' >> $SAVEPATH/conf_reserv_${res}.txt
      elif (($res == 8));then
               echo 'Listing images for reservoir' $res
	       printf 'reserv_RUNS=0038-0040\nreserv_DELAY=10e-5' >> $SAVEPATH/conf_reserv_${res}.txt
       elif (($res == 9));then
               echo 'Listing images for reservoir' $res
		printf 'reserv_RUNS=0041-0042\nreserv_DELAY=10e-5' >> $SAVEPATH/conf_reserv_${res}.txt
       elif (($res == 10));then
               echo 'Listing images for reservoir' $res
         	printf 'reserv_RUNS=0043-0045\nreserv_DELAY=10e-5' >> $SAVEPATH/conf_reserv_${res}.txt 
       elif (($res == 11));then
               echo 'Listing images for reservoir' $res
		printf 'reserv_RUNS=0046-0048\nreserv_DELAY=10e-5' >> $SAVEPATH/conf_reserv_${res}.txt              
       elif (($res == 12));then
               echo 'Listing images for reservoir' $res
		printf 'reserv_RUNS=0049-0050\nreserv_DELAY=10e-5' >> $SAVEPATH/conf_reserv_${res}.txt               
       elif (($res == 13));then
               echo 'Listing images for reservoir' $res
		printf 'reserv_RUNS=0051-0054\nreserv_DELAY=10e-5+10e-9' >> $SAVEPATH/conf_reserv_${res}.txt               
       elif (($res == 14));then
               echo 'Listing images for reservoir' $res
		printf 'reserv_RUNS=0055-0056\nreserv_DELAY=10e-9' >> $SAVEPATH/conf_reserv_${res}.txt       
       elif (($res == 15));then
               echo 'Listing images for reservoir' $res
        	printf 'reserv_RUNS=0057-0059\nreserv_DELAY=10e-9+1e-9' >> $SAVEPATH/conf_reserv_${res}.txt       
       elif (($res == 16));then
               echo 'Listing images for reservoir' $res
		printf 'reserv_RUNS=0060-0064\nreserv_DELAY=1e-9' >> $SAVEPATH/conf_reserv_${res}.txt               
       elif (($res == 17));then
               echo 'Listing images for reservoir' $res
		printf 'reserv_RUNS=0065-0066\nreserv_DELAY=1e-9' >> $SAVEPATH/conf_reserv_${res}.txt               
       elif (($res == 18));then
               echo 'Listing images for reservoir' $res
		printf 'reserv_RUNS=0067-0068\nreserv_DELAY=1e-9+3e-9' >> $SAVEPATH/conf_reserv_${res}.txt              
       elif (($res == 19));then
               echo 'Listing images for reservoir' $res
		printf 'reserv_RUNS=0069-0072\nreserv_DELAY=3e-9' >> $SAVEPATH/conf_reserv_${res}.txt               
       elif (($res == 20));then
               echo 'Listing images for reservoir' $res
		printf 'reserv_RUNS=0073-0074\nreserv_DELAY=3e-9' >> $SAVEPATH/conf_reserv_${res}.txt               
       elif (($res == 21));then
               echo 'Listing images for reservoir' $res
		printf 'reserv_RUNS=0075-0076\nreserv_DELAY=3e-9' >> $SAVEPATH/conf_reserv_${res}.txt               
       elif (($res == 22));then
               echo 'Listing images for reservoir' $res
		printf 'reserv_RUNS=0077-0079\nreserv_DELAY=3e-9' >> $SAVEPATH/conf_reserv_${res}.txt       
       elif (($res == 23));then
               echo 'Listing images for reservoir' $res
		printf 'reserv_RUNS=0080-0084\nreserv_DELAY=3e-9+10e-9' >> $SAVEPATH/conf_reserv_${res}.txt       
       elif (($res == 24));then
               echo 'Listing images for reservoir' $res
		printf 'reserv_RUNS=0085-0087\nreserv_DELAY=3e-9' >> $SAVEPATH/conf_reserv_${res}.txt               
       elif (($res == 25));then
               echo 'Listing images for reservoir' $res
		printf 'reserv_RUNS=0088-0089\nreserv_DELAY=3e-9' >> $SAVEPATH/conf_reserv_${res}.txt	       
       elif (($res == 26));then
               echo 'Listing images for reservoir' $res
		printf 'reserv_RUNS=0090-0093\nreserv_DELAY=3e-9' >> $SAVEPATH/conf_reserv_${res}.txt       
       elif (($res == 27));then
               echo 'Listing images for reservoir' $res
		printf 'reserv_RUNS=0094\nreserv_DELAY=1e-6' >> $SAVEPATH/conf_reserv_${res}.txt               
       elif (($res == 28));then
               echo 'Listing images for reservoir' $res
		printf 'reserv_RUNS=0095-0097\nreserv_DELAY=1e-6' >> $SAVEPATH/conf_reserv_${res}.txt       
       elif (($res == 29));then
               echo 'Listing images for reservoir' $res
		printf 'reserv_RUNS=0098-0100\nreserv_DELAY=30e-11+1e-6' >> $SAVEPATH/conf_reserv_${res}.txt       
       elif (($res == 30));then
               echo 'Listing images for reservoir' $res
		printf 'reserv_RUNS=0101-103\nreserv_DELAY=30e-11' >> $SAVEPATH/conf_reserv_${res}.txt
       elif (($res == 31));then
               echo 'Listing images for reservoir' $res
                printf 'reserv_RUNS=0104-109\nreserv_DELAY=30e-11+3e-12' >> $SAVEPATH/conf_reserv_${res}.txt       
       fi
done
