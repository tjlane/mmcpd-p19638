#!/bin/bash 

#Script that makes lst of images for DARK data set to use as input for the detector distance optimasation.
#the savepath-s have been grouped by the number of the reservoir (i.e. injector). E.g. reserv_4 corresponds to
#runs 19 to 20, resev_47 corresponds to runs 153 to 155 etc. A full list of the reservoirs that change during the
#experiment and the corresponding runs, can be found: 
#https://github.com/virginia4/Swissfel_beamtime_pn-19638/pl_reserv_grouped.csv


DATAPATH=/sf/alvra/data/p19638/work/online
RUNPATH=/sf/alvra/data/p19638/work/DetDist_opti/
for res in {4..59};do
SAVEPATH=/sf/alvra/data/p19638/work/DetDist_opti/reserv_$res


cd $DATAPATH
echo $DATAPATH 

        if (($res == 4));then
                echo 'Listing images for reservoir' $res
                for irun in {19..20}; do
                        cd run00$irun/index/dark        
                        echo run00$irun/index/dark
                        $RUNPATH/indexed-filenames *stream > $SAVEPATH/dark_reserv_$res.lst;
                        cd $DATAPATH
                done       

        elif (($res == 5));then 
                echo 'Listing images for reservoir' $res
                for irun in {21..22}; do
                        cd run00$irun/index/dark
                        echo run00$irun/index/dark
                        $RUNPATH/indexed-filenames *stream > $SAVEPATH/dark_reserv_$res.lst;
                        cd $DATAPATH
                done
        fi
      elif (($res == 6));then
               echo 'Listing images for reservoir' $res
               for irun in {23..33}; do
                       cd run00$irun/index/dark
                       echo run00$irun/index/dark
                       $RUNPATH/indexed-filenames *stream > $SAVEPATH/dark_reserv_$res.lst;
                       cd $DATAPATH
               done
       elif (($res == 7));then
               echo 'Listing images for reservoir' $res
               for irun in {34..37}; do
                       cd run00$irun/index/dark
                       echo run00$irun/index/dark
                       $RUNPATH/indexed-filenames *stream > $SAVEPATH/dark_reserv_$res.lst;
                       cd $DATAPATH
               done
      elif (($res == 8));then
               echo 'Listing images for reservoir' $res
               for irun in {38..40}; do
                       cd run00$irun/index/dark
                       echo run00$irun/index/dark
                       $RUNPATH/indexed-filenames *stream > $SAVEPATH/dark_reserv_$res.lst;
                       cd $DATAPATH
               done
       elif (($res == 9));then
               echo 'Listing images for reservoir' $res
               for irun in {41..42}; do
                       cd run00$irun/index/dark
                       echo run00$irun/index/dark
                       $RUNPATH/indexed-filenames *stream > $SAVEPATH/dark_reserv_$res.lst;
                       cd $DATAPATH
               done
       elif (($res == 10));then
               echo 'Listing images for reservoir' $res
               for irun in {43..45}; do
                       cd run00$irun/index/dark
                       echo run00$irun/index/dark
                       $RUNPATH/indexed-filenames *stream > $SAVEPATH/dark_reserv_$res.lst;
                       cd $DATAPATH
               done
       elif (($res == 11));then
               echo 'Listing images for reservoir' $res
               for irun in {46..48}; do
                       cd run00$irun/index/dark
                       echo run00$irun/index/dark
                       $RUNPATH/indexed-filenames *stream > $SAVEPATH/dark_reserv_$res.lst;
                       cd $DATAPATH
               done
       elif (($res == 12));then
               echo 'Listing images for reservoir' $res
               for irun in {49..50}; do
                       cd run00$irun/index/dark
                       echo run00$irun/index/dark
                       $RUNPATH/indexed-filenames *stream > $SAVEPATH/dark_reserv_$res.lst;
                       cd $DATAPATH
               done
       elif (($res == 13));then
               echo 'Listing images for reservoir' $res
               for irun in {51..54}; do
                       cd run00$irun/index/dark
                       echo run00$irun/index/dark
                       $RUNPATH/indexed-filenames *stream > $SAVEPATH/dark_reserv_$res.lst;
                       cd $DATAPATH
               done
       elif (($res == 14));then
               echo 'Listing images for reservoir' $res
               for irun in {55..56}; do
                       cd run00$irun/index/dark
                       echo run00$irun/index/dark
                       $RUNPATH/indexed-filenames *stream > $SAVEPATH/dark_reserv_$res.lst;
                       cd $DATAPATH
               done
       elif (($res == 15));then
               echo 'Listing images for reservoir' $res
               for irun in {57..59}; do
                       cd run00$irun/index/dark
                       echo run00$irun/index/dark
                       $RUNPATH/indexed-filenames *stream > $SAVEPATH/dark_reserv_$res.lst;
                       cd $DATAPATH
               done
       elif (($res == 16));then
               echo 'Listing images for reservoir' $res
               for irun in {60..64}; do
                       cd run00$irun/index/dark
                       echo run00$irun/index/dark
                       $RUNPATH/indexed-filenames *stream > $SAVEPATH/dark_reserv_$res.lst;
                       cd $DATAPATH
               done
       elif (($res == 17));then
               echo 'Listing images for reservoir' $res
               for irun in {65..66}; do
                       cd run00$irun/index/dark
                       echo run00$irun/index/dark
                       $RUNPATH/indexed-filenames *stream > $SAVEPATH/dark_reserv_$res.lst;
                       cd $DATAPATH
               done
       elif (($res == 18));then
               echo 'Listing images for reservoir' $res
               for irun in {67..68}; do
                       cd run00$irun/index/dark
                       echo run00$irun/index/dark
                       $RUNPATH/indexed-filenames *stream > $SAVEPATH/dark_reserv_$res.lst;
                       cd $DATAPATH
               done
       elif (($res == 19));then
               echo 'Listing images for reservoir' $res
               for irun in {69..72}; do
                       cd run00$irun/index/dark
                       echo run00$irun/index/dark
                       $RUNPATH/indexed-filenames *stream > $SAVEPATH/dark_reserv_$res.lst;
                       cd $DATAPATH
               done
       elif (($res == 20));then
               echo 'Listing images for reservoir' $res
               for irun in {73..74}; do
                       cd run00$irun/index/dark
                       echo run00$irun/index/dark
                       $RUNPATH/indexed-filenames *stream > $SAVEPATH/dark_reserv_$res.lst;
                       cd $DATAPATH
               done
       elif (($res == 21));then
               echo 'Listing images for reservoir' $res
               for irun in {75..76}; do
                       cd run00$irun/index/dark
                       echo run00$irun/index/dark
                       $RUNPATH/indexed-filenames *stream > $SAVEPATH/dark_reserv_$res.lst;
                       cd $DATAPATH
               done
       elif (($res == 22));then
               echo 'Listing images for reservoir' $res
               for irun in {77..79}; do
                       cd run00$irun/index/dark
                       echo run00$irun/index/dark
                       $RUNPATH/indexed-filenames *stream > $SAVEPATH/dark_reserv_$res.lst;
                       cd $DATAPATH
               done
       elif (($res == 23));then
               echo 'Listing images for reservoir' $res
               for irun in {80..84}; do
                       cd run00$irun/index/dark
                       echo run00$irun/index/dark
                       $RUNPATH/indexed-filenames *stream > $SAVEPATH/dark_reserv_$res.lst;
                       cd $DATAPATH
               done
       elif (($res == 24));then
               echo 'Listing images for reservoir' $res
               for irun in {85..87}; do
                       cd run00$irun/index/dark
                       echo run00$irun/index/dark
                       $RUNPATH/indexed-filenames *stream > $SAVEPATH/dark_reserv_$res.lst;
                       cd $DATAPATH
               done
       elif (($res == 25));then
               echo 'Listing images for reservoir' $res
               for irun in {88..89}; do
                       cd run00$irun/index/dark
                       echo run00$irun/index/dark
                       $RUNPATH/indexed-filenames *stream > $SAVEPATH/dark_reserv_$res.lst;
                       cd $DATAPATH
               done
       elif (($res == 26));then
               echo 'Listing images for reservoir' $res
               for irun in {90..93}; do
                       cd run00$irun/index/dark
                       echo run00$irun/index/dark
                       $RUNPATH/indexed-filenames *stream > $SAVEPATH/dark_reserv_$res.lst;
                       cd $DATAPATH
               done
       elif (($res == 27));then
               echo 'Listing images for reservoir' $res
               for irun in {94..94}; do
                       cd run00$irun/index/dark
                       echo run00$irun/index/dark
                       $RUNPATH/indexed-filenames *stream > $SAVEPATH/dark_reserv_$res.lst;
                       cd $DATAPATH
               done
       elif (($res == 28));then
               echo 'Listing images for reservoir' $res
               for irun in {95..97}; do
                       cd run00$irun/index/dark
                       echo run00$irun/index/dark
                       $RUNPATH/indexed-filenames *stream > $SAVEPATH/dark_reserv_$res.lst;
                       cd $DATAPATH
               done
       elif (($res == 29));then
               echo 'Listing images for reservoir' $res
               for irun in {98..100}; do
                      if [ "$irun" -lt 100 ];then
                              cd run00$irun/index/dark
                              echo run00$irun/index/dark
                              $RUNPATH/indexed-filenames *stream > $SAVEPATH/dark_reserv_$res.lst
                      elif [ "$irun" -ge 100 ];then
                                cd run0$irun/index/dark
                                echo run0$irun/index/dark
                                $RUNPATH/indexed-filenames *stream > $SAVEPATH/dark_reserv_$res.ls

                       cd $DATAPATH
                      fi
               done
       elif (($res == 30));then
               echo 'Listing images for reservoir' $res
               for irun in {101..103}; do
                       cd run0$irun/index/dark
                       echo run00$irun/index/dark
                       $RUNPATH/indexed-filenames *stream > $SAVEPATH/dark_reserv_$res.lst;
                       cd $DATAPATH
               done
       elif (($res == 31));then
               echo 'Listing images for reservoir' $res
               for irun in {104..109}; do
                       cd run0$irun/index/dark
                       echo run00$irun/index/dark
                       $RUNPATH/indexed-filenames *stream > $SAVEPATH/dark_reserv_$res.lst;
                       cd $DATAPATH
               done

#       fi
done