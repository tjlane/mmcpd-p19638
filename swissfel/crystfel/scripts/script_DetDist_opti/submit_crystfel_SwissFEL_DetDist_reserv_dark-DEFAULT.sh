#!/bin/bash


### CONFIGURATION ###

PGROUP=/sf/alvra/data/p19638/work/DetDist_opti/reserv_DEFAULT_RES/dark_DetDist #Please modify the path #
SAMPLEFOLDER=/sf/alvra/data/p19638/ # this is the folder in which the data are stored
SAVEFOLDER=/sf/alvra/data/p19638/work/DetDist_opti/reserv_DEFAULT_RES/dark_DetDist
EXPERIMENT=19638  #(sed 's/_/-/g' <<< "$SAMPLEFOLDER")
CELL=/sf/alvra/data/p19638/work/files-process/pl_mmCPD_euXFEL_vAlex.cell # best specify absolute path #
GEOMETRY=/sf/alvra/data/p19638/work/DetDist_opti/reserv_DEFAULT_RES/dark_DetDist/VA_edited_according_EB_run184_dark_acq0001.geom # best specify absolute path, remember to use a recent mask file inside the geometry file #


### DATA PARAMETERS ###
# specify in command line #
# if you don't care which injector you can use any integer with 3 digits you want, it just ends up in the name of the stream #
source $SAVEFOLDER/conf_reserv_DEFAULT_RES.txt
echo $reserv_RUNS
echo $reserv_DELAY



RESERV=DEFAULT_RES # $2 # 
RUN=$reserv_RUNS # $3 has to have 4 digits e.g. 0001 or 0123 or 1467 #
TYPE=DEFAULT_TYPE # $4 has to be dark or light
DELAY=$reserv_DELAY # $5 # data collection FOLDERS have to be named in that way e.g. 10e-12 for 10 ps, 1e-6 for 1us #

### Detector Distance OPTIMIZATION ### 
# use the same distance for DETDISTMINUS and DETDISTPLUS if you don't want to optimize #
# distance is in um # 

DETDISTMINUS=9070 #
DETDISTSTEP=50
DETDISTPLUS=9470  #

### rarely altered indexing parameters ###

INDEXING=xgandalf
INTRADIUS=2,3,6
MINPIXCOUNT=2
MINPEAKS=8
SNR=5.0
THRESHOLD=300


echo $PGROUP, $SAMPLEFOLDER, $CELL, $GEOMETRY 
for DIST in `seq $DETDISTMINUS $DETDISTSTEP $DETDISTPLUS`
	 do 
		echo `seq $DETDISTMINUS $DETDISTSTEP $DETDISTPLUS`
		echo $DIST
		sed 's/clen.*/clen = 0.0'$DIST'/' ${GEOMETRY} > ${GEOMETRY}-${DIST}.geom 
		sbatch -p week -t 4-00:00:00 <<EOF
#!/bin/bash
module clear
source /etc/scripts/mx_fel.sh
module unload hdf5_serial/1.8.20
module load hdf5_serial/1.8.17

NPROC=$(grep proc /proc/cpuinfo | wc -l )
echo '${PGROUP}/${DELAY}/data/${TYPE}/run00${RUN}.JF06T08V02.h5.lst =' ${PGROUP}/${DELAY}/data/${TYPE}/run00${RUN}.JF06T08V02.h5.lst


indexamajig -j \$NPROC -i ${PGROUP}/dark_reserv_new_${RESERV}.lst -g ${GEOMETRY}-${DIST}.geom -o ${SAVEFOLDER}/exp_${EXPERIMENT}_run_${RUN}_type_${TYPE}_delay_${DELAY}_dist_${DIST}_reserv_${RESERV}_DetDist.stream --indexing=$INDEXING --peaks=peakfinder8 --threshold=$THRESHOLD -p $CELL --int-radius=$INTRADIUS --min-snr=$SNR --min-peaks=$MINPEAKS --min-pix-count=$MINPIXCOUNT > ${SAVEFOLDER}/run_${RUN}_type_${TYPE}_delay_${DELAY}_dist_${DIST}_reserv_${RESERV}DetDist.log 2>&1
EOF
done


