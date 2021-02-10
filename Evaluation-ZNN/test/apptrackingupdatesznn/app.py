from kubernetes import client, config, watch
import logging
import re
import datetime
import time
import sys

dtEvent = datetime.datetime.now()
initialTime = dtEvent.strftime("%Y%m%d_%H%M%S")

def writeLogsFromPod(podname, content):
    file = podname + "_tracing_" + initialTime + ".log"
    f = open(file, "a", encoding="utf-8")
    f.write(content)
    f.close()
    return file

def main():
    period = 0
    initial_replicas = None
    initial_image = None
    initialTime = None
    dataCollection = None
    current_replicas = None
    current_image = None
    replicasChanges = 0
    imageChanges = 0
    dtEvent = None
    finalTime = None

    config.load_kube_config()
    # config.load_incluster_config
    core = client.CoreV1Api()
    apps = client.AppsV1Api()
    w = watch.Watch()

    try:
        period = input("Enter a period in minutes: ")
        minutes = int(period)
        # taking into account the period of analysis
        minutes_added = datetime.timedelta(minutes=minutes * 2)
                
        dtEvent = datetime.datetime.now()
        dtLimit = dtEvent + minutes_added
        initialTime = dtEvent.strftime("%Y%m%d_%H%M%S")
        file = "traceznn_" + initialTime + ".log"
        logging.basicConfig(filename=file, filemode='w',
                            format='%(name)s - %(levelname)s - %(message)s')
        logging.warning('Starting our experiment execution')



        

        initial_deployment = apps.read_namespaced_deployment(
            "kube-znn", "default")
        initial_replicas = initial_deployment.spec.replicas
        initial_image = initial_deployment.spec.template.spec.containers[0].image
        current_image = initial_image

        

        dataCollection = {"name": "Kube-znn",
                          "period": period,
                          "initialreplicas": initial_replicas,
                          "initialimage": initial_image,
                          "initialreplicasChanges": "0",
                          "initialimageChanges": "0",
                          "initialevent": initialTime}
        replicasChanges = 0
        imageChanges = 0

        
        for event in w.stream(core.list_event_for_all_namespaces, _request_timeout=60*minutes*2):

            event = {"name": event['object'].metadata.name,
                     "type": event['object'].type,
                     "message": event['object'].message,
                     "dateevent": str(event['object'].metadata.creation_timestamp)}
            
            resultNamePod = re.search(
                'kube-znn', str(event["name"]), re.IGNORECASE)
            scaleMessage = re.search(
                'scale', str(event["message"]), re.IGNORECASE)


            podFidelitya = re.search(
                'fidelitya', str(event["name"]), re.IGNORECASE)         
            podFidelityb = re.search(
                'fidelityb', str(event["name"]), re.IGNORECASE)     
            podScalabilitya = re.search(
                'scalabilitya', str(event["name"]), re.IGNORECASE)     
            podScalabilityb = re.search(
                'scalabilityb', str(event["name"]), re.IGNORECASE)   

            logging.warning("\n\n-----------------------------------------")
            logging.warning("General Log - ")
            logging.warning(event)
            print("General Log - ")
            print(event)
            logging.warning("\n\n-----------------------------------------")
            

            if resultNamePod and scaleMessage:
                current_deployment = apps.read_namespaced_deployment(
                    "kube-znn", "default")
                # Nao ta validado ainda
                if current_image != current_deployment.spec.template.spec.containers[0].image:
                    imageChanges = imageChanges + 1

                if current_replicas != current_deployment.spec.replicas:
                    replicasChanges = replicasChanges + 1

                current_image = current_deployment.spec.template.spec.containers[0].image
                current_replicas = current_deployment.spec.replicas
                event["image"] = current_image
                event["replicas"] = current_replicas
                event["imageChanges"] = imageChanges
                event["replicasChanges"] = replicasChanges

                logging.warning("\n\n-----------------------------------------")
                logging.warning("\n\nCaptured event for znn: ")
                logging.warning(event)
                print("\n\nCaptured event for znn: ")
                print(event)
                logging.warning("\n\n-----------------------------------------")
            
            if scaleMessage and podFidelitya or podFidelityb or podScalabilitya or podScalabilityb:
                logging.warning("\n\n-----------------------------------------")
                logging.warning("\n\nCaptured event for Metacontroller and microcontrollers: ")
                logging.warning("\n\n MetaController has adapted the microcontrollers.")
                print(event)
                logging.warning(event)
                logging.warning("\n\n-----------------------------------------")


            if datetime.datetime.now() > dtLimit:
                w.stop() 

        dtEvent = datetime.datetime.now()
        finalTime = dtEvent.strftime("%Y%m%d_%H%M%S")
        dataCollection["current_replicas"] = current_replicas
        dataCollection["current_image"] = current_image
        dataCollection["finalreplicasChanges"] = replicasChanges
        dataCollection["finalimageChanges"] = imageChanges
        dataCollection["finalevent"] = finalTime


        print("\n\nData collection")        
        logging.warning("\n\n-----------------------------------------")
        logging.warning("\n\nData collection")
        logging.warning("Datetime:")
        logging.warning(finalTime)
        print(dataCollection)
        logging.warning(dataCollection)
        logging.warning("\n\n-----------------------------------------")

    except:
        e = sys.exc_info()[0]
        logging.warning("\n\n-----------------------------------------")
        logging.warning("An exception occurred")
        logging.warning( "Error: %s" % e )
        print("An exception occurred")
        logging.warning("\n\n-----------------------------------------")
        
        logging.warning("\n\nData collection")
        dtEvent = datetime.datetime.now()
        finalTime = dtEvent.strftime("%Y%m%d_%H%M%S")
        logging.warning("Datetime:")
        logging.warning(finalTime)
        dataCollection["current_replicas"] = current_replicas
        dataCollection["current_image"] = current_image
        dataCollection["finalreplicasChanges"] = replicasChanges
        dataCollection["finalimageChanges"] = imageChanges
        dataCollection["finalevent"] = finalTime
        logging.warning(dataCollection)
        logging.warning("\n\n-----------------------------------------")

    finally:
        logging.warning("\n\n-----------------------------------------")
        logging.warning("Generating logs for Kubow and K6.")
        ret = core.list_pod_for_all_namespaces(watch=False)
        for i in ret.items:

            podMetacontroller = re.search(
                'metacontroller', str(i.metadata.name), re.IGNORECASE)
            podKubow = re.search(
                'kubow', str(i.metadata.name), re.IGNORECASE)
            podFidelitya = re.search(
                'fidelitya', str(i.metadata.name), re.IGNORECASE)         
            podFidelityb = re.search(
                'fidelityb', str(i.metadata.name), re.IGNORECASE)     
            podScalabilitya = re.search(
                'scalabilitya', str(i.metadata.name), re.IGNORECASE)     
            podScalabilityb = re.search(
                'scalabilityb', str(i.metadata.name), re.IGNORECASE)                                                            
            podK6 = re.search(
                'k6', str(i.metadata.name), re.IGNORECASE)

            if podKubow or podK6 or podFidelitya or podFidelityb or podScalabilitya or podScalabilityb or podMetacontroller:
                logs = core.read_namespaced_pod_log(i.metadata.name,i.metadata.namespace)
                file = writeLogsFromPod(i.metadata.name,str(logs))
                logging.warning("File " + file + "has been generated.")


        logging.warning("Finished pod stream.")
        logging.warning("\n\n-----------------------------------------")


if __name__ == '__main__':
    main()
