#!/bin/sh

### make sure to have DATVIEW installed somewhere: 
### git clone https://github.com/nstander/DatView
### don't forget to update the path

module clear
module load psi-python38/2020.11

for file in *.stream
  do 
/sf/alvra/data/p19638/work/scripts-process/DatView/datgen.py $file > ${file}.tsv
  done

cat *.tsv > injectors.tsv
awk '/ifile/&&c++>0 {next} 1' injectors.tsv > injectors_clean.tsv


./DetDist_pl.py
