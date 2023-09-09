# Swissfel_Scripts - SFX analysis scripts for photolyase experiment at PSI, Swissfel

Description:
This repository contains the scripts that were used to analyze and process data from a serial femtosecond 
crystallography (SFX) experiment on photolyase at the Paul Scherrer Institute (PSI) using the SwissFEL facility. 
The code name for the experiment was "p19638".

The scripts included in this repository were used to perform various tasks, such as detector distance optimisation, 
data preprocessing, data visualization, and statistical analysis. They were written in Bash and Python.

Please note that these scripts are provided as-is and may require modification to suit your specific needs.

If you have any questions or comments, please feel free to contact the author at apostolop.virginia@gmail.com.


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
