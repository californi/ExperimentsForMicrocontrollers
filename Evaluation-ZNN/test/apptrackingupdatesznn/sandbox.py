from kubernetes import client, config
import re
import datetime
                
dtEvent = datetime.datetime.now()
initialTime = dtEvent.strftime("%Y%m%d_%H%M%S")



# Configs can be set in Configuration class directly or using helper utility
config.load_kube_config()

def writeLogsFromPod(podname, content):
    file = podname + "_tracing_" + initialTime + ".log"
    f = open(file, "a")
    f.write(content)
    f.close()

v1 = client.CoreV1Api()
ret = v1.list_pod_for_all_namespaces(watch=False)
for i in ret.items:
    podKubow = re.search(
        'kubow', str(i.metadata.name), re.IGNORECASE)
    podK6 = re.search(
        'k6', str(i.metadata.name), re.IGNORECASE)

    if podKubow or podK6:
        logs = v1.read_namespaced_pod_log(i.metadata.name,i.metadata.namespace)
        writeLogsFromPod(i.metadata.name,logs)

    