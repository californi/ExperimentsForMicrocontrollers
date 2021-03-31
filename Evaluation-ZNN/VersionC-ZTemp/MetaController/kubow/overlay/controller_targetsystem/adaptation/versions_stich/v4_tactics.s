
module kubow.strategies;
import model "KubeZnnSystem:Acme" { KubeZnnSystem as M, KubernetesFam as K };

define boolean NoFailureRate = M.failureManagerS.cpufailure == 0.0;
define boolean LowFailureRate = M.failureManagerS.cpufailure > 0.0 && M.failureManagerS.cpufailure <= 0.5;
define boolean HighFailureRate = M.failureManagerS.cpufailure > 0.5;

define boolean canAddScalabilityb = M.scalabilitybMcKubowD.desiredReplicas < 1;
define boolean canAddFidelityb = M.fidelitybMcKubowD.desiredReplicas < 1;
define boolean canRemoveScalabilityb = M.scalabilitybMcKubowD.desiredReplicas > 0;
define boolean canRemoveFidelityb = M.fidelitybMcKubowD.desiredReplicas > 0;

define boolean canAddScalabilitya = M.scalabilityaMcKubowD.desiredReplicas < 1;
define boolean canAddFidelitya = M.fidelityaMcKubowD.desiredReplicas < 1;
define boolean canRemoveScalabilitya = M.scalabilityaMcKubowD.desiredReplicas > 0;
define boolean canRemoveFidelitya = M.fidelityaMcKubowD.desiredReplicas > 0;

tatic activateHighScalabilityHighQuality(){
  condition{
    canAddScalabilitya && canAddFidelitya;
  }
  action{
    if(canRemoveScalabilityb){
      M.scaleDown(M.scalabilitybMcKubowD, 1);
    }
    if(canRemoveFidelityb){
      M.scaleDown(M.fidelitybMcKubowD, 1);
    }
    if(canAddScalabilitya){
      M.scaleUp(M.scalabilityaMcKubowD, 1);
    }
    if(canAddFidelitya){
      M.scaleUp(M.fidelityaMcKubowD, 1);
    }
  }
  effect @[1500]{
    !canAddScalabilitya && canAddFidelitya;
  }
}

tatic activateLowScalabilityHighQuality(){
  condition {
    canAddScalabilityb && canAddFidelitya;
  }
  action {
    if(canRemoveScalabilitya){
      M.scaleDown(M.scalabilityaMcKubowD, 1);
    }
    if(canRemoveFidelityb){
      M.scaleDown(M.fidelitybMcKubowD, 1);
    }
    if(canAddScalabilityb){
      M.scaleUp(M.scalabilitybMcKubowD, 1);
    }
    if(canAddFidelitya){
      M.scaleUp(M.fidelityaMcKubowD, 1);
    }
  }
  effect @[1500] {
    !canAddScalabilityb && canAddFidelitya;
  }
}

tatic activateLowScalabilityLowQuality(){
  condition {
    canAddScalabilityb && canAddFidelityb;
  }
  action {
    if(canRemoveScalabilitya){
      M.scaleDown(M.scalabilityaMcKubowD, 1);
    }
    if(canRemoveFidelitya){
      M.scaleDown(M.fidelityaMcKubowD, 1);
    }
    if(canAddScalabilityb){
      M.scaleUp(M.scalabilitybMcKubowD, 1);
    }
    if(canAddFidelityb){
      M.scaleUp(M.fidelitybMcKubowD, 1);
    }
  }
  effect @[1500] {
    !canAddScalabilityb && canAddFidelityb;
  }
}