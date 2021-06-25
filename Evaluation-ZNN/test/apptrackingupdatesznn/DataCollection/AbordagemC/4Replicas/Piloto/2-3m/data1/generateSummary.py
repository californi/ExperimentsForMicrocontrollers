import os
import sys
import re
import json
from ast import literal_eval
import datetime

file = None

arr = None

try:
    arr = os.listdir('./')
    for fileName in arr:
        print("Reading file: " + fileName)
        
        if fileName.startswith("trace"):
            print("\nTrace znn data\n")
            with open(fileName, 'r') as reader:

                line = reader.readline()
                
                while line != '' or line == None:                    
                    capturedEvent = re.search("captured event for znn", line, re.IGNORECASE)

                    if capturedEvent:
                        line = reader.readline()                            
                        line = line.replace("root - WARNING - ", "")                 
                        print(line)   

                    line = reader.readline()
                    

        if fileName.startswith("kubow"):
            with open(fileName, 'r') as reader:

                line = reader.readline()
                print("\nKubow data\n")
                while line != '':                    
                    triggeredAction = re.search("Tactic action", line, re.IGNORECASE)

                    if triggeredAction:
                        line = reader.readline()    
                        line = line.replace("INFO  GuavaMasterReportingPort:35 - EXECUTOR: [[Rainbow Strategy Executor]]", "")
                        line = line.replace("Executing node ","")
                        
                        print(line)

                    line = reader.readline()    

        if fileName.startswith("fidelitya"):
            with open(fileName, 'r') as reader:

                line = reader.readline()
                print("\nfidelitya data\n")
                while line != '':                    
                    triggeredAction = re.search("Tactic action", line, re.IGNORECASE)

                    if triggeredAction:
                        line = reader.readline()    
                        line = line.replace("INFO  GuavaMasterReportingPort:35 - EXECUTOR: [[Rainbow Strategy Executor]]", "")
                        line = line.replace("Executing node ","")
                        print(line)

                    line = reader.readline()          

        if fileName.startswith("fidelityb"):
            with open(fileName, 'r') as reader:

                line = reader.readline()
                print("\nfidelityb data\n")
                while line != '':                    
                    triggeredAction = re.search("Tactic action", line, re.IGNORECASE)

                    if triggeredAction:
                        line = reader.readline()    
                        line = line.replace("INFO  GuavaMasterReportingPort:35 - EXECUTOR: [[Rainbow Strategy Executor]]", "")
                        line = line.replace("Executing node ","")
                        print(line)

                    line = reader.readline()                                                  

        if fileName.startswith("scalabilitya"):
            with open(fileName, 'r') as reader:

                line = reader.readline()
                print("\nscalabilitya data\n")
                while line != '':                    
                    triggeredAction = re.search("Tactic action", line, re.IGNORECASE)

                    if triggeredAction:
                        line = reader.readline()    
                        line = line.replace("INFO  GuavaMasterReportingPort:35 - EXECUTOR: [[Rainbow Strategy Executor]]", "")
                        line = line.replace("Executing node ","")
                        print(line)

                    line = reader.readline()          

        if fileName.startswith("scalabilityb"):
            with open(fileName, 'r') as reader:

                line = reader.readline()
                print("\nscalabilityb data\n")
                while line != '':                    
                    triggeredAction = re.search("Tactic action", line, re.IGNORECASE)

                    if triggeredAction:
                        line = reader.readline()    
                        line = line.replace("INFO  GuavaMasterReportingPort:35 - EXECUTOR: [[Rainbow Strategy Executor]]", "")
                        line = line.replace("Executing node ","")
                        print(line)

                    line = reader.readline()                                                  

        if fileName.startswith("metacontroller"):
            with open(fileName, 'r') as reader:

                line = reader.readline()
                print("\nMetaController data\n")
                while line != '':                    
                    triggeredAction = re.search("Tactic action", line, re.IGNORECASE)

                    if triggeredAction:
                        line = reader.readline()    
                        line = line.replace("INFO  GuavaMasterReportingPort:35 - EXECUTOR: [[Rainbow Strategy Executor]]", "")
                        line = line.replace("Executing node ","")
                        print(line)

                    line = reader.readline()  
               
        
except:
    e = sys.exc_info()[0]
    print(e)

#abc = input("press to exit.")