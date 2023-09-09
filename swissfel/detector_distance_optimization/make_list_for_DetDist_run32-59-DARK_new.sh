#!/bin/bash

 #Script that makes lst of images for DARK data set to use as input for the detector distance optimasation. 
 #the savepath-s have been grouped by the number of the reservoir (i.e. injector). E.g. reserv_4 corresponds to 
 #runs 19 to 20, resev_47 corresponds to runs 153 to 155 etc. A full list of the reservoirs that change during the 
 #experiment and the corresponding runs, can be found: 
 #https://github.com/virginia4/Swissfel_beamtime_pn-19638/pl_reserv_grouped.csv


DATAPATH=/sf/alvra/data/p19638/work/online
RUNPATH=/sf/alvra/data/p19638/work/DetDist_opti
for res in {32..59};do
SAVEPATH=/sf/alvra/data/p19638/work/DetDist_opti/reserv_${res}/dark_DetDist


cd $DATAPATH
echo $DATAPATH 

        if (($res == 32));then
                echo 'Listing images for reservoir' $res
                for irun in {110..113}; do
                        cd run0$irun/index/dark
                        count_acq=$(ls *.stream | wc -l)
                        acq_no=$(expr $count_acq / 2)
                        if (($acq_no == 0));then
                                acq_no=1
                        fi
                        echo $count_acq, $acq_no
                        echo *${acq_no}.stream         
                        echo run0$irun/index/dark
#                        $RUNPATH/indexed-filenames *${acq_no}.stream 
                        $RUNPATH/indexed-filenames *${acq_no}.stream >> $SAVEPATH/dark_reserv_new_${res}.lst;
                        cd $DATAPATH
                done       
        elif (($res == 33));then 
                echo 'Listing images for reservoir' $res
                for irun in {114..115}; do
                        cd run0$irun/index/dark
                        count_acq=$(ls *.stream | wc -l)
                        acq_no=$(expr $count_acq / 2)
                        if (($acq_no == 0));then
                                acq_no=1
                        fi
                        echo $count_acq, $acq_no
                        echo *${acq_no}.stream         
                        echo run0$irun/index/dark
#                        $RUNPATH/indexed-filenames *${acq_no}.stream 
                        $RUNPATH/indexed-filenames *${acq_no}.stream >> $SAVEPATH/dark_reserv_new_${res}.lst;
                        cd $DATAPATH
	        done
      elif (($res == 34));then
               echo 'Listing images for reservoir' $res
               for irun in {116..117}; do
                        cd run0$irun/index/dark
                        count_acq=$(ls *.stream | wc -l)
                        acq_no=$(expr $count_acq / 2)
                        if (($acq_no == 0));then
                                acq_no=1
                        fi
                        echo $count_acq, $acq_no
                        echo *${acq_no}.stream         
                        echo run0$irun/index/dark
#                        $RUNPATH/indexed-filenames *${acq_no}.stream 
                        $RUNPATH/indexed-filenames *${acq_no}.stream >> $SAVEPATH/dark_reserv_new_${res}.lst;
                        cd $DATAPATH
	       done
## NOTE: no entry in Logbook for reservoir 35
       elif (($res == 36));then
               echo 'Listing images for reservoir' $res
               for irun in {118..121}; do
                        cd run0$irun/index/dark
                        count_acq=$(ls *.stream | wc -l)
                        acq_no=$(expr $count_acq / 2)
                        if (($acq_no == 0));then
                                acq_no=1
                        fi
                        echo $count_acq, $acq_no
                        echo *${acq_no}.stream         
                        echo run0$irun/index/dark
#                        $RUNPATH/indexed-filenames *${acq_no}.stream 
                        $RUNPATH/indexed-filenames *${acq_no}.stream >> $SAVEPATH/dark_reserv_new_${res}.lst;
                        cd $DATAPATH
               done
      elif (($res == 37));then
               echo 'Listing images for reservoir' $res
               for irun in {122..128}; do
                        cd run0$irun/index/dark
                        count_acq=$(ls *.stream | wc -l)
                        acq_no=$(expr $count_acq / 2)
                        if (($acq_no == 0));then
                                acq_no=1
                        fi
                        echo $count_acq, $acq_no
                        echo *${acq_no}.stream         
                        echo run0$irun/index/dark
