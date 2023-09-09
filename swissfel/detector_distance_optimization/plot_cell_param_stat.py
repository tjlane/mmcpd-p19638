import glob
import numpy
import pandas as pd
import re
import os
import matplotlib
matplotlib.use('agg')
import matplotlib.pyplot as plt
import numpy as np

## Plotting statistics (mean, stdev, skewnees and kurtosis) of the cell parameters from all the reservoirs (dark frames only)
## INPUT: 
## * cell_param_mean_stdev.txt: text file that contains all mean, std, skewness, kurotsis (output from det_shift_cell_stat_res_new_dark.py)
## OUTPUT: 
## * dark_cell_parameters_zoom_std.png
## * dark_cell-angles.png
## * dark_cell_parameters_zoom_kurto.png
## * dark_cell_parameters_zoom_skew.png
## * dark_cell_parameters_zoom_kurto.png
## * dark_cell-angles_zoomed.png
## * dark_cell_parameters_zoom_std.png
## * dark_cell_parameters_zoom_mean.png

cell_param_filenames = sorted(glob.glob('reserv_*/dark_DetDist/cell_param_mean_stdev.txt'))

reserv_no = []
regex = re.compile(r'\d+')

for i in range(len(cell_param_filenames)):
#     print(cell_param_filenames[i])
    numbers = regex.findall(cell_param_filenames[i])
    reserv_no.append(str(numbers))

for i in range(len(reserv_no)):
    reserv_no = [s.replace("]", "") for s in reserv_no]
    reserv_no = [s.replace("[", "") for s in reserv_no]
    reserv_no = [s.replace("'", "") for s in reserv_no]
    
reserv_no = [eval(i) for i in reserv_no]


df_mean = pd.DataFrame(reserv_no,columns =['reserv_no'])
df_std = pd.DataFrame(reserv_no,columns =['reserv_no'])
df_skew = pd.DataFrame(reserv_no,columns =['reserv_no'])
df_kurto = pd.DataFrame(reserv_no,columns =['reserv_no'])

appended_data = []
for filename in cell_param_filenames:
    df_now = pd.read_csv(filename, delimiter = "\t", index_col=0)
    appended_data.append(df_now)
    
appended_data = pd.concat(appended_data)

df_mean['a_mean'] = appended_data.a['mean'].reset_index(drop=True)
df_mean['b_mean'] = appended_data.b['mean'].reset_index(drop=True)
df_mean['c_mean'] = appended_data.c['mean'].reset_index(drop=True)
df_mean['alpha_mean'] = appended_data.alpha['mean'].reset_index(drop=True)
df_mean['gamma_mean'] = appended_data.beta['mean'].reset_index(drop=True)
df_mean['beta_mean'] = appended_data.gamma['mean'].reset_index(drop=True)
df_mean = df_mean.sort_values('reserv_no')

df_std['a_std'] = appended_data.a['std'].reset_index(drop=True)
df_std['b_std'] = appended_data.b['std'].reset_index(drop=True)
df_std['c_std'] = appended_data.c['std'].reset_index(drop=True)
df_std['alpha_std'] = appended_data.alpha['std'].reset_index(drop=True)
df_std['gamma_std'] = appended_data.beta['std'].reset_index(drop=True)
df_std['beta_std'] = appended_data.gamma['std'].reset_index(drop=True)
df_std = df_std.sort_values('reserv_no')

df_skew['a_skewness'] = appended_data.a['skewness'].reset_index(drop=True)
df_skew['b_skewness'] = appended_data.b['skewness'].reset_index(drop=True)
df_skew['c_skewness'] = appended_data.c['skewness'].reset_index(drop=True)
df_skew['alpha_skewness'] = appended_data.alpha['skewness'].reset_index(drop=True)
df_skew['gamma_skewness'] = appended_data.beta['skewness'].reset_index(drop=True)
df_skew['beta_skewness'] = appended_data.gamma['skewness'].reset_index(drop=True)
df_skew = df_skew.sort_values('reserv_no')

df_kurto['a_kurtosis'] = appended_data.a['kurtosis'].reset_index(drop=True)
df_kurto['b_kurtosis'] = appended_data.b['kurtosis'].reset_index(drop=True)
df_kurto['c_kurtosis'] = appended_data.c['kurtosis'].reset_index(drop=True)
df_kurto['alpha_kurtosis'] = appended_data.alpha['kurtosis'].reset_index(drop=True)
df_kurto['gamma_kurtosis'] = appended_data.beta['kurtosis'].reset_index(drop=True)
df_kurto['beta_kurtosis'] = appended_data.gamma['kurtosis'].reset_index(drop=True)
df_kurto = df_kurto.sort_values('reserv_no')

