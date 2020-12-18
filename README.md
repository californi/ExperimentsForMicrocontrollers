# For all scenarios

## Cluster configurations - defining cluster

minikube start --cpus=5 --vm-driver hyperv --hyperv-virtual-switch "Primary Virtual Switch" --kubernetes-version=v1.16.10
minikube addons enable ingress


# Deploying 1 - Tools
## Monitoring
kubectl apply -k .\tools\monitoring\
## Target system
kubectl apply -k .\TargetSystem\kube-znn\overlay\default\

# --------------------------------------------------------
# For Evaluation One
# --------------------------------------------------------
# Deploying 2 - Monolithic-VersionA
## Monolithic-VersionA - nginxc and Controller
kubectl apply -f .\tools\nginxc-ingress\
kubectl apply -k .\EvaluationOne\Monolithic-VersionA\kubow\overlay\kube-znn

# Deploying 3 - nginxc and MicroControllers
## MicroControllers-VersionB - nginxc and MicroControllers
kubectl apply -f .\tools\nginxc-ingress\
kubectl apply -k .\EvaluationOne\Microcontrollers-VersionB\fidelitya_microcontroller\kubow\overlay\kube-znn\
kubectl apply -k .\EvaluationOne\Microcontrollers-VersionB\scalabilitya_microcontroller\kubow\overlay\kube-znn\


# --------------------------------------------------------
# For Evaluation Two
# --------------------------------------------------------
# Deploying 2 - nginxc and MicroControllers
## OnlyMicroControllers-VersionA - nginxc and MicroControllers
kubectl apply -f .\tools\nginxc-ingress\
kubectl apply -k .\EvaluationTwo\OnlyMicroControllers-VersionA\fidelitya_microcontroller\kubow\overlay\kube-znn\
kubectl apply -k .\EvaluationTwo\OnlyMicroControllers-VersionA\scalabilitya_microcontroller\kubow\overlay\kube-znn\

# Deploying 3 - nginxc and MicroControllers
## WithFailureManagerMetaController-VersionB - MetaControllers; MicroControllers and FailureManager
kubectl apply -k .\EvaluationTwo\WithFailureManagerMetaController-VersionB\MicroControllers\fidelitya_microcontroller\kubow\overlay\kube-znn\
kubectl apply -k .\EvaluationTwo\WithFailureManagerMetaController-VersionB\MicroControllers\scalabilitya_microcontroller\kubow\overlay\kube-znn\
kubectl apply -k .\EvaluationTwo\WithFailureManagerMetaController-VersionB\MicroControllers\fidelityb_microcontroller\kubow\overlay\kube-znn\
kubectl apply -k .\EvaluationTwo\WithFailureManagerMetaController-VersionB\MicroControllers\scalabilityb_microcontroller\kubow\overlay\kube-znn\

# Deploying 4 - MicroController Failure Manager 
## MicroController Failure Manager 
kubectl apply -f .\EvaluationTwo\WithFailureManagerMetaController-VersionB\MicroControllers\tailored_based\k8s\
kubectl apply -f .\tools\nginxc-ingress\

## Kubow-based - MetaController
kubectl apply -k .\EvaluationTwo\WithFailureManagerMetaController-VersionB\MetaController\overlay\controller_targetsystem\


# --------------------------------------------------------
## Testing and Analsys
kubectl apply -k .\Testing\k6\

## Generating logs
kubectl logs pod/metacontroller-kubow-7d87f75854-ccxf6 >> metacontrol.log

## Monitoring
while (1) {clear; kubectl get all; sleep 5}
while (1) {clear; kubectl describe deployment kube-znn; sleep 5}

### query prometheus in K8s
kubectl port-forward pod/prometheus-d4499d495-8c2nf 9090:9090

### Grafana
kubectl port-forward pod/grafana-b659fcdd9-8r9h5 3000:3000