#!/bin/bash

fixed_pdb_path=""
mtz_path=""
ttd_cif_path=""
fda_cif_path=""
rfree_mtz_path=""

phenix.refine \
${fixed_pdb_path} \
${mtz_path} \
${ttd_cif_path} \
${fda_cif_path} \
xray_data.r_free_flags.file_name=${rfree_mtz_path} \
xray_data.labels="KFEXTR,SIGKFEXTR" \
main.number_of_macro_cycles=6 \
refinement.refine.strategy=tls+individual_sites+individual_adp+occupancies \
refinement.refine.adp.tls="chain 'A' or chain 'C' or chain 'D'" \
refinement.refine.adp.tls="chain 'B' or chain 'F' or chain 'E'" \
hydrogens.refine=riding