#                        $RUNPATH/indexed-filenames *${acq_no}.stream 
                        $RUNPATH/indexed-filenames *${acq_no}.stream >> $SAVEPATH/dark_reserv_new_${res}.lst;
                        cd $DATAPATH       
               done
       elif (($res == 38));then
               echo 'Listing images for reservoir' $res
               for irun in {129..133}; do
                        cd run0$irun/index/dark
                        count_acq=$(ls *.stream | wc -l)
                        acq_no=$(expr $count_acq / 2)
                        if (($acq_no == 0));then
                                acq_no=1
                        fi
                        echo $count_acq, $acq_no
                        echo *${acq_no}.stream         
                        echo run0$irun/index/dark
#                        $RUNPATH/indexed-filenames *${acq_no}.stream 
                        $RUNPATH/indexed-filenames *${acq_no}.stream >> $SAVEPATH/dark_reserv_new_${res}.lst;
                        cd $DATAPATH
	       done
       elif (($res == 39));then
               echo 'Listing images for reservoir' $res
	       irun=135
               cd run0$irun/index/dark
               count_acq=$(ls *.stream | wc -l)
               acq_no=$(expr $count_acq / 2)
               if (($acq_no == 0));then
                        acq_no=1
               fi
               echo $count_acq, $acq_no
               echo *${acq_no}.stream         
               echo run0$irun/index/dark
#               $RUNPATH/indexed-filenames *${acq_no}.stream 
               $RUNPATH/indexed-filenames *${acq_no}.stream >> $SAVEPATH/dark_reserv_new_${res}.lst;
               cd $DATAPATH
       elif (($res == 40));then
               echo 'Listing images for reservoir' $res
               irun=136
               cd run0$irun/index/dark
               count_acq=$(ls *.stream | wc -l)
               acq_no=$(expr $count_acq / 2)
               if (($acq_no == 0));then
                        acq_no=1
               fi
               echo $count_acq, $acq_no
               echo *${acq_no}.stream         
               echo run0$irun/index/dark
#               $RUNPATH/indexed-filenames *${acq_no}.stream 
               $RUNPATH/indexed-filenames *${acq_no}.stream >> $SAVEPATH/dark_reserv_new_${res}.lst;
               cd $DATAPATH          
       elif (($res == 41));then
               echo 'Listing images for reservoir' $res
               irun=137
               cd run0$irun/index/dark
               count_acq=$(ls *.stream | wc -l)
               acq_no=$(expr $count_acq / 2)
               if (($acq_no == 0));then
                        acq_no=1
               fi
               echo $count_acq, $acq_no
               echo *${acq_no}.stream         
               echo run0$irun/index/dark
#               $RUNPATH/indexed-filenames *${acq_no}.stream 
               $RUNPATH/indexed-filenames *${acq_no}.stream >> $SAVEPATH/dark_reserv_new_${res}.lst;
               cd $DATAPATH 
       elif (($res == 42));then
               echo 'Listing images for reservoir' $res
               for irun in {138..141}; do
                       cd run0$irun/index/dark
               	       count_acq=$(ls *.stream | wc -l)
               	       acq_no=$(expr $count_acq / 2)
                       if (($acq_no == 0));then
                              acq_no=1
                       fi
                       echo $count_acq, $acq_no
                       echo *${acq_no}.stream         
                       echo run0$irun/index/dark
