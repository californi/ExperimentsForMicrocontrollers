
import os
import sys
import re

file = None

arr = None

try:
    arr = os.listdir('./')
    for fileName in arr:
        if fileName.startswith("kubow") or fileName.startswith("fidelitya") or fileName.startswith("fidelityb") or fileName.startswith("scalabilitya") or fileName.startswith("scalabilityb"):
            with open(fileName, 'r') as reader:                
                line = reader.readline()                            
                while line != '' or line == None:   
                    strPattern = re.search('<slo>', line, re.IGNORECASE)   
                    if strPattern:
                        count = len(line)
                        i = line.find("slo")
                        if(i > 0):
                            #print(line)
                            #print(count)
                            #print(i)
                            datetimeEvent = line[0:19]
                            data = line[i:count]
                            splited = data.split(",")
                            splitedSplited = splited[0].split(":")
                            print(datetimeEvent + " - " + splitedSplited[1])

                        #print(line)
                    line = reader.readline()  
    
    #input("Press to exit.")
               
        
except:
    e = sys.exc_info()[0]
    print(e)

#abc = input("press to exit.")

"""
2021-05-20 23:25:18 INFO  Rainbow:694 - Delegate: d81ad448-6389-477a-9dca-c4c98d7f9fd3[GAUGE]: G[SloGauge:KubowGaugeT@127.0.0.1]: kubeZnnS.setServiceProperty([
    {"slo":1.0,"namespace":"default","name":"kube-znn"}, <slo>)])

"""