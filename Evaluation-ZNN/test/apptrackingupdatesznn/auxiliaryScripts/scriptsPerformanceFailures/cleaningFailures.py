
import os
import sys

file = None

arr = None

try:
    arr = os.listdir('./')
    for fileName in arr:
        if fileName.startswith("failuremanager"):
            with open(fileName, 'r') as reader:                
                line = reader.readline()                
                while line != '' or line == None:   
                    print(line)
                    line = reader.readline()  
    
    #input("Press to exit.")
               
        
except:
    e = sys.exc_info()[0]
    print(e)

#abc = input("press to exit.")