#               $RUNPATH/indexed-filenames *${acq_no}.stream 
                       $RUNPATH/indexed-filenames *${acq_no}.stream >> $SAVEPATH/dark_reserv_new_${res}.lst;
                       cd $DATAPATH
               done
       elif (($res == 43));then
               echo 'Listing images for reservoir' $res
               for irun in {143..145}; do
                       cd run0$irun/index/dark
                       count_acq=$(ls *.stream | wc -l)
                       acq_no=$(expr $count_acq / 2)
                       if (($acq_no == 0));then
                              acq_no=1
                       fi
                       echo $count_acq, $acq_no
                       echo *${acq_no}.stream         
                       echo run0$irun/index/dark
#               $RUNPATH/indexed-filenames *${acq_no}.stream 
                       $RUNPATH/indexed-filenames *${acq_no}.stream >> $SAVEPATH/dark_reserv_new_${res}.lst;
                       cd $DATAPATH
               done
       elif (($res == 44));then
               echo 'Listing images for reservoir' $res
               for irun in {146..148}; do
                       cd run0$irun/index/dark
                       count_acq=$(ls *.stream | wc -l)
                       acq_no=$(expr $count_acq / 2)
                       if (($acq_no == 0));then
                              acq_no=1
                       fi
                       echo $count_acq, $acq_no
                       echo *${acq_no}.stream         
                       echo run0$irun/index/dark
#               $RUNPATH/indexed-filenames *${acq_no}.stream 
                       $RUNPATH/indexed-filenames *${acq_no}.stream >> $SAVEPATH/dark_reserv_new_${res}.lst;
                       cd $DATAPATH
               done
       elif (($res == 45));then
               echo 'Listing images for reservoir' $res
               irun=149
               cd run0$irun/index/dark
               count_acq=$(ls *.stream | wc -l)
               acq_no=$(expr $count_acq / 2)
               if (($acq_no == 0));then
                        acq_no=1
               fi
               echo $count_acq, $acq_no
               echo *${acq_no}.stream         
               echo run0$irun/index/dark
#               $RUNPATH/indexed-filenames *${acq_no}.stream 
               $RUNPATH/indexed-filenames *${acq_no}.stream >> $SAVEPATH/dark_reserv_new_${res}.lst;
               cd $DATAPATH
              
       elif (($res == 46));then
               echo 'Listing images for reservoir' $res
               for irun in {150..152}; do
                       cd run0$irun/index/dark
                       count_acq=$(ls *.stream | wc -l)
                       acq_no=$(expr $count_acq / 2)
                       if (($acq_no == 0));then
                              acq_no=1
                       fi
                       echo $count_acq, $acq_no
                       echo *${acq_no}.stream         
                       echo run0$irun/index/dark
#               $RUNPATH/indexed-filenames *${acq_no}.stream 
                       $RUNPATH/indexed-filenames *${acq_no}.stream >> $SAVEPATH/dark_reserv_new_${res}.lst;
                       cd $DATAPATH
               done
       elif (($res == 47));then
               echo 'Listing images for reservoir' $res
               for irun in {153..155}; do
                       cd run0$irun/index/dark
                       count_acq=$(ls *.stream | wc -l)
                       acq_no=$(expr $count_acq / 2)
                       if (($acq_no == 0));then
                              acq_no=1
                       fi
                       echo $count_acq, $acq_no
                       echo *${acq_no}.stream         
                       echo run0$irun/index/dark
#               $RUNPATH/indexed-filenames *${acq_no}.stream 
                       $RUNPATH/indexed-filenames *${acq_no}.stream >> $SAVEPATH/dark_reserv_new_${res}.lst;
                       cd $DATAPATH
               done
       elif (($res == 48));then
               echo 'Listing images for reservoir' $res
	       echo "NOTE::::: run0156 doesn't exists"
               for irun in {157..158}; do
                       cd run0$irun/index/dark
                       count_acq=$(ls *.stream | wc -l)
                       acq_no=$(expr $count_acq / 2)
                       if (($acq_no == 0));then
                              acq_no=1
                       fi
                       echo $count_acq, $acq_no
                       echo *${acq_no}.stream         
                       echo run0$irun/index/dark