df_stat_all = pd.concat([df_mean, df_std, df_skew, df_kurto], axis=1)
df_stat_all = df_stat_all.loc[:,~df_stat_all.columns.duplicated()].copy()
print(df_stat_all)

# define subplot grid
fig1, axs1 = plt.subplots(nrows=3, ncols=4, figsize=(15, 12))
plt.subplots_adjust(hspace=0.5)

# set axis
for rcolumn in range(3):
    axs1[rcolumn,0].set_xlabel('reservoir no',fontsize=15)
    axs1[rcolumn,1].set_xlabel('reservoir no',fontsize=15)
    axs1[rcolumn,2].set_xlabel('reservoir no',fontsize=15)
    axs1[rcolumn,3].set_xlabel('reservoir no',fontsize=15)
    
    axs1[rcolumn,0].set_ylabel('mean',fontsize=15)
    axs1[rcolumn,1].set_ylabel('stdev',fontsize=15)
    axs1[rcolumn,2].set_ylabel('skewness',fontsize=15)
    axs1[rcolumn,3].set_ylabel('kurtosis',fontsize=15)
    
    
# plot 
axs1[0,0].set_title("Graphs in this row are for axis a (Ang)", fontsize=18)
axs1[1,0].set_title("Graphs in this row are for axis b (Ang)", fontsize=18)
axs1[2,0].set_title("Graphs in this row are for axis c (Ang)", fontsize=18)


axs1[0,0].bar(df_stat_all.reserv_no, df_stat_all.a_mean)
axs1[1,0].bar(df_stat_all.reserv_no, df_stat_all.b_mean)
axs1[2,0].bar(df_stat_all.reserv_no, df_stat_all.c_mean)


axs1[0,1].bar(df_stat_all.reserv_no, df_stat_all.a_std)
axs1[1,1].bar(df_stat_all.reserv_no, df_stat_all.b_std)
axs1[2,1].bar(df_stat_all.reserv_no, df_stat_all.c_std)


axs1[0,2].bar(df_stat_all.reserv_no, df_stat_all.a_skewness)
axs1[1,2].bar(df_stat_all.reserv_no, df_stat_all.b_skewness)
axs1[2,2].bar(df_stat_all.reserv_no, df_stat_all.c_skewness)

axs1[0,3].bar(df_stat_all.reserv_no, df_stat_all.a_kurtosis)
axs1[1,3].bar(df_stat_all.reserv_no, df_stat_all.b_kurtosis)
axs1[2,3].bar(df_stat_all.reserv_no, df_stat_all.c_kurtosis)
    
fig1.tight_layout()
fig1.savefig("dark_cell-parameters.png", format="png", dpi=600)
#plt.show()

# define subplot grid
fig2, axs2 = plt.subplots(nrows=3, ncols=4, figsize=(15, 12))
plt.subplots_adjust(hspace=0.5)
# fig.suptitle("Cell parameters of each reservoir", fontsize=18, y=0.95)


# set axis
for rcolumn in range(3):
    axs2[rcolumn,0].set_xlabel('reservoir no',fontsize=15)
    axs2[rcolumn,1].set_xlabel('reservoir no',fontsize=15)
    axs2[rcolumn,2].set_xlabel('reservoir no',fontsize=15)
    axs2[rcolumn,3].set_xlabel('reservoir no',fontsize=15)
    
    axs2[rcolumn,0].set_ylabel('mean',fontsize=15)
    axs2[rcolumn,1].set_ylabel('stdev',fontsize=15)
    axs2[rcolumn,2].set_ylabel('skewness',fontsize=15)
    axs2[rcolumn,3].set_ylabel('kurtosis',fontsize=15)
    
    
# plot 
axs2[0,0].set_title("Graphs in this row are for axis alpha (deg)", fontsize=18)
axs2[1,0].set_title("Graphs in this row are for axis beta (deg)", fontsize=18)
axs2[2,0].set_title("Graphs in this row are for axis gamma (deg)", fontsize=18)


axs2[0,0].bar(df_stat_all.reserv_no, df_stat_all.alpha_mean)
axs2[1,0].bar(df_stat_all.reserv_no, df_stat_all.beta_mean)
axs2[2,0].bar(df_stat_all.reserv_no, df_stat_all.gamma_mean)

axs2[0,1].bar(df_stat_all.reserv_no, df_stat_all.alpha_std)
axs2[1,1].bar(df_stat_all.reserv_no, df_stat_all.beta_std)
axs2[2,1].bar(df_stat_all.reserv_no, df_stat_all.gamma_std)

axs2[0,2].bar(df_stat_all.reserv_no, df_stat_all.alpha_skewness)
axs2[1,2].bar(df_stat_all.reserv_no, df_stat_all.beta_skewness)
axs2[2,2].bar(df_stat_all.reserv_no, df_stat_all.gamma_skewness)

