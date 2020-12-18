module kubow.strategies;
import model "KubeZnnSystem:Acme" { KubeZnnSystem as M, KubernetesFam as K };

define boolean removeInconsistency = M.scalabilityaD.desiredReplicas > 1 || M.scalabilitybD.desiredReplicas > 1 || M.fidelityaD.desiredReplicas > 1 || M.fidelitybD.desiredReplicas > 1;

tactic activateLowScalabilityHighQuality(){
  int futureReplicasScalabilityb = M.scalabilitybD.desiredReplicas + 1;
  int futureReplicasFidelitya = M.fidelityaD.desiredReplicas + 1;
  condition {
    (M.scalabilitybD.desiredReplicas == 0) || (M.fidelityaD.desiredReplicas == 0);
  }
  action {
    if(M.scalabilitybD.desiredReplicas == 0){
      M.scaleUp(M.scalabilitybD, 1);
    }
    if(M.scalabilityaD.desiredReplicas > 0){
      M.scaleDown(M.scalabilityaD, 1);
    }
    if(M.fidelityaD.desiredReplicas == 0){
      M.scaleUp(M.fidelityaD, 1);
    }
    if(M.fidelitybD.desiredReplicas > 0){
      M.scaleDown(M.fidelitybD, 1);    
    }
  }
  effect @[10000]{
    ((futureReplicasScalabilityb == M.scalabilitybD.desiredReplicas) || (futureReplicasFidelitya == M.fidelityaD.desiredReplicas));
  }
}

tactic addLowScalabilityLowQuality() {
  int futureReplicasScalabilityb = M.scalabilitybD.desiredReplicas + 1;
  int futureReplicasFidelityb = M.fidelitybD.desiredReplicas + 1;
  condition {
    (M.scalabilitybD.desiredReplicas == 0 || M.fidelitybD.desiredReplicas == 0);
  }
  action {
    if(M.scalabilitybD.desiredReplicas == 0){
      M.scaleUp(M.scalabilitybD, 1);
    }
    if(M.scalabilityaD.desiredReplicas > 0){
      M.scaleDown(M.scalabilityaD, 1);
    }
    if(M.fidelitybD.desiredReplicas == 0){
      M.scaleUp(M.fidelitybD, 1);
    }
    if(M.fidelityaD.desiredReplicas > 0){
      M.scaleDown(M.fidelityaD, 1);    
    }
  }
  effect @[10000]{
    ((futureReplicasScalabilityb == M.scalabilitybD.desiredReplicas) || (futureReplicasFidelityb == M.fidelitybD.desiredReplicas));
  }
}

tactic addHighScalabilityHighQuality() {
  int futureReplicasScalabilitya = M.scalabilityaD.desiredReplicas + 1;
  int futureReplicasFidelitya = M.fidelityaD.desiredReplicas + 1;
  condition {
    (M.scalabilityaD.desiredReplicas == 0 || M.fidelityaD.desiredReplicas == 0);
  }
  action {
    if(M.scalabilityaD.desiredReplicas == 0){
      M.scaleUp(M.scalabilityaD, 1);
    }
    if(M.scalabilitybD.desiredReplicas > 0){
      M.scaleDown(M.scalabilitybD, 1);
    }
    if(M.fidelityaD.desiredReplicas == 0){
      M.scaleUp(M.fidelityaD, 1);
    }
    if(M.fidelitybD.desiredReplicas > 0){
      M.scaleDown(M.fidelitybD, 1);    
    }
  }
  effect @[10000]{
    (futureReplicasScalabilitya == M.scalabilityaD.desiredReplicas || futureReplicasFidelitya == M.fidelityaD.desiredReplicas);
  }
}