#               $RUNPATH/indexed-filenames *${acq_no}.stream 
                       $RUNPATH/indexed-filenames *${acq_no}.stream >> $SAVEPATH/dark_reserv_new_${res}.lst;
                       cd $DATAPATH
	       done
       elif (($res == 49));then
               echo 'Listing images for reservoir' $res
               irun=159
               cd run0$irun/index/dark
               count_acq=$(ls *.stream | wc -l)
               acq_no=$(expr $count_acq / 2)
               if (($acq_no == 0));then
                        acq_no=1
               fi
               echo $count_acq, $acq_no
               echo *${acq_no}.stream         
               echo run0$irun/index/dark
#               $RUNPATH/indexed-filenames *${acq_no}.stream 
               $RUNPATH/indexed-filenames *${acq_no}.stream >> $SAVEPATH/dark_reserv_new_${res}.lst;
               cd $DATAPATH 
       elif (($res == 50));then
               echo 'Listing images for reservoir' $res
               for irun in {160..162}; do
                       cd run0$irun/index/dark
                       count_acq=$(ls *.stream | wc -l)
                       acq_no=$(expr $count_acq / 2)
                       if (($acq_no == 0));then
                              acq_no=1
                       fi
                       echo $count_acq, $acq_no
                       echo *${acq_no}.stream         
                       echo run0$irun/index/dark
#               $RUNPATH/indexed-filenames *${acq_no}.stream 
                       $RUNPATH/indexed-filenames *${acq_no}.stream >> $SAVEPATH/dark_reserv_new_${res}.lst;
                       cd $DATAPATH
               done
       elif (($res == 51));then
               echo 'Listing images for reservoir' $res
               for irun in {163..166}; do
                       cd run0$irun/index/dark
                       count_acq=$(ls *.stream | wc -l)
                       acq_no=$(expr $count_acq / 2)
                       if (($acq_no == 0));then
                              acq_no=1
                       fi
                       echo $count_acq, $acq_no
                       echo *${acq_no}.stream         
                       echo run0$irun/index/dark
#               $RUNPATH/indexed-filenames *${acq_no}.stream 
                       $RUNPATH/indexed-filenames *${acq_no}.stream >> $SAVEPATH/dark_reserv_new_${res}.lst;
                       cd $DATAPATH
               done
       elif (($res == 52));then
               echo 'Listing images for reservoir' $res
               for irun in {167..169}; do
                       cd run0$irun/index/dark
                       count_acq=$(ls *.stream | wc -l)
                       acq_no=$(expr $count_acq / 2)
                       if (($acq_no == 0));then
                              acq_no=1
                       fi
                       echo $count_acq, $acq_no
                       echo *${acq_no}.stream         
                       echo run0$irun/index/dark
#               $RUNPATH/indexed-filenames *${acq_no}.stream 
                       $RUNPATH/indexed-filenames *${acq_no}.stream >> $SAVEPATH/dark_reserv_new_${res}.lst;
                       cd $DATAPATH
               done
       elif (($res == 53));then
               echo 'Listing images for reservoir' $res
	       echo "NOTE::::: run0172 doesn't exists"
               for irun in 170 171 173; do
                       cd run0$irun/index/dark
                       count_acq=$(ls *.stream | wc -l)
                       acq_no=$(expr $count_acq / 2)
                       if (($acq_no == 0));then
                              acq_no=1
                       fi
                       echo $count_acq, $acq_no
                       echo *${acq_no}.stream         
                       echo run0$irun/index/dark
#               $RUNPATH/indexed-filenames *${acq_no}.stream 
                       $RUNPATH/indexed-filenames *${acq_no}.stream >> $SAVEPATH/dark_reserv_new_${res}.lst;
                       cd $DATAPATH
               done
       elif (($res == 54));then
               echo 'Listing images for reservoir' $res
               echo "NOTE::::: run0174 doesn't exists"
	       for irun in 175; do
                       cd run0$irun/index/dark
                       count_acq=$(ls *.stream | wc -l)
                       acq_no=$(expr $count_acq / 2)
                       if (($acq_no == 0));then
                              acq_no=1
                       fi
                       echo $count_acq, $acq_no
                       echo *${acq_no}.stream         
                       echo run0$irun/index/dark
