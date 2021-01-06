# For all scenarios (IMPORTANT: ORDER IS CRUCIAL)

## Cluster configurations - defining cluster (before of all, kubectl and minikube must be installed)

minikube delete
minikube start --cpus=5 --vm-driver hyperv --hyperv-virtual-switch "Primary Virtual Switch" --kubernetes-version=v1.16.10
minikube addons enable ingress

#---------------------------------------------------#---------------------------------------------------
## creating environment: Configuration A - Always - delete and re-create the Cluster
kubectl apply -k .\Evaluation-ZNN\tools\monitoring\
kubectl apply -k .\Evaluation-ZNN\VersionA-Monolithic\TargetSystem\kube-znn\overlay\default\
kubectl apply -f .\Evaluation-ZNN\tools\nginxc-ingress\
kubectl apply -k .\Evaluation-ZNN\VersionA-Monolithic\kubow\overlay\kube-znn
kubectl apply -k .\Evaluation-ZNN\tools\k6\

kubectl delete -k .\Evaluation-ZNN\tools\monitoring\
kubectl delete -k .\Evaluation-ZNN\VersionA-Monolithic\TargetSystem\kube-znn\overlay\default\
kubectl delete -f .\Evaluation-ZNN\tools\nginxc-ingress\
kubectl delete -k .\Evaluation-ZNN\VersionA-Monolithic\kubow\overlay\kube-znn
kubectl delete -k .\Evaluation-ZNN\tools\k6\
#---------------------------------------------------#---------------------------------------------------
## creating environment: Configuration B - Always - delete and re-create the Cluster
kubectl apply -k .\tools\monitoring\
kubectl apply -k .\Evaluation\VersionB-Microcontrollers\TargetSystem\kube-znn\overlay\default\
kubectl apply -f .\tools\nginxc-ingress\
kubectl apply -k .\Evaluation\VersionB-Microcontrollers\fidelitya_microcontroller\kubow\overlay\kube-znn\
kubectl apply -k .\Evaluation\VersionB-Microcontrollers\scalabilitya_microcontroller\kubow\overlay\kube-znn\
kubectl apply -k .\tools\k6\

kubectl delete -k .\tools\monitoring\
kubectl delete -k .\Evaluation\Evaluation\VersionB-Microcontrollers\TargetSystem\kube-znn\overlay\default\
kubectl delete -f .\tools\nginxc-ingress\
kubectl delete -k .\Evaluation\VersionB-Microcontrollers\fidelitya_microcontroller\kubow\overlay\kube-znn\
kubectl delete -k .\Evaluation\VersionB-Microcontrollers\scalabilitya_microcontroller\kubow\overlay\kube-znn\
kubectl delete -k .\tools\k6\

#---------------------------------------------------#---------------------------------------------------
## creating environment: Configuration C - Always - delete and re-create the Cluster
kubectl apply -k .\tools\monitoring\
kubectl apply -k .\Evaluation\Evaluation\VersionC-WithFailureManagerMetaController\TargetSystem\kube-znn\overlay\default\
kubectl apply -f .\tools\nginxc-ingress\
kubectl apply -k .\Evaluation\VersionC-WithFailureManagerMetaController\MicroControllers\kubow_based\fidelitya_microcontroller\kubow\overlay\kube-znn\
kubectl apply -k .\Evaluation\VersionC-WithFailureManagerMetaController\MicroControllers\kubow_based\scalabilitya_microcontroller\kubow\overlay\kube-znn\
kubectl apply -k .\Evaluation\VersionC-WithFailureManagerMetaController\MicroControllers\kubow_based\fidelityb_microcontroller\kubow\overlay\kube-znn\
kubectl apply -k .\Evaluation\VersionC-WithFailureManagerMetaController\MicroControllers\kubow_based\scalabilityb_microcontroller\kubow\overlay\kube-znn\
kubectl apply -f .\Evaluation\VersionC-WithFailureManagerMetaController\MicroControllers\tailored_based\k8s\
kubectl apply -k .\Evaluation\VersionC-WithFailureManagerMetaController\MetaController\kubow\overlay\controller_targetsystem\
kubectl apply -k .\tools\k6\


kubectl delete -k .\tools\monitoring\
kubectl delete -k .\Evaluation\Evaluation\VersionC-WithFailureManagerMetaController\TargetSystem\kube-znn\overlay\default\
kubectl delete -f .\tools\nginxc-ingress\
kubectl delete -k .\Evaluation\VersionC-WithFailureManagerMetaController\MicroControllers\kubow_based\fidelitya_microcontroller\kubow\overlay\kube-znn\
kubectl delete -k .\Evaluation\VersionC-WithFailureManagerMetaController\MicroControllers\kubow_based\scalabilitya_microcontroller\kubow\overlay\kube-znn\
kubectl delete -k .\Evaluation\VersionC-WithFailureManagerMetaController\MicroControllers\kubow_based\fidelityb_microcontroller\kubow\overlay\kube-znn\
kubectl delete -k .\Evaluation\VersionC-WithFailureManagerMetaController\MicroControllers\kubow_based\scalabilityb_microcontroller\kubow\overlay\kube-znn\
kubectl delete -f .\Evaluation\VersionC-WithFailureManagerMetaController\MicroControllers\tailored_based\k8s\
kubectl delete -k .\Evaluation\VersionC-WithFailureManagerMetaController\MetaController\kubow\overlay\controller_targetsystem\
kubectl delete -k .\tools\k6\


#---------------------------------------------------#---------------------------------------------------

## Generating logs
kubectl logs pod/kubow-576fdfb5c6-bmngf >> kubowCA.log

## Monitoring
while (1) {clear; kubectl get all; sleep 5}
while (1) {clear; kubectl describe deployment kube-znn; sleep 5}

### query prometheus in K8s
kubectl port-forward pod/prometheus-d4499d495-gxw4q 9090:9090

### Grafana
kubectl port-forward pod/grafana-b659fcdd9-r5sck 3000:3000

#---------------------------------------------------