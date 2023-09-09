#!/bin/sh

INPUT=$1

PARTFILES_PATH=/sf/alvra/data/p19638/work/tuning_param/indexing_$INPUT/part/files
SAVEPATH=/sf/alvra/data/p19638/work/tuning_param/indexing_$INPUT/part/unity
echo $PARTFILES_PATH
echo $SAVEPATH

STREAMINPUT=${INPUT}_l+d.stream
HKLOUTPUT=${INPUT}_l+d.hkl

echo $HKLOUTPUT
echo $STREAMINPUT

sbatch --exclusive -p week -t 4-00:00:00 <<EOF
#!/bin/sh

module clear
source /etc/scripts/mx_fel.sh
module unload hdf5_serial/1.8.20
module load hdf5_serial/1.8.17

NPROC=$(grep proc /proc/cpuinfo | wc -l )

echo $HKLOUTPUT
echo $STREAMINPUT

partialator --iterations=1 --custom-split=${PARTFILES_PATH}/csplit1.dat --model=unity --push-res=1.5 -i ${PARTFILES_PATH}/$STREAMINPUT -o ${SAVEPATH}/$HKLOUTPUT -y mmm -j \$NPROC

EOF

