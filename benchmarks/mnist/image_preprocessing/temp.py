# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

import cv2
import numpy as np

print(cv2.__version__)
cap = cv2.VideoCapture(1, cv2.CAP_DSHOW)

if not (cap.isOpened()):
    print("Could not open video device")

cap.set(cv2.CAP_PROP_FRAME_WIDTH, 448)
cap.set(cv2.CAP_PROP_FRAME_HEIGHT, 448)

while(True):    
    # Capture frame-by-frame    
    ret, frame = cap.read()    
    
    # Display the resulting frame    
    cv2.imshow('preview',frame)    
    #cv2.imshow('frame', frame)

    gray = cv2.cvtColor(frame, cv2.COLOR_RGB2GRAY)
    
    #print(gray.shape)
    #print(gray.min())
    #print(gray.max())
    
    #cv2.imshow('frame', frame)
    
    
    
    if cv2.waitKey(1) & 0xFF == ord(' '):
        gray2 = cv2.resize(gray,(28,28))
        #print(gray2)
        #cv2.imshow('frame', gray2)
        gray2= gray2.flatten()
        with open("input.txt", "w") as f:
            for item in gray2:
                f.write("8'd" + str(item) + " ")
        
        #a_file = open("test.txt", "w")
        
        #content = str(gray2)
        #a_file.write(content)

        #a_file.close()
        print("input values saved!")
        
    
    #Waits for a user input to quit the application    
    if cv2.waitKey(5) & 0xFF == ord('q'):  
        
        break
    
cap.release()
cv2.destroyAllWindows()