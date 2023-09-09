#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import pandas as pd
import sys

## Print on screen mean, stdev of cell parameters of stream file

## it takes as input a text file that has the parameters for as colummns. 
## for examples of how the format of the input file check txt files cell_param_reserv_[number of reserv].txt, 
## which is located insise each reserv_*

with open(sys.argv[1], "r") as f:
	df = pd.read_table(f, delim_whitespace=True, header=None)

df.columns = ['a', 'b', 'c', 'nm', 'alpha', 'beta', 'gamma', 'deg']


print("Mean of cell parameters")
print("a = %.2f " % df.a.mean())
print("b = %.2f " % df.b.mean())
print("c = %.2f " % df.c.mean(),"nm")
print("alpha = %.2f " % df.alpha.mean())
print("beta = %.2f " % df.beta.mean())
print("gamma = %.2f " % df.gamma.mean(), "deg")

print("Mean of cell parameters")
print("a = %.2f " % df.a.std())
print("b = %.2f " % df.b.std())
print("c = %.2f " % df.c.std())
print("alpha = %.2f " % df.alpha.std())
print("beta = %.2f " % df.beta.std())
print("gamma = %.2f " % df.gamma.std())

