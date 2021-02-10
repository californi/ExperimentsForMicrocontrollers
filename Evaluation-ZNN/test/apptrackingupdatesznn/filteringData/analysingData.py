import os
import sys
import re
import json
from ast import literal_eval
import datetime

file = None
currentImage = ""
nImageChanges = -1
currentReplicas = 0
nReplicasChanges = -1
nControllerAdaptationKubow = 0
nControllerAdaptationFidelitya = 0
nControllerAdaptationFidelityb = 0
nControllerAdaptationScalabilitya = 0
nControllerAdaptationScalabilityb = 0
nControllerAdaptationMeta = 0

arr = None

try:
    arr = os.listdir('./')
    for fileName in arr:
        print("Reading file: " + fileName)
        
        if fileName.startswith("trace"):

            with open(fileName, 'r') as reader:

                line = reader.readline()
                
                while line != '' or line == None:                    
                    capturedEvent = re.search("captured event for znn", line, re.IGNORECASE)

                    if capturedEvent:
                        line = reader.readline()                            
                        line = line.replace("root - WARNING - ", "")                 
                        print(line)   

                        Dict = eval(line) 
                        print(Dict['image'])
                        print(Dict['replicas'])
                         
                        if Dict['image'] != currentImage:
                            currentImage = Dict['image']
                            nImageChanges = nImageChanges + 1

                        if Dict['replicas'] != currentReplicas:
                            currentReplicas = Dict['replicas']
                            nReplicasChanges = nReplicasChanges + 1    

                    line = reader.readline()
                    

        if fileName.startswith("kubow"):
            with open(fileName, 'r') as reader:

                line = reader.readline()
                while line != '':                    
                    triggeredAction = re.search("Tactic action", line, re.IGNORECASE)

                    if triggeredAction:
                        line = reader.readline()    
                        line = line.replace("INFO  GuavaMasterReportingPort:35 - EXECUTOR: [[Rainbow Strategy Executor]]", "")
                        line = line.replace("Executing node ","")
                        print(line)
                        nControllerAdaptationKubow = nControllerAdaptationKubow + 1

                    line = reader.readline()    

        if fileName.startswith("fidelitya"):
            with open(fileName, 'r') as reader:

                line = reader.readline()
                while line != '':                    
                    triggeredAction = re.search("Tactic action", line, re.IGNORECASE)

                    if triggeredAction:
                        line = reader.readline()    
                        line = line.replace("INFO  GuavaMasterReportingPort:35 - EXECUTOR: [[Rainbow Strategy Executor]]", "")
                        line = line.replace("Executing node ","")
                        print(line)
                        nControllerAdaptationFidelitya = nControllerAdaptationFidelitya + 1

                    line = reader.readline()          

        if fileName.startswith("fidelityb"):
            with open(fileName, 'r') as reader:

                line = reader.readline()
                while line != '':                    
                    triggeredAction = re.search("Tactic action", line, re.IGNORECASE)

                    if triggeredAction:
                        line = reader.readline()    
                        line = line.replace("INFO  GuavaMasterReportingPort:35 - EXECUTOR: [[Rainbow Strategy Executor]]", "")
                        line = line.replace("Executing node ","")
                        print(line)
                        nControllerAdaptationFidelityb = nControllerAdaptationFidelityb + 1

                    line = reader.readline()                                                  

        if fileName.startswith("scalabilitya"):
            with open(fileName, 'r') as reader:

                line = reader.readline()
                while line != '':                    
                    triggeredAction = re.search("Tactic action", line, re.IGNORECASE)

                    if triggeredAction:
                        line = reader.readline()    
                        line = line.replace("INFO  GuavaMasterReportingPort:35 - EXECUTOR: [[Rainbow Strategy Executor]]", "")
                        line = line.replace("Executing node ","")
                        print(line)
                        nControllerAdaptationScalabilitya = nControllerAdaptationScalabilitya + 1

                    line = reader.readline()          

        if fileName.startswith("scalabilityb"):
            with open(fileName, 'r') as reader:

                line = reader.readline()
                while line != '':                    
                    triggeredAction = re.search("Tactic action", line, re.IGNORECASE)

                    if triggeredAction:
                        line = reader.readline()    
                        line = line.replace("INFO  GuavaMasterReportingPort:35 - EXECUTOR: [[Rainbow Strategy Executor]]", "")
                        line = line.replace("Executing node ","")
                        print(line)
                        nControllerAdaptationScalabilityb = nControllerAdaptationScalabilityb + 1

                    line = reader.readline()                                                  

        if fileName.startswith("metacontroller"):
            with open(fileName, 'r') as reader:

                line = reader.readline()
                while line != '':                    
                    triggeredAction = re.search("Tactic action", line, re.IGNORECASE)

                    if triggeredAction:
                        line = reader.readline()    
                        line = line.replace("INFO  GuavaMasterReportingPort:35 - EXECUTOR: [[Rainbow Strategy Executor]]", "")
                        line = line.replace("Executing node ","")
                        print(line)
                        nControllerAdaptationMeta = nControllerAdaptationMeta + 1

                    line = reader.readline()  
               
        
except:
    e = sys.exc_info()[0]
    print(e)
finally:  

    dtEvent = datetime.datetime.now()
    initialTime = dtEvent.strftime("%Y%m%d_%H%M%S")   
       
    print("Image Changes: " + str(nImageChanges))
    print("Replicas Changes: " + str(nReplicasChanges))
    print("Triggered actions in controller (Kubow): " + str(nControllerAdaptationKubow))
    print("Triggered actions in controller (fidelitya): " + str(nControllerAdaptationFidelitya))
    print("Triggered actions in controller (fidelityb): " + str(nControllerAdaptationFidelityb))
    print("Triggered actions in controller (scalabilitya): " + str(nControllerAdaptationScalabilitya))
    print("Triggered actions in controller (scalabilityb): " + str(nControllerAdaptationScalabilityb))
    print("Triggered actions in controller (metacontroller): " + str(nControllerAdaptationMeta))

    with open("filtered_" + initialTime + ".log", 'w') as writer:
        writer.write("Image Changes: " + str(nImageChanges) + "\n")
        writer.write("Replicas Changes: " + str(nReplicasChanges) + "\n")
        writer.write("Triggered actions in controller (Kubow): " + str(nControllerAdaptationKubow) + "\n")
        writer.write("Triggered actions in controller (fidelitya): " + str(nControllerAdaptationFidelitya) + "\n")
        writer.write("Triggered actions in controller (fidelityb): " + str(nControllerAdaptationFidelityb) + "\n")
        writer.write("Triggered actions in controller (scalabilitya): " + str(nControllerAdaptationScalabilitya) + "\n")
        writer.write("Triggered actions in controller (scalabilityb): " + str(nControllerAdaptationScalabilityb) + "\n")
        writer.write("Triggered actions in controller (metacontroller): " + str(nControllerAdaptationMeta) + "\n")

    path = os.getcwd()
    print ("The current working directory is %s" % path)

    print("Creating new folder.")
    creatingFolder = path+"\\filteredData_" +initialTime
    os.mkdir(creatingFolder)

    for file in os.listdir("./"):
        if file.endswith(".log"):
            os.rename("./" + file, creatingFolder + "/" + file)


#abc = input("press to exit.")