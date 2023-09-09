#!/usr/bin/env python
# -*- coding: utf-8 -*-


# Modified version of detector-shift script written form Thomas White.
#
# USED FOR DARK DATA: reserv_*/dark_DetDist/
#
# ** saves xmean and ymean 
# ** updates the clen (z-axis) according to the optimal DetDist (clen.txt)
# ** updates x,y,z-shifts in a new geomtery file 
# ** NOTE: each reserv_* directory has its own det_shift_cell_stat.py, cause there is a unique name of stream file on each directory!
# ** NEED stream files in the form !!!exp_19638_run_r0038-0040_type_d+l_delay_10e-9_dist_%d_reserv_7_.stream!!! to proceed
# 
# INPUT: 
# * .geom: geometry file that was used int the DetDist optimisattion step
# * clen.txt: optimun detector distance that was calculated based on modelled minimum stdev of c length (after running DetDist.sh)
# OUTPUT: 
# * -predrefine.geom: a new geom file, that x-shift and y-shift have been applies + re-centered with clen 
# * mean_shift_geom.txt: saved the x- and y-shifts 
# * cell_param_mean_stdev.txt: saved cell parameter statistics (mean, stdev, skewness, kurotsis)

# Modified version of detector-shift script written form Thomas White.
# ** saves xmean and ymean 
# ** updates the clen (z-axis) according to the optimal DetDist (clen.txt)
# ** updates x,y,z-shifts in a new geomtery file 


# Determine mean detector shift based on prediction refinement results
#
# Copyright © 2015-2020 Deutsches Elektronen-Synchrotron DESY,
#                       a research centre of the Helmholtz Association.
#
# Author:
#    2015-2018 Thomas White <taw@physics.org>
#    2016      Mamoru Suzuki <mamoru.suzuki@protein.osaka-u.ac.jp>
#    2018      Chun Hong Yoon
#
import sys
import os
import re
import glob
import numpy as np
import matplotlib as plt
import pandas as pd
import seaborn as sns
from scipy.stats import skew
from scipy.stats import kurtosis

def cell_param_stat(stream_file):
    f = open(stream_file, 'r')
    print("Cell paraemeters from stream file: ", stream_file)
    cell_param_list = []
    for l in f:
        g = re.match('Cell parameters (\d+\.\d+) (\d+\.\d+) (\d+\.\d+) nm, (\d+\.\d+) (\d+\.\d+) (\d+\.\d+) deg',l.strip())
        if g:
                cell_param_line = [ float(x) for x in g.groups()]
                cell_param_list.append(cell_param_line)

    df_cell_param = pd.DataFrame(cell_param_list, columns = ['a', 'b', 'c', 'alpha', 'beta', 'gamma'])
    print("Mean of cell parameters")
    print("a = %.2f " % df_cell_param.a.mean())
    print("b = %.2f " % df_cell_param.b.mean())
    print("c = %.2f " % df_cell_param.c.mean(),"nm")
    print("alpha = %.2f " % df_cell_param.alpha.mean())
    print("beta = %.2f " % df_cell_param.beta.mean())
    print("gamma = %.2f " % df_cell_param.gamma.mean(), "deg")

    print("Skewness of a ", skew(df_cell_param.a, axis=0, bias=True))
    print("Kurtosis of a ", kurtosis(df_cell_param.a, axis=0, bias=True))

    print("STDVE of cell parameters")
    print("a = %.2f " % df_cell_param.a.std())
    print("b = %.2f " % df_cell_param.b.std())
    print("c = %.2f " % df_cell_param.c.std())
    print("alpha = %.2f " % df_cell_param.alpha.std())
    print("beta = %.2f " % df_cell_param.beta.std())
    print("gamma = %.2f " % df_cell_param.gamma.std())

    print("script: __file__ is", repr(__file__))
    print("script: cwd is", repr(os.getcwd()))

    df_statistics = pd.DataFrame(index=['mean', 'std', 'skewness', 'kurtosis'],  columns = ['a', 'b', 'c', 'alpha', 'beta', 'gamma'])
    df_statistics.loc['mean'] = pd.Series({'a':df_cell_param.a.mean(), 'b':df_cell_param.b.mean(), 'c':df_cell_param.c.mean(),
    'alpha':df_cell_param.alpha.mean(), 'beta':df_cell_param.beta.mean(),'gamma':df_cell_param.gamma.mean()})

    df_statistics.loc['std'] = pd.Series({'a':df_cell_param.a.std(), 'b':df_cell_param.b.std(), 'c':df_cell_param.c.std(),
    'alpha':df_cell_param.alpha.std(), 'beta':df_cell_param.beta.std(),'gamma':df_cell_param.gamma.std()})

    df_statistics.loc['skewness'] = pd.Series({'a':skew(df_cell_param.a, axis=0, bias=True), 'b':skew(df_cell_param.b, axis=0, bias=True), 'c':skew(df_cell_param.c, axis=0, bias=True),
    'alpha':skew(df_cell_param.alpha, axis=0, bias=True), 'beta':skew(df_cell_param.beta, axis=0, bias=True),'gamma':skew(df_cell_param.gamma, axis=0, bias=True)})

    df_statistics.loc['kurtosis'] = pd.Series({'a':kurtosis(df_cell_param.a, axis=0, bias=True), 'b':kurtosis(df_cell_param.b, axis=0, bias=True), 'c':kurtosis(df_cell_param.c, axis=0, bias=True),
    'alpha':kurtosis(df_cell_param.alpha, axis=0, bias=True), 'beta':kurtosis(df_cell_param.beta, axis=0, bias=True),'gamma':kurtosis(df_cell_param.gamma, axis=0, bias=True)})

    print(df_statistics)

    save_path = os.path.dirname(os.path.abspath(__file__))
    name_file = "cell_param_mean_stdev.txt"
    output_file = os.path.join(save_path, name_file)

    print(output_file)
    df_statistics.to_csv(output_file, sep='\t', float_format='%.3f')

    f.close()
    return()


if len(sys.argv) > 2:
    geom = sys.argv[1]
    clen_file = sys.argv[2]
    have_geom = 1
    have_clen = 1
else:
    have_geom = 0
    have_clen = 0

# choose stream file 
if have_clen:
    file_clen = 'clen.txt'
    with open(file_clen, "r") as file:
        readlines=file.read().split('\n')

    clen_all = readlines[0]
    clen_all_split = clen_all.split('\t')
    clen = float(clen_all_split[1])
    z_shifts = clen

# this probably need to change when you change the range of the detector distances for which you are screening
    det_dist_arr = np.arange(9070,9470,50)
    print(det_dist_arr)
    print('optimal z-shift (or clen): ', z_shifts)
    closest_detdist = min(det_dist_arr, key=lambda x:abs(x-clen))
    print("Choose stream file with detectro distance", closest_detdist)
else:
    sys.exit("NEED clen.txt to proceed!")

## open stream file with DetDist closest_detdist 
## THIS NEED TO CHANGE BEFORE PROCEEDING to match the file name
stream_file_name = "exp_19638_run_0043-0045_type_d+l_delay_10e-5_dist_%d_reserv_10_DetDist.stream" % (closest_detdist)

### caclulate the mean and std for the cell parameters in the stream file and save on text file 
cell_param_stat(stream_file_name)




# continue with detector corretion 
f = open(stream_file_name, 'r')
# Determine the mean shifts
x_shifts = []
y_shifts = []
z_shifts = []

prog1 = re.compile("^predict_refine/det_shift\sx\s=\s([0-9\.\-]+)\sy\s=\s([0-9\.\-]+)\smm$")
prog2 = re.compile("^predict_refine/clen_shift\s=\s([0-9\.\-]+)\smm$")

