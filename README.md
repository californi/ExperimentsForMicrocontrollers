# For all scenarios (IMPORTANT: ORDER IS CRUCIAL)

## Cluster configurations - defining cluster (before of all, kubectl and minikube must be installed)

minikube start --cpus=5 --vm-driver hyperv --hyperv-virtual-switch "Primary Virtual Switch" --kubernetes-version=v1.16.10
minikube addons enable ingress

#---------------------------------------------------
## creating environment
kubectl apply -k .\tools\monitoring\
kubectl apply -k .\TargetSystem\kube-znn\overlay\default\
kubectl apply -f .\tools\nginxc-ingress\

## Evaluation
kubectl apply -k .\Evaluation\VersionA-Monolithic\kubow\overlay\kube-znn

kubectl apply -k .\Evaluation\VersionB-Microcontrollers\fidelitya_microcontroller\kubow\overlay\kube-znn\
kubectl apply -k .\Evaluation\VersionB-Microcontrollers\scalabilitya_microcontroller\kubow\overlay\kube-znn\

kubectl apply -k .\Evaluation\VersionC-WithFailureManagerMetaController\MicroControllers\kubow_based\fidelitya_microcontroller\kubow\overlay\kube-znn\
kubectl apply -k .\Evaluation\VersionC-WithFailureManagerMetaController\MicroControllers\kubow_based\scalabilitya_microcontroller\kubow\overlay\kube-znn\
kubectl apply -k .\Evaluation\VersionC-WithFailureManagerMetaController\MicroControllers\kubow_based\fidelityb_microcontroller\kubow\overlay\kube-znn\
kubectl apply -k .\Evaluation\VersionC-WithFailureManagerMetaController\MicroControllers\kubow_based\scalabilityb_microcontroller\kubow\overlay\kube-znn\
kubectl apply -f .\Evaluation\VersionC-WithFailureManagerMetaController\MicroControllers\tailored_based\k8s\
kubectl apply -k .\Evaluation\VersionC-WithFailureManagerMetaController\MetaController\kubow\overlay\controller_targetsystem\

## Testing number of requests for kube-znn
kubectl apply -k .\tools\k6\


#---------------------------------------------------
## Cleaning environment
kubectl delete -k .\tools\monitoring\
kubectl delete -k .\TargetSystem\kube-znn\overlay\default\
kubectl delete -f .\tools\nginxc-ingress\


## Evaluation
kubectl delete -k .\Evaluation\VersionA-Monolithic\kubow\overlay\kube-znn


kubectl delete -k .\Evaluation\VersionB-Microcontrollers\fidelitya_microcontroller\kubow\overlay\kube-znn\
kubectl delete -k .\Evaluation\VersionB-Microcontrollers\scalabilitya_microcontroller\kubow\overlay\kube-znn\


kubectl delete -k .\Evaluation\VersionC-WithFailureManagerMetaController\MicroControllers\kubow_based\fidelitya_microcontroller\kubow\overlay\kube-znn\
kubectl delete -k .\Evaluation\VersionC-WithFailureManagerMetaController\MicroControllers\kubow_based\scalabilitya_microcontroller\kubow\overlay\kube-znn\
kubectl delete -k .\Evaluation\VersionC-WithFailureManagerMetaController\MicroControllers\kubow_based\fidelityb_microcontroller\kubow\overlay\kube-znn\
kubectl delete -k .\Evaluation\VersionC-WithFailureManagerMetaController\MicroControllers\kubow_based\scalabilityb_microcontroller\kubow\overlay\kube-znn\
kubectl delete -f .\Evaluation\VersionC-WithFailureManagerMetaController\MicroControllers\tailored_based\k8s\
kubectl delete -k .\Evaluation\VersionC-WithFailureManagerMetaController\MetaController\kubow\overlay\controller_targetsystem\


## Testing number of requests for kube-znn
kubectl delete -k .\tools\k6\

#---------------------------------------------------

## Generating logs
kubectl logs pod/kubow-5688b4798c-2z7jq >> kubowCA.log

## Monitoring
while (1) {clear; kubectl get all; sleep 5}
while (1) {clear; kubectl describe deployment kube-znn; sleep 5}

### query prometheus in K8s
kubectl port-forward pod/prometheus-d4499d495-5hb44 9090:9090

### Grafana
kubectl port-forward pod/grafana-b659fcdd9-r5sck 3000:3000

#---------------------------------------------------