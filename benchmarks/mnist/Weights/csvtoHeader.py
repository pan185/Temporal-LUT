# -*- coding: utf-8 -*-
"""
Created on Tue Dec 14 01:27:14 2021

@author: jenee
"""
import numpy as np

file = open("784_10.csv")
weightsMatrix = np.loadtxt(file, delimiter="," , dtype = int)
weightsMatrix_flat = weightsMatrix.flatten()
with open("input2.h", "w") as f:
    my_string ="__attribute__((aligned(16))) uint8_t stim_a[] = {\n" + ',\n'.join(map(str, map(hex,weightsMatrix_flat))) + "\n};"
    f.write(my_string)
f.close()