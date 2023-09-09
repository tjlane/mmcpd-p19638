import glob
import numpy
import pandas as pd
import re
import os
import matplotlib
matplotlib.use('agg')
import matplotlib.pyplot as plt
import numpy as np

## Plot x_mean, y_mean, clen form all the reservoirs (dark frames only)
## INPUT: 
## * mean_shift_geom.txt: output from det_shift_cell_stat_res_new_dark.py
## * clen.txt: output from DetDist_pl.py/DetDist_pl.sh
## OUTPUT: 
## * dark_mean_shift.png


mean_shift_filenames = sorted(glob.glob('reserv_*/dark_DetDist/mean_shift_geom.txt'))
clen_shift_filenames = sorted(glob.glob('reserv_*/dark_DetDist/clen.txt'))

reserv_no = []
regex = re.compile(r'\d+')

for i in range(len(mean_shift_filenames)):
#     print(cell_param_filenames[i])
    numbers = regex.findall(mean_shift_filenames[i])
    reserv_no.append(str(numbers))

for i in range(len(reserv_no)):
    reserv_no = [s.replace("]", "") for s in reserv_no]
    reserv_no = [s.replace("[", "") for s in reserv_no]
    reserv_no = [s.replace("'", "") for s in reserv_no]
    
reserv_no = [eval(i) for i in reserv_no]

df = pd.DataFrame(reserv_no,columns =['reserv_no'])

# define list to hold all lines
mean_shift_list = []
clen_list = []

# read through all files and append content to the list of lists
for file in mean_shift_filenames :
    with open (file, 'r') as f:
        s_text_list = f.readlines()
        mean_shift_list.append(s_text_list)

for i in range(len(mean_shift_list)):
    mean_shift_list[i]=[s.replace('mean_x =', '') for s in mean_shift_list[i]]
    mean_shift_list[i]=[s.replace('mean_y =', '') for s in mean_shift_list[i]]
    mean_shift_list[i]=[s.replace('\n', '') for s in mean_shift_list[i]]

#define list of files to access in a specific directory
#clen_shift_filenames = sorted(glob.glob('reserv_*/clen.txt'))

# define list to hold all lines
clen_list = []

# read through all files and append content to the list of lists
for file in clen_shift_filenames:
    with open (file, 'r') as f:
        s_text_list = f.readlines()
        clen_list.append(s_text_list)


for i in range(len(clen_list)):
#     name.split('.')[1].lstrip().split(' ')[0]
    clen_list[i] = [s.split('\t')[1].lstrip().split(' ')[0] for s in clen_list[i]]
    clen_list[i] = [s.replace("\n", "") for s in clen_list[i]]


df_clen = pd.DataFrame(clen_list, columns = ['clen'])
df_clen=df_clen.astype(float)
df_clen =df_clen*0.00001
df_temp = pd.DataFrame(mean_shift_list, columns = ['mean_x', 'mean_y'])
df_temp=df_temp.astype(float)
print("df_temp\n",df_temp)
print("df_clen\n",df_clen)
df=df.astype(float)
#df=df.sort_values('reserv_no')
df=df.reset_index(drop=True)
df = pd.concat([df,df_temp], axis=1)
df = pd.concat([df,df_clen], axis=1)
df=df.sort_values('reserv_no')
print('df\n',df)
# define subplot grid
fig1, axs1 = plt.subplots(nrows=3, ncols=1, figsize=(25, 20))
plt.subplots_adjust(hspace=0.5)
# fig.suptitle("Cell parameters of each reservoir", fontsize=18, y=0.95)


# set axis
for rcolumn in range(3):
    axs1[rcolumn].set_xlabel('reservoir no', fontsize=40)   
    
axs1[0].set_ylabel('mean shift x direction', fontsize=40) 
axs1[1].set_ylabel('mean shift y direction', fontsize=40)
axs1[2].set_ylabel('shift z direction (clen)', fontsize=40)
    
# plot 
xticks=np.arange(4, 59, step=1)
axs1[0].set_xticks(xticks)
axs1[1].set_xticks(xticks)
axs1[2].set_xticks(xticks)

axs1[0].plot(df.reserv_no, df.mean_x)
axs1[0].scatter(df.reserv_no, df.mean_x, color='orange', s=200)
axs1[1].plot(df.reserv_no, df.mean_y)
axs1[1].scatter(df.reserv_no, df.mean_y,color='orange', s=200)
axs1[2].plot(df.reserv_no, df.clen)
axs1[2].scatter(df.reserv_no, df.clen,color='orange', s=200)
    
fig1.tight_layout()
# plt.show()
fig1.savefig("dark_mean_shift.png", format="png", dpi=600)


























