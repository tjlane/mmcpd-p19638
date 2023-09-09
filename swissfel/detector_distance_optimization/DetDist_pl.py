#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Oct 26 11:36:07 2020

Started adapting on 2021.06.08

@author: azeglio.diethelm@psi.ch

This is a python implementation of the script: Parse_cell_list_iteration2_PSk.m.
"""


import numpy as np
import pandas as pd
import seaborn as sns

import matplotlib.pyplot as plt

import matplotlib
matplotlib.use('Agg')

# =============================================================================
# Import data
# =============================================================================
print('Loading & parsing data...')

df = pd.read_csv('injectors_clean.tsv', sep='\s+', 
                 usecols=['ifile','sfile','a','b','c'])
df = df[df.a > 0]

df['stream'] = df.sfile.str.rsplit('/', n=1, expand=True)[1]
df[['exp','run','type','delay','distance','injector']] = df.stream.str.split('_', expand=True, n=12)[[1,3,5,7,9,11]]
df.distance = df.distance.astype(int)

# Subset dataframe to check 
#temp = df.head() 


#temp.ifile.str.rsplit('/', expand=True, n=1)[1].str.split('.', expand=True, n=1)[0].str[4:]
#df["delay"] = "string"
#temp.sfile.str.rsplit('/', expand=True, n=1)[1].str.split('.', expand=True, n=1)[0].str[3:].astype(int)

# =============================================================================
# Calculate RMS values by injector and distance and filter data
# =============================================================================
# Calculate RMS values by injector and distance
df_rms = df.groupby(['run','distance']).apply(lambda x: np.std(x)**2)[['a','b','c']]
df_rms = df_rms.eval('rms = sqrt(a+b+c)')['rms']

df_rms_u = df_rms.unstack(0)
df_rms = df_rms.reset_index()

# Add injectors back to the dataframe.
df_rms = pd.merge(df_rms, df[['run','injector']].drop_duplicates('run'), on='run', how='left')

# Keep only indexable regions: count numbers of patterns per injector and distance
#def keep_good_only(min_pat = 50, pp_min_pat=.85):
#    """

### THIS SECTION BADLY NEEDS FIXING: remove data points that have less than say 50 patterns & remove data points that have less than say 85 % of the maximal patterns of a series ####

#    This function remove all distances/injector with low indexing rates.
#    This is necessary to remove outliers caused by low count numbers.
#    """
#    print('Filtering data...')
#    pat_count = df.groupby(['run','distance'])['a'].count().rename('pat')
#    pat_max = pat_count.unstack(0).max()
#    pat_count = pat_count.reset_index().merge(pat_max.rename('pat_max'), on='run')
#    pat_rel = pat_count[ pat_count.pat > pat_count.pat_max*pp_min_pat ]    # Minimum of 85% of indexable patterns found
#   pat_rel = pat_rel[ pat_count.pat > min_pat ]  # Drop when less than 200 patterns
#    # Plot number of patterns per injector
#    #g = sns.FacetGrid(pat_count.reset_index(), col="injector", col_wrap=8)
#   #g.map(sns.lineplot, "distance", "a")
#    return df_rms.loc[pat_rel.index]
#df_rms = keep_good_only()

# Plot number of patterns per injector
def plot_patnum():
    pat_count = df.groupby(['run','distance'])['a'].count().rename('pat').reset_index()
    print(pat_count.groupby('run').pat.max())
    g = sns.FacetGrid(pat_count.reset_index(), col="run", col_wrap=8)
    g.map(sns.lineplot, "distance", "pat")
    # no_patterns = pat_count.groupby('run').pat.max()
# plot_patnum()


# Plot the RMS values
def plot_rmsvals():
    g = sns.FacetGrid(df_rms, col="injector", col_wrap=8)
    g.map(sns.lineplot, "distance", "rms")
# plot_rmsvals()




# =============================================================================
# Fit model
# Instructions: https://scipy-lectures.org/intro/summary-exercises/optimize-fit.html
# =============================================================================
import scipy as sp 



def fit_model(run, plot=False, save=False):
    """
    Returns detector distance according to model. 
    d0 is the physical detector distance set during the experiment.
    """
    print('Fitting run', run)
    # Select injector to fit and respective RMS data
    y = df_rms[df_rms.run==run].set_index('distance').rms
    d0 = y.index.max() - (y.index.max()-y.index.min())/2
    
    # Fit model to data 
    def model(x, coeffs):
        return coeffs[0] + coeffs[1]*np.log(np.cosh(coeffs[3]*(x-coeffs[2]))) 
    def residuals(coeffs, y, t):
        return y - model(t, coeffs)
    init = [0.05, 0.005, d0, 0.015]
    fit, flag = sp.optimize.leastsq(residuals, init, args=(y.values, y.index.values ), maxfev=10000)
      
    if plot:
        t = y.index.values
        x = np.linspace(t.min(), t.max(), 100)
        plt.plot(t, y)
        plt.plot(x, model(x, fit))
        plt.axvline(x=fit[2])
        plt.title('Run '+str(run)+' - calculated distance: '+ str(fit[2]))
        if save:
            plt.savefig('run_'+str(run)+'.pdf')
            plt.close()
    print('Run '+str(run)+': Optimal distance according to model:', fit[2])
    return run, fit[2]


# Test on single runs
# fit_model(run="000567", plot=False)


def make_clen(plot=False, out_name='clen.txt'):
    clen = []
    for run in df_rms.run.unique():
        try:
            res = fit_model(run, plot=plot, save=plot)
        except:
            print('Failed on injector:', run)
        clen.append(res)
    clen = pd.DataFrame(clen, columns=['injector','clen'])
    clen.clen = clen.clen.astype(int)
    # clen.injector = clen.injector.astype(int)
    clen.to_csv(out_name,index=False, header=False, sep='\t')
    
    
make_clen(plot=True, out_name='clen.txt')
