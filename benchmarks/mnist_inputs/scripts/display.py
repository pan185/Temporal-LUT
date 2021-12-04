############################################################
## Author       : Prajyot Gupta
## Project      : ECE 751
## Department   : Department of ECE, UW Madison
## Description  : Display images from MNIST Database
############################################################
import idx2numpy
import numpy as np
import matplotlib.pyplot as plt
file = '../data/train-images-idx3-ubyte'
arr = idx2numpy.convert_from_file(file)
# arr is now a np.ndarray type of object of shape 60000, 28, 28
# Display image-57
plt.imshow(arr[57], cmap=plt.cm.binary)