axs2[0,3].bar(df_stat_all.reserv_no, df_stat_all.alpha_kurtosis)
axs2[1,3].bar(df_stat_all.reserv_no, df_stat_all.beta_kurtosis)
axs2[2,3].bar(df_stat_all.reserv_no, df_stat_all.gamma_kurtosis)
    
fig2.tight_layout()
#plt.show()
#fig1.savefig("dark_cell-parameters.png", format="png", dpi=600)
fig2.savefig("dark_cell-angles.png", format="png", dpi=600)


# zooming in
# define subplot grid
fig3, axs3 = plt.subplots(nrows=3, ncols=4, figsize=(15, 12))
plt.subplots_adjust(hspace=0.5)
# fig.suptitle("Cell parameters of each reservoir", fontsize=18, y=0.95)


# set axis
for rcolumn in range(3):
    axs3[rcolumn,0].set_xlabel('reservoir no',fontsize=15)
    axs3[rcolumn,1].set_xlabel('reservoir no',fontsize=15)
    axs3[rcolumn,2].set_xlabel('reservoir no',fontsize=15)
    axs3[rcolumn,3].set_xlabel('reservoir no',fontsize=15)

    axs3[rcolumn,0].set_ylabel('mean',fontsize=15)
    axs3[rcolumn,1].set_ylabel('stdev',fontsize=15)
    axs3[rcolumn,2].set_ylabel('skewness',fontsize=15)
    axs3[rcolumn,3].set_ylabel('kurtosis',fontsize=15)


# plot 
# zooming in the mean plots
axs3[0,0].set_ylim(6.8, 7.2)
axs3[1,0].set_ylim(11.5, 12)
axs3[2,0].set_ylim(16.7, 17.25)

#zoming in the std plots
axs3[0,1].set_ylim(0.020, 0.05)
axs3[1,1].set_ylim(0.020, 0.05)
axs3[2,1].set_ylim(0.04, 0.12)

#zooming n the skewness plots
# axs3[0,2].set_ylim(0.020, 0.05)
# axs3[1,2].set_ylim(0.020, 0.05)
# axs3[2,2].set_ylim(0.06, 0.12)

#zooming in the kurtosis plots 
# axs3[0,1].set_ylim(0.020, 0.05)
# axs3[1,1].set_ylim(0.025, 0.05)
# axs3[2,1].set_ylim(0.06, 0.12)

axs3[0,0].set_title("Graphs in this row are for axis alpha (deg)", fontsize=15)
axs3[1,0].set_title("Graphs in this row are for axis beta (deg)", fontsize=15)
axs3[2,0].set_title("Graphs in this row are for axis gamma (deg)", fontsize=15)

axs3[0,0].bar(df_stat_all.reserv_no, df_stat_all.a_mean)
axs3[1,0].bar(df_stat_all.reserv_no, df_stat_all.b_mean)
axs3[2,0].bar(df_stat_all.reserv_no, df_stat_all.c_mean)

axs3[0,1].bar(df_stat_all.reserv_no, df_stat_all.a_std)
axs3[1,1].bar(df_stat_all.reserv_no, df_stat_all.b_std)
axs3[2,1].bar(df_stat_all.reserv_no, df_stat_all.c_std)

axs3[0,2].bar(df_stat_all.reserv_no, df_stat_all.a_skewness)
axs3[1,2].bar(df_stat_all.reserv_no, df_stat_all.b_skewness)
axs3[2,2].bar(df_stat_all.reserv_no, df_stat_all.c_skewness)

axs3[0,3].bar(df_stat_all.reserv_no, df_stat_all.a_kurtosis)
axs3[1,3].bar(df_stat_all.reserv_no, df_stat_all.b_kurtosis)
axs3[2,3].bar(df_stat_all.reserv_no, df_stat_all.c_kurtosis)

fig3.tight_layout()
#plt.show()
#fig1.savefig("dark_cell-parameters.png", format="png", dpi=600)
fig3.savefig("dark_cell-angles_zoomed.png", format="png", dpi=600)

## zoom in mean -- show the reservoir number clearly
# define subplot grid
fig4, axs4 = plt.subplots(nrows=3, ncols=1, figsize=(25, 20))
plt.subplots_adjust(hspace=0.5)
# fig.suptitle("Cell parameters of each reservoir", fontsize=18, y=0.95)


# set axis
for rcolumn in range(3):
    axs4[rcolumn].set_xlabel('reservoir no', fontsize=20)   
    axs4[rcolumn].set_ylabel('mean',  fontsize=20)

    
# plot 
xticks=np.arange(4, 59, step=1)
axs4[0].set_xticks(xticks)
axs4[1].set_xticks(xticks)
axs4[2].set_xticks(xticks)

