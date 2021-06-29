
#!/bin/bash


# generating cpu and bm file
python ./cleaningJsonCpuMb.py > cpuMB.log

# generating failures
python ./cleaningFailures.py | grep -i insufficient | grep -v 200 > failures.log

# SLO
python ./cleaningKubowSLO.py > slos.log

# Stability
python ./cleaningKubowStability.py > stabilities.log

folderName=performanceLogs$(date +"%H%M%S")
mkdir $folderName
mv cpuMB.log $folderName
mv failures.log $folderName
mv slos.log $folderName
mv stabilities.log $folderName


"""
----------------Memory---------------------
----------------Cpu------------------------
root - WARNING - 

bento@DESKTOP-H2T750B:/mnt/d/Bento/Projects/PhD/Experimentos/ExperimentsForMicrocontrollers/Evaluation-ZNN/test/apptrackingupdatesznn/DataCollection/AbordagemA/10Replicas/5-6m/data1$ 
cat cpuAndMemory_20210520_202716.log | sed 's/root//' | sed 's/WARNING//' | sed 's/ \- / /' | sed 's/ \- / /' | sed 's/  //' | sed 's/----------------Memory---------------------//' | sed 's/----------------Cpu------------------------//' | sed 's/-----------------------------------------//' | sed 's/Generating logs - usage of CPU and Memory.//' | sed 's/Datetime://' | sed 's/Finished stream.//'


cat cpuAndMemory_20210520_202716.log | sed 's/root//' | sed 's/WARNING//' | sed 's/ \- / /' | sed 's/ \- / /' | sed 's/  //' | sed 's/----------------Memory---------------------//' | sed 's/----------------Cpu------------------------//' | sed 's/-----------------------------------------//' | sed 's/Generating logs - usage of CPU and Memory.//' | sed 's/Datetime://' | sed 's/Finished stream.//' | sed ':a;N;$!ba;s/\n/ /g'



#        prepareQueryCpu("failuremanager", period)
#        prepareQueryCpu("failuremonitor", period)
#        prepareQueryCpu("fidelity", period)
#        prepareQueryCpu("grafana", period)
#        prepareQueryCpu("k6", period)
#        prepareQueryCpu("kube-state", period)
#        prepareQueryCpu("kube-znn", period)
#        prepareQueryCpu("metacontroller", period)
#        prepareQueryCpu("nginx", period)
#        prepareQueryCpu("prometheus", period)
#        prepareQueryCpu("scalability", period)


cat cpuAndMemory_20210520_202716.log | sed 's/root//' | sed 's/WARNING//' | sed 's/ \- / /' | sed 's/ \- / /' | sed 's/  //' | sed 's/----------------Memory---------------------//' | sed 's/----------------Cpu------------------------//' | sed 's/-----------------------------------------//' | sed 's/Generating logs - usage of CPU and Memory.//' | sed 's/Datetime://' | sed 's/Finished stream.//' | grep kube-znn

"""