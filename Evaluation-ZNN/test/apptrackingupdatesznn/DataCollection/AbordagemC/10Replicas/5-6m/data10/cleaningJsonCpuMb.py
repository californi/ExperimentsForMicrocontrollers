
import os
import sys

file = None

arr = None

try:
    arr = os.listdir('./')
    for fileName in arr:
       # print("Reading file: " + fileName)
        
        if fileName.startswith("cpuAndMemory"):
            with open(fileName, 'r') as reader:                
                line = reader.readline()
                
                
                while line != '' or line == None:   
                    count = len(line)
                    i = line.find("'pod':")
                    if(i > 0):
                        #print(line)
                        #print(count)
                        #print(i)
                        data = line[i:count].replace("}","")
                        print(data)

                    line = reader.readline()  
    
    #input("Press to exit.")
               
        
except:
    e = sys.exc_info()[0]
    print(e)

#abc = input("press to exit.")

"""
{'metric': {'beta_kubernetes_io_arch': 'amd64', 'beta_kubernetes_io_os': 'linux', 'container': 'znn', 'id': '/kubepods.slice/kubepods-burstable.slice/kubepods-burstable-pod0af046de_2fb4_4ecb_a35f_fbeffd827adc.slice/docker-84d097a27f8b32eb59f392cd26176abf59d0c1a1bd187abae94d07ba2af11060.scope', 'image': 'sha256:420deba395922d1fc14fb9ab740dbf5c0aadcc60e41a7c1f1e92962fba78c96a', 'instance': 'minikube', 'job': 'kubernetes-cadvisor', 'kubernetes_io_arch': 'amd64', 'kubernetes_io_hostname': 'minikube', 'kubernetes_io_os': 'linux', 'minikube_k8s_io_commit': '043bdca07e54ab6e4fc0457e3064048f34133d7e', 'minikube_k8s_io_name': 'minikube', 'minikube_k8s_io_updated_at': '2021_05_20T19_41_48_0700', 'minikube_k8s_io_version': 'v1.17.1', 'name': 'k8s_znn_kube-znn-64cd6996dd-dcwqn_default_0af046de-2fb4-4ecb-a35f-fbeffd827adc_0', 'namespace': 'default', 
'pod': 'kube-znn-64cd6996dd-dcwqn'}, 'value': [1621553241.403, '1782.5185185185187']}
bento@DESKTOP-H2T750B:/mnt/d/Bento/Projects/PhD/Experimentos/ExperimentsForMicrocontrollers/Evaluation-ZNN/test/apptrackingupdatesznn/DataCollection/AbordagemA/10Replicas/5-6m/data1
$ cat cpuAndMemory_20210520_202716.log | sed 's/root//' | sed 's/WARNING//' | sed 's/ \- / /' | sed 's/ \- / /' | sed 's/  //' | sed 's/----------------Memory---------------------//' | sed 's/----------------Cpu------------------------//' | sed 's/-----------------------------------------//' | sed 's/Generating logs - usage of CPU and Memory.//' | sed 's/Datetime://' | sed 's/Finished stream.//' | grep kube-znn

"""