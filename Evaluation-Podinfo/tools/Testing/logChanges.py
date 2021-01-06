from kubernetes import client, config, watch
import logging
import re


def main():

    config.load_kube_config()
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

            logging.warning(event)

    logging.info("Finished pod stream.")


if __name__ == '__main__':
    main()
