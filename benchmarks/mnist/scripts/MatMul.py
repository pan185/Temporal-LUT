# -*- coding: utf-8 -*-
"""
@Author: Prajyot
"""
import numpy as np
with open('weight.txt') as fp:
    weights_in = [list(map(int, line.strip().split(' '))) for line in fp]
    
weights = np.transpose(weights_in)
    
with open('5.txt') as pp:
    input = [list(map(int, line.strip().split(' '))) for line in pp]
    
p = np.dot(input,weights)
