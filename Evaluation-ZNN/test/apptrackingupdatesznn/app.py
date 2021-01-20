from kubernetes import client, config, watch
import logging
import re
import datetime


def main():

    try:
        dtEvent = datetime.datetime.now()
        strTime = dtEvent.strftime("%Y%m%d_%H%M%S")
        file = "trackznn_" + strTime + ".log"
        logging.basicConfig(filename=file, filemode='w',
                            format='%(name)s - %(levelname)s - %(message)s')
        logging.warning('Starting our experiment execution')

        config.load_kube_config()
        # config.load_incluster_config
        core = client.CoreV1Api()
        apps = client.AppsV1Api()
        w = watch.Watch()

        for event in w.stream(core.list_event_for_all_namespaces):

            event = {"name": event['object'].metadata.name,
                     "type": event['object'].type,
                     "message": event['object'].message,
                     "dateevent": str(event['object'].metadata.creation_timestamp)}

            resultNamePod = re.search(
                'kube-znn', str(event["name"]), re.IGNORECASE)
            scaleMessage = re.search(
                'scale', str(event["message"]), re.IGNORECASE)

            if resultNamePod and scaleMessage:
                current_deployment = apps.read_namespaced_deployment(
                    "kube-znn", "default")
                current_image = current_deployment.spec.template.spec.containers[0].image
                event["image"] = current_image

                print(event)
                logging.warning(event)

    except:
        print("An exception occurred")

    logging.info("Finished pod stream.")


if __name__ == '__main__':
    main()
