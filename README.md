# For all scenarios (IMPORTANT: ORDER IS CRUCIAL)

## Cluster configurations - defining cluster (before of all, kubectl and minikube must be installed)

minikube start --cpus=5 --vm-driver hyperv --hyperv-virtual-switch "Primary Virtual Switch" --kubernetes-version=v1.16.10
minikube addons enable ingress


# Deploying - Tools (demanding)
## Monitoring and Target system
kubectl apply -k .\tools\monitoring\
kubectl apply -k .\TargetSystem\kube-znn\overlay\default\

# --------------------------------------------------------
# For Evaluation One
# --------------------------------------------------------
# Scenario 1 - Monolithic-VersionA
## Monolithic-VersionA - nginxc and Controller
kubectl apply -f .\tools\nginxc-ingress\
kubectl apply -k .\EvaluationOne\Monolithic-VersionA\kubow\overlay\kube-znn

# Scenario 2 - nginxc and MicroControllers
## MicroControllers-VersionB - nginxc and MicroControllers
kubectl apply -f .\tools\nginxc-ingress\
kubectl apply -k .\EvaluationOne\Microcontrollers-VersionB\fidelitya_microcontroller\kubow\overlay\kube-znn\
kubectl apply -k .\EvaluationOne\Microcontrollers-VersionB\scalabilitya_microcontroller\kubow\overlay\kube-znn\


# --------------------------------------------------------
# For Evaluation Two
# --------------------------------------------------------
# Scenario 3 - nginxc and MicroControllers
## OnlyMicroControllers-VersionA - nginxc and MicroControllers
kubectl apply -f .\tools\nginxc-ingress\
kubectl apply -k .\EvaluationTwo\OnlyMicroControllers-VersionA\fidelitya_microcontroller\kubow\overlay\kube-znn\
kubectl apply -k .\EvaluationTwo\OnlyMicroControllers-VersionA\scalabilitya_microcontroller\kubow\overlay\kube-znn\

# Scenario 4 - nginxc and MicroControllers
## WithFailureManagerMetaController-VersionB - MetaControllers; MicroControllers and FailureManager
## MicroController Failure Manager 
kubectl apply -f .\EvaluationTwo\WithFailureManagerMetaController-VersionB\MicroControllers\tailored_based\k8s\
kubectl apply -f .\tools\nginxc-ingress\
kubectl apply -k .\EvaluationTwo\WithFailureManagerMetaController-VersionB\MicroControllers\kubow_based\fidelitya_microcontroller\kubow\overlay\kube-znn\
kubectl apply -k .\EvaluationTwo\WithFailureManagerMetaController-VersionB\MicroControllers\kubow_based\scalabilitya_microcontroller\kubow\overlay\kube-znn\
kubectl apply -k .\EvaluationTwo\WithFailureManagerMetaController-VersionB\MicroControllers\kubow_based\fidelityb_microcontroller\kubow\overlay\kube-znn\
kubectl apply -k .\EvaluationTwo\WithFailureManagerMetaController-VersionB\MicroControllers\kubow_based\scalabilityb_microcontroller\kubow\overlay\kube-znn\


## Kubow-based - MetaController
kubectl apply -k .\EvaluationTwo\WithFailureManagerMetaController-VersionB\MetaController\kubow\overlay\controller_targetsystem\


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

#---------------------------------------------------
## Cleaning environment
kubectl delete -k .\tools\monitoring\
kubectl delete -k .\TargetSystem\kube-znn\overlay\default\
kubectl delete -f .\tools\nginxc-ingress\
kubectl delete -k .\EvaluationOne\Monolithic-VersionA\kubow\overlay\kube-znn
kubectl delete -k .\EvaluationOne\Microcontrollers-VersionB\fidelitya_microcontroller\kubow\overlay\kube-znn\
kubectl delete -k .\EvaluationOne\Microcontrollers-VersionB\scalabilitya_microcontroller\kubow\overlay\kube-znn\
kubectl delete -k .\EvaluationTwo\OnlyMicroControllers-VersionA\fidelitya_microcontroller\kubow\overlay\kube-znn\
kubectl delete -k .\EvaluationTwo\OnlyMicroControllers-VersionA\scalabilitya_microcontroller\kubow\overlay\kube-znn\
kubectl delete -k .\EvaluationTwo\WithFailureManagerMetaController-VersionB\MicroControllers\kubow_based\fidelitya_microcontroller\kubow\overlay\kube-znn\
kubectl delete -k .\EvaluationTwo\WithFailureManagerMetaController-VersionB\MicroControllers\kubow_based\scalabilitya_microcontroller\kubow\overlay\kube-znn\
kubectl delete -k .\EvaluationTwo\WithFailureManagerMetaController-VersionB\MicroControllers\kubow_based\fidelityb_microcontroller\kubow\overlay\kube-znn\
kubectl delete -k .\EvaluationTwo\WithFailureManagerMetaController-VersionB\MicroControllers\kubow_based\scalabilityb_microcontroller\kubow\overlay\kube-znn\

kubectl delete -f .\EvaluationTwo\WithFailureManagerMetaController-VersionB\MicroControllers\tailored_based\k8s\
kubectl delete -k .\EvaluationTwo\WithFailureManagerMetaController-VersionB\MetaController\kubow\overlay\controller_targetsystem\
kubectl delete -k .\Testing\k6\