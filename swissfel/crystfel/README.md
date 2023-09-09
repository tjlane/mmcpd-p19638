
# Data Analysis for SwissFEL Beamtime 19638
## DNA Photolyase mmCPD II

### link to cif2pdb
https://gist.github.com/ninachristou/533cd03da753f195dbed2116f80ecddf

### Navigate through PSI offlien cluster (Ra):

#### Load modules: 
module clear<br/>
source /etc/scripts/mx_fel.sh --> *this will load all the scipts that are included at crystfel9.0* <br/>
module unload hdf5_serial/1.8.20<br/>
module load hdf5_serial/1.8.17

#### Directory structure:
* check DIR.txt
* Important files are *{dark/light}.lst* - need for re-running indexing. 
