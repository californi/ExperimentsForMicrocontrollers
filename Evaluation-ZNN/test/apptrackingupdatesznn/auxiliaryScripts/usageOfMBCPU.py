import datetime
import requests
import logging
import sys

PROMETHEUS = 'http://prometheus:9090/'

def executeAndGenerate(query):
    response = requests.get(PROMETHEUS + '/api/v1/query', params={
                            'query': query })

    results = response.json()['data']['result']

    for result in results:
        logging.warning(result)

def prepareQueryCpu (pod, minutes):
    query = 'rate(container_cpu_usage_seconds_total {pod=~"%s.*", image!="", container!="POD"}[%sm])' % (pod, minutes)
    logging.warning("\n----------------Cpu------------------------")
    executeAndGenerate(query)

def prepareQueryMb (pod, minutes):
    query = 'rate(container_memory_working_set_bytes{pod=~"%s.*", image!="", container!="POD"}[%sm])' % (pod, minutes)
    logging.warning("\n----------------Memory---------------------")
    executeAndGenerate(query)


def main():
    try:
        period = input("Enter a period in minutes: ")
        prepareQueryCpu("failuremanager", period)
        prepareQueryCpu("failuremonitor", period)
        prepareQueryCpu("fidelity", period)
        prepareQueryCpu("grafana", period)
        prepareQueryCpu("k6", period)
        prepareQueryCpu("kube-state", period)
        prepareQueryCpu("kube-znn", period)
        prepareQueryCpu("metacontroller", period)
        prepareQueryCpu("nginx", period)
        prepareQueryCpu("prometheus", period)
        prepareQueryCpu("scalability", period)

        prepareQueryMb("failuremanager", period)
        prepareQueryMb("failuremonitor", period)
        prepareQueryMb("fidelity", period)
        prepareQueryMb("grafana", period)
        prepareQueryMb("k6", period)
        prepareQueryMb("kube-state", period)
        prepareQueryMb("kube-znn", period)
        prepareQueryMb("metacontroller", period)
        prepareQueryMb("nginx", period)
        prepareQueryMb("prometheus", period)
        prepareQueryMb("scalability", period)

    except:
        e = sys.exc_info()[0]
        logging.warning("\n\n-----------------------------------------")
        logging.warning("An exception occurred")
        logging.warning( "Error: %s" % e )
        print("An exception occurred")
        logging.warning("\n\n-----------------------------------------")
         
    finally:
        logging.warning("\n\n-----------------------------------------")
        logging.warning("Generating logs - usage of CPU and Memory.")

        dtEvent = datetime.datetime.now()
        finalTime = dtEvent.strftime("%Y%m%d_%H%M%S")
        logging.warning("Datetime:")
        logging.warning(finalTime)

        logging.warning("Finished stream.")
        logging.warning("\n\n-----------------------------------------")            


if __name__ == '__main__':
    main()

"""
https://github.com/wuestkamp/k8s-example-resource-monitoring


cpu
# container usage
rate(container_cpu_usage_seconds_total{pod=~"failuremanager.*", image!="", container!="POD"}[5m])
rate(container_cpu_usage_seconds_total{pod=~"failuremonitor.*", image!="", container!="POD"}[5m])
rate(container_cpu_usage_seconds_total{pod=~"fidelity.*", image!="", container!="POD"}[5m])
rate(container_cpu_usage_seconds_total{pod=~"grafana.*", image!="", container!="POD"}[5m])
rate(container_cpu_usage_seconds_total{pod=~"k6.*", image!="", container!="POD"}[5m])
rate(container_cpu_usage_seconds_total{pod=~"kube-state.*", image!="", container!="POD"}[5m])
rate(container_cpu_usage_seconds_total{pod=~"kube-znn.*", image!="", container!="POD"}[5m])
rate(container_cpu_usage_seconds_total{pod=~"metacontroller.*", image!="", container!="POD"}[5m])
rate(container_cpu_usage_seconds_total{pod=~"nginx.*", image!="", container!="POD"}[5m])
rate(container_cpu_usage_seconds_total{pod=~"prometheus.*", image!="", container!="POD"}[5m])
rate(container_cpu_usage_seconds_total{pod=~"scalability.*", image!="", container!="POD"}[5m])


memory
# container usage
rate(container_memory_working_set_bytes{pod=~"failuremanager.*", image!="", container!="POD"}[15m])
rate(container_memory_working_set_bytes{pod=~"failuremonitor.*", image!="", container!="POD"}[15m])
rate(container_memory_working_set_bytes{pod=~"fidelity.*", image!="", container!="POD"}[15m])
rate(container_memory_working_set_bytes{pod=~"grafana.*", image!="", container!="POD"}[15m])
rate(container_memory_working_set_bytes{pod=~"k6.*", image!="", container!="POD"}[15m])
rate(container_memory_working_set_bytes{pod=~"kube-state.*", image!="", container!="POD"}[15m])
rate(container_memory_working_set_bytes{pod=~"kube-znn.*", image!="", container!="POD"}[15m])
rate(container_memory_working_set_bytes{pod=~"metacontroller.*", image!="", container!="POD"}[15m])
rate(container_memory_working_set_bytes{pod=~"nginx.*", image!="", container!="POD"}[15m])
rate(container_memory_working_set_bytes{pod=~"prometheus.*", image!="", container!="POD"}[15m])
rate(container_memory_working_set_bytes{pod=~"scalability.*", image!="", container!="POD"}[15m])



"""