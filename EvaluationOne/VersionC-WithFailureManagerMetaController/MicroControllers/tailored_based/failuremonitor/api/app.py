from kubernetes import client, config, watch
import logging
from pydantic import BaseModel
import httpx
import re

url_host = 'http://failuremanager:5002'
headers = {'Content-Type': 'application/json',
           'Authorization': 'Bearer {}'.format('bWljcm9jb250cm9sbGVycw==')}


def main():

    config.load_incluster_config()
    v1 = client.CoreV1Api()
    w = watch.Watch()

    for event in w.stream(v1.list_event_for_all_namespaces):
        if event['object'].type == "Warning":

            failure = {"name": event['object'].metadata.name,
                       "type": event['object'].type,
                       "message": event['object'].message,
                       "dateevent": str(event['object'].metadata.creation_timestamp)}

            resultNamePod = re.search(
                'kube-znn', str(failure["name"]), re.IGNORECASE)
            resultMessageCPU = re.search(
                'Insufficient cpu', str(failure["message"]), re.IGNORECASE)

            if resultNamePod and resultMessageCPU:
                print("falha encontrada")
                logging.warning(failure)
                response = httpx.post(f"{url_host}/insufficientcpu",
                                      headers=headers,
                                      json=failure)

    logging.info("Finished pod stream.")


if __name__ == '__main__':
    main()
