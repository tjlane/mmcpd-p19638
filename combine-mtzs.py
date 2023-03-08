"""
combines 3 MTZs for submission:

  1. merged data from crystFEL
  2. star-aniso treated data
  3. extrapolated SFs

We also try to ingest and write the merging statistics
from crystFEL
  
Output: MTZ and mmCIF 
"""


import reciprocalspaceship as rs
import gemmi


def combine_mtzs(merged_mtz, staraniso_mtz, extr_mtz):
    raise NotImplementedError()


def add_mergestats_to_cif(merge_stat_dir, cif_path):
    raise NotImplementedError()