#               $RUNPATH/indexed-filenames *${acq_no}.stream 
                       $RUNPATH/indexed-filenames *${acq_no}.stream >> $SAVEPATH/dark_reserv_new_${res}.lst;
               done
       elif (($res == 55));then
               echo 'Listing images for reservoir' $res
               for irun in {176..178}; do
                       cd run0$irun/index/dark
                       count_acq=$(ls *.stream | wc -l)
                       acq_no=$(expr $count_acq / 2)
                       if (($acq_no == 0));then
                              acq_no=1
                       fi
                       echo $count_acq, $acq_no
                       echo *${acq_no}.stream         
                       echo run0$irun/index/dark
#               $RUNPATH/indexed-filenames *${acq_no}.stream 
                       $RUNPATH/indexed-filenames *${acq_no}.stream >> $SAVEPATH/dark_reserv_new_${res}.lst;
                       cd $DATAPATH
               done
       elif (($res == 56));then
               echo 'Listing images for reservoir' $res
               irun=179
               cd run0$irun/index/dark
               count_acq=$(ls *.stream | wc -l)
               acq_no=$(expr $count_acq / 2)
               if (($acq_no == 0));then
                        acq_no=1
               fi
               echo $count_acq, $acq_no
               echo *${acq_no}.stream         
               echo run0$irun/index/dark
#               $RUNPATH/indexed-filenames *${acq_no}.stream 
               $RUNPATH/indexed-filenames *${acq_no}.stream >> $SAVEPATH/dark_reserv_new_${res}.lst;
               cd $DATAPATH
               
       elif (($res == 57));then
               echo 'Listing images for reservoir' $res
               irun=181
               cd run0$irun/index/dark
               count_acq=$(ls *.stream | wc -l)
               acq_no=$(expr $count_acq / 2)
               if (($acq_no == 0));then
                        acq_no=1
               fi 
               echo $count_acq, $acq_no
               echo *${acq_no}.stream         
               echo run0$irun/index/dark
#               $RUNPATH/indexed-filenames *${acq_no}.stream 
               $RUNPATH/indexed-filenames *${acq_no}.stream >> $SAVEPATH/dark_reserv_new_${res}.lst;
               cd $DATAPATH
       elif (($res == 58));then
               echo 'Listing images for reservoir' $res
               for irun in {182..183}; do
                       cd run0$irun/index/dark
                       count_acq=$(ls *.stream | wc -l)
                       acq_no=$(expr $count_acq / 2)
                       if (($acq_no == 0));then
                              acq_no=1
                       fi
                       echo $count_acq, $acq_no
                       echo *${acq_no}.stream         
                       echo run0$irun/index/dark
#               $RUNPATH/indexed-filenames *${acq_no}.stream 
                       $RUNPATH/indexed-filenames *${acq_no}.stream >> $SAVEPATH/dark_reserv_new_${res}.lst;
                       cd $DATAPATH
               done
       elif (($res == 59));then
               echo 'Listing images for reservoir' $res
               for irun in {184..185}; do
                       cd run0$irun/index/dark
                       count_acq=$(ls *.stream | wc -l)
                       acq_no=$(expr $count_acq / 2)
                       if (($acq_no == 0));then
                              acq_no=1
                       fi
                       echo $count_acq, $acq_no
                       echo *${acq_no}.stream         
                       echo run0$irun/index/dark
#               $RUNPATH/indexed-filenames *${acq_no}.stream 
                       $RUNPATH/indexed-filenames *${acq_no}.stream >> $SAVEPATH/dark_reserv_new_${res}.lst;
                       cd $DATAPATH
               done
       fi
done
