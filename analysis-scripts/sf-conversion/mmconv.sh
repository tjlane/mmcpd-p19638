#!/bin/bash

INPUT_MTZ=$1
BASENAME=`echo ${INPUT_MTZ} | cut -f 1 -d '.'`

gemmi mtz2cif --no-history --no-comments --spec=/Users/tjlane/opt/mmcpd-scripts/sf-conversion/block1.spec --wavelength=1.035 --block=extrapolated_SFs ${INPUT_MTZ} block1.mmcif
gemmi mtz2cif --no-history --no-comments --spec=/Users/tjlane/opt/mmcpd-scripts/sf-conversion/block2.spec --wavelength=1.035 --block=measured_SFs ${INPUT_MTZ} block2.mmcif

cat block1.mmcif block2.mmcif >> ${BASENAME}_sf.mmcif
rm block1.mmcif block2.mmcif 

echo "wrote: ${BASENAME}_sf.mmcif"