while True:

    fline = f.readline()
    if not fline:
        break

    match = prog1.match(fline)
    if match:
        xshift = float(match.group(1))
        yshift = float(match.group(2))
        x_shifts.append(xshift)
        y_shifts.append(yshift)

    match = prog2.match(fline)
#    if match:
#        zshift = float(match.group(1))
#        z_shifts.append(zshift)

f.close()

# read z-shift from clen.txt 
file_clen = 'clen.txt'
with open(file_clen, "r") as file:
        readlines=file.read().split('\n')

clen_all = readlines[0]
clen_all_split = clen_all.split('\t')
clen = float(clen_all_split[1])
z_shifts = clen

mean_x = sum(x_shifts) / len(x_shifts)
mean_y = sum(y_shifts) / len(y_shifts)
print('Mean shifts: dx = {:.2} mm,  dy = {:.2} mm'.format(mean_x,mean_y))
print('optimal z-shift (or clen): ', z_shifts)

# save mean_x and mean_y in file 
file_mean_shift = open('mean_shift_geom.txt', 'w')
file_mean_shift.write("mean_x = %.4f\n" % mean_x)
file_mean_shift.write("mean_y = %.4f\n" % mean_y)
#n_shift.write("mean_x = %.8f\n" % mean_x)file_mean_shift.write("mean_x =" + str(mean_x) + "\n")
#file_mean_shift.write("mean_y =" + str(mean_y) + "\n")
file_mean_shift.close

  #n_shifti  line1 = 'mean_x = %d \n', mean_x
 #   line2  = 'mean_y = %d \n', mean_y
#    f1.writelines([line1, line2])




nbins = 200
H, xedges, yedges = np.histogram2d(x_shifts,y_shifts,bins=nbins)
H = np.rot90(H)
H = np.flipud(H)
Hmasked = np.ma.masked_where(H==0,H)

# Apply shifts to geometry

if have_geom:

    out = os.path.splitext(geom)[0]+'-predrefine.geom'
    print('Applying corrections to {}, output filename {}'.format(geom,out))
    g = open(geom, 'r')
    h = open(out, 'w')
    panel_resolutions = {}

    prog1 = re.compile("^\s*res\s+=\s+([0-9\.]+)\s")
    prog2 = re.compile("^\s*(.*)\/res\s+=\s+([0-9\.]+)\s")
    prog3 = re.compile("^\s*(.*)\/corner_x\s+=\s+([0-9\.\-]+)\s")
    prog4 = re.compile("^\s*(.*)\/corner_y\s+=\s+([0-9\.\-]+)\s")
    prog5 = re.compile('clen\s=\s([^"\n]+)')
    default_res = 0
    while True:

        fline = g.readline()
        if not fline:
            break

        match = prog1.match(fline)
        if match:
            default_res = float(match.group(1))
            h.write(fline)
            continue

        match = prog2.match(fline)
        if match:
            panel = match.group(1)
            panel_res = float(match.group(2))
            default_res =  panel_res
            panel_resolutions[panel] = panel_res
            h.write(fline)
            continue
        match = prog3.match(fline)
        if match:
            panel = match.group(1)
            panel_cnx = float(match.group(2))
            if panel in panel_resolutions:
                res = panel_resolutions[panel]
            else:
                res = default_res
                print('Using default resolution ({} px/m) for panel {}'.format(res, panel))
            h.write('%s/corner_x = %f\n' % (panel,panel_cnx+(mean_x*res*1e-3)))
            continue

        match = prog4.match(fline)
        if match:
            panel = match.group(1)
            panel_cny = float(match.group(2))
            if panel in panel_resolutions:
                res = panel_resolutions[panel]
            else:
                res = default_res
                print('Using default resolution ({} px/m) for panel {}'.format(res, panel))
            h.write('%s/corner_y = %f\n' % (panel,panel_cny+(mean_y*res*1e-3)))
            continue

        match = prog5.match(fline)
        if match:
            print("it's a match!", match)
            h.write('clen = %f\n' % (z_shifts*1e-6))
            continue




        h.write(fline)

    g.close()
    h.close()