axs4[0].set_ylim(6.9, 7.05)
axs4[1].set_ylim(11.67, 11.85)
axs4[2].set_ylim(16.85, 17.15)

axs4[0].set_title("a axis (Ang)", fontsize=25)
axs4[1].set_title("b axis (Ang)", fontsize=25)
axs4[2].set_title("c axis (Ang)", fontsize=25)

axs4[0].bar(df_stat_all.reserv_no, df_stat_all.a_mean)
axs4[1].bar(df_stat_all.reserv_no, df_stat_all.b_mean)
axs4[2].bar(df_stat_all.reserv_no, df_stat_all.c_mean)

    
fig4.tight_layout()
plt.show()
fig4.savefig("dark_cell_parameters_zoom_mean.png", format="png", dpi=600)


## zoom in std -- show the reservoir number clearly
# define subplot grid
fig5, axs5 = plt.subplots(nrows=3, ncols=1, figsize=(25, 20))
plt.subplots_adjust(hspace=0.5)
# fig.suptitle("Cell parameters of each reservoir", fontsize=18, y=0.95)


# set axis
for rcolumn in range(3):
    axs5[rcolumn].set_xlabel('reservoir no', fontsize=20)   
    axs5[rcolumn].set_ylabel('stdev',  fontsize=20)

    
# plot 
xticks=np.arange(4, 59, step=1)
axs5[0].set_xticks(xticks)
axs5[1].set_xticks(xticks)
axs5[2].set_xticks(xticks)

axs5[0].set_ylim(0.020, 0.05)
axs5[1].set_ylim(0.020, 0.05)
axs5[2].set_ylim(0.04, 0.12)

axs5[0].set_title("a axis (Ang)", fontsize=25)
axs5[1].set_title("b axis (Ang)", fontsize=25)
axs5[2].set_title("c axis (Ang)", fontsize=25)

axs5[0].bar(df_stat_all.reserv_no, df_stat_all.a_std)
axs5[1].bar(df_stat_all.reserv_no, df_stat_all.b_std)
axs5[2].bar(df_stat_all.reserv_no, df_stat_all.c_std)

    
fig5.tight_layout()
plt.show()
fig5.savefig("dark_cell_parameters_zoom_std.png", format="png", dpi=600)


# define subplot grid
fig6, axs6 = plt.subplots(nrows=3, ncols=1, figsize=(25, 20))
plt.subplots_adjust(hspace=0.5)
# fig.suptitle("Cell parameters of each reservoir", fontsize=18, y=0.95)


# set axis
for rcolumn in range(3):
    axs6[rcolumn].set_xlabel('reservoir no', fontsize=20)   
    axs6[rcolumn].set_ylabel('skewness',  fontsize=20)

    
# plot 
xticks=np.arange(4, 59, step=1)
axs6[0].set_xticks(xticks)
axs6[1].set_xticks(xticks)
axs6[2].set_xticks(xticks)

axs6[0].set_title("a axis (Ang)", fontsize=25)
axs6[1].set_title("b axis (Ang)", fontsize=25)
axs6[2].set_title("c axis (Ang)", fontsize=25)

axs6[0].bar(df_stat_all.reserv_no, df_stat_all.a_skewness)
axs6[1].bar(df_stat_all.reserv_no, df_stat_all.b_skewness)
axs6[2].bar(df_stat_all.reserv_no, df_stat_all.c_skewness)

   
fig6.tight_layout()
plt.show()
fig6.savefig("dark_cell_parameters_zoom_skewness.png", format="png", dpi=600)

# define subplot grid
fig7, axs7 = plt.subplots(nrows=3, ncols=1, figsize=(25, 20))
plt.subplots_adjust(hspace=0.5)
# fig.suptitle("Cell parameters of each reservoir", fontsize=18, y=0.95)


# set axis
for rcolumn in range(3):
    axs7[rcolumn].set_xlabel('reservoir no', fontsize=20)   
    axs7[rcolumn].set_ylabel('kurtosis',  fontsize=20)

    
# plot 
xticks=np.arange(4, 59, step=1)
axs7[0].set_xticks(xticks)
axs7[1].set_xticks(xticks)
axs7[2].set_xticks(xticks)

axs7[0].set_title("a axis (Ang)", fontsize=25)
axs7[1].set_title("b axis (Ang)", fontsize=25)

axs7[0].bar(df_stat_all.reserv_no, df_stat_all.a_kurtosis)
axs7[1].bar(df_stat_all.reserv_no, df_stat_all.b_kurtosis)
axs7[2].bar(df_stat_all.reserv_no, df_stat_all.c_kurtosis)
    
fig7.tight_layout()
plt.show()
fig7.savefig("dark_cell_parameters_zoom_kurto.png", format="png", dpi=600)



