#!/bin/sh

## Run for reserv 30 to 59, excluding reserv 35

i##CONFIGURATION ###
SAMPLEFOLDER=/sf/alvra/data/p19638/ # this is the folder in which the data are stored
SAVEFOLDER=/sf/alvra/data/p19638/work/tuning_param/indexing_10ns/light_index_v6/streams
CONFFOLDER=/sf/alvra/data/p19638/work/tuning_param/geom_files
LOGFOLDER=/sf/alvra/data/p19638/work/tuning_param/indexing_10ns/light_index_v6/logs
RAWDATA=/sf/alvra/data/p19638/raw
#CELL=/sf/alvra/data/p19638/work/tuning_param/tests/indexing_reserv_10to19/pl_mmCPD_euXFEL_vAlex.cell # best specify absolute path #
CELL=/sf/alvra/data/p19638/work/tuning_param/indexing_all/pl_mmCPD_euXFEL_vAlex.cell
GEOMETRY_PATH=/sf/alvra/data/p19638/work/tuning_param/geom_files

## peakfinder parameters ##
THRESHOLD=1200
SNR=8.0
MINPIXCOUNT=1
MAXPIXCOUNT=50
LOCALBGRADIUS=5
MINRES=50
MAXRES=700
INTRADIUS=2,3,6

## indexing parameters ###
INDEXING=xgandalf
MINPEAKS=10
PUSHRES=1

for ireserv in {41..45}
do
        echo ${GEOMETRY_PATH}/pl_swissfel_reserv_${ireserv}.geom
        source $CONFFOLDER/conf_reserv_$ireserv.txt
        echo $reserv_RUNS
        echo $reserv_DELAY

        var=$reserv_RUNS
        lower_run="${var:1:3}"
        upper_run=${var: -3}
        istart=$lower_run
        ifinish=$upper_run
        for irun in $(seq $lower_run $ifinish)
        do
                if [ $irun == 139 ] || [ $irun == 143 ] || [ $irun == 144 ] || [ $irun == 145 ]; then
			echo $irun
                        for iacq in $RAWDATA/run0$irun/data/acq*.light.lst;do                                                                           
                                echo "this is acq" $iacq
                                cat $iacq >> $SAVEFOLDER/run_${irun}_acq.lst

                        done

#### iset batch and start indexing ####
sbatch --exclusive -p week -t 4-00:00:00 <<EOF
#!/bin/sh
module clear
source /etc/scripts/mx_fel.sh
module unload hdf5_serial/1.8.20
module load hdf5_serial/1.8.17

NPROC=$(grep proc /proc/cpuinfo | wc -l )       
indexamajig -j \$NPROC -i $SAVEFOLDER/run_${irun}_acq.lst  -g ${GEOMETRY_PATH}/pl_swissfel_reserv_${ireserv}.geom -o ${SAVEFOLDER}/indexing_light_run_${irun}_reserv_${ireserv}_laser_${reserv_DELAY}.stream --peaks=peakfinder8 --int-radius=$INTRADIUS --threshold=$THRESHOLD --min-snr=$SNR --min-pix-count=$MINPIXCOUNT --max-pix-count=$MAXPIXCOUNT --local-bg-radius=$LOCALBGRADIUS --min-res=$MINRES --max-res=$MAXRES --indexing=$INDEXING -p $CELL --multi --no-check-peaks --min-peaks=$MINPEAKS --push-res=$PUSHRES > ${LOGFOLDER}/indexing_light_run_${irun}_reserv_${ireserv}_laser_${reserv_DELAY}.log 2>&1 
EOF
                fi
        done
done

