# podinfo

Podinfo is a tiny web application made with Go that showcases best practices of running microservices in Kubernetes. The source code is available [here](https://github.com/stefanprodan/podinfo).

## Run the app in Kubernetes


Apply the deployment and service.

kubectl apply -f .\Evaluation-Podinfo\manifests\podinfoTargetSystem\deployment.yaml
kubectl apply -f .\Evaluation-Podinfo\manifests\podinfoTargetSystem\service.yaml

kubectl apply -k .\Evaluation-Podinfo\manifests\overlay\podinfo\
kubectl apply -k .\Evaluation-Podinfo\tools\Testing\k6\

kubectl port-forward svc/podinfo 9898:9898



kubectl delete -f .\Evaluation-Podinfo\manifests\podinfoTargetSystem\deployment.yaml
kubectl delete -f .\Evaluation-Podinfo\manifests\podinfoTargetSystem\service.yaml
