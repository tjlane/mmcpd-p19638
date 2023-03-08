#!/bin/bash

phenix.refine \
${fixed_pdb_path} \
${mtz_path} \
${ttd_cif_path} \
${fda_cif_path} \
xray_data.r_free_flags.file_name=${rfree_mtz_path} \
main.number_of_macro_cycles=6 \
refinement.refine.strategy=tls+individual_sites+individual_adp \
refinement.refine.adp.tls="chain 'A' and chain 'C' and chain 'D'" \
refinement.refine.adp.tls="chain 'B' and chain 'F' and chain 'E'" \
hydrogens.refine=riding
