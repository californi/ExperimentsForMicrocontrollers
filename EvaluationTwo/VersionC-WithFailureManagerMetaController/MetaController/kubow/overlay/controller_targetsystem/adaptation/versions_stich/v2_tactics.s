
module kubow.strategies;
import model "KubeZnnSystem:Acme" { KubeZnnSystem as M, KubernetesFam as K };

define boolean NoFailureRate = M.failureManagerS.cpufailure == 0.0;
define boolean LowFailureRate = M.failureManagerS.cpufailure > 0.0 && M.failureManagerS.cpufailure <= 0.5;
define boolean HighFailureRate = M.failureManagerS.cpufailure > 0.5;

define boolean canAddScalabilityaFidelitya = M.scalabilityaMcKubowD.maxReplicas > M.scalabilityaMcKubowD.desiredReplicas && M.fidelityaMcKubowD.maxReplicas > M.fidelityaMcKubowD.desiredReplicas;

define boolean canAddScalabilityb = M.scalabilitybMcKubowD.desiredReplicas < 1;
define boolean canAddFidelityb = M.fidelitybMcKubowD.desiredReplicas < 1;
define boolean canRemoveScalabilityb = M.scalabilitybMcKubowD.desiredReplicas > 0;
define boolean canRemoveFidelityb = M.fidelitybMcKubowD.desiredReplicas > 0;

define boolean canAddScalabilitybFidelityb = M.scalabilitybMcKubowD.maxReplicas > M.scalabilitybMcKubowD.desiredReplicas && M.fidelitybMcKubowD.maxReplicas > M.fidelitybMcKubowD.desiredReplicas;

define boolean canAddScalabilitya = M.scalabilityaMcKubowD.desiredReplicas < 1;
define boolean canAddFidelitya = M.fidelityaMcKubowD.desiredReplicas < 1;
define boolean canRemoveScalabilitya = M.scalabilityaMcKubowD.desiredReplicas > 0;
define boolean canRemoveFidelitya = M.fidelityaMcKubowD.desiredReplicas > 0;

//Inserção está testada / funcionando....
tactic addScalabilityaFidelitya() {
  condition {
    (NoFailureRate);
  }
  action {
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
  effect {
    (!canRemoveScalabilityb && !canRemoveFidelityb && !canAddScalabilitya && !canAddFidelitya);
  }
}


tactic addScalabilitybFidelityb() {
  condition {
    (HighFailureRate);
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
  effect {
    (!canRemoveScalabilitya && !canRemoveFidelitya && !canAddScalabilityb && !canAddFidelityb);
  }
}



tactic addScalabilitya() {
  int futureReplicas = M.scalabilityaMcKubowD.desiredReplicas + 1;
  condition {
    M.scalabilityaMcKubowD.maxReplicas > M.scalabilityaMcKubowD.desiredReplicas;
  }
  action {
    M.scaleUp(M.scalabilityaMcKubowD, 1);
  }
  effect {
    futureReplicas' == M.scalabilityaMcKubowD.desiredReplicas;
  }
}

tactic removeScalabilitya() {
  int futureReplicas = M.scalabilityaMcKubowD.desiredReplicas - 1;
  condition {
    M.scalabilityaMcKubowD.minReplicas < M.scalabilityaMcKubowD.desiredReplicas;
  }
  action {
    M.scaleDown(M.scalabilityaMcKubowD, 1);
  }
  effect {
    futureReplicas' == M.scalabilityaMcKubowD.desiredReplicas;
  }
}

tactic addScalabilityb() {
  int futureReplicas = M.scalabilitybMcKubowD.desiredReplicas + 1;
  condition {
    M.scalabilitybMcKubowD.maxReplicas > M.scalabilitybMcKubowD.desiredReplicas;
  }
  action {
    M.scaleUp(M.scalabilitybMcKubowD, 1);
  }
  effect {
    futureReplicas' == M.scalabilitybMcKubowD.desiredReplicas;
  }
}

tactic removeScalabilityb() {
  int futureReplicas = M.scalabilitybMcKubowD.desiredReplicas - 1;
  condition {
    M.scalabilitybMcKubowD.minReplicas < M.scalabilitybMcKubowD.desiredReplicas;
  }
  action {
    M.scaleDown(M.scalabilitybMcKubowD, 1);
  }
  effect {
    futureReplicas' == M.scalabilitybMcKubowD.desiredReplicas;
  }
}


tactic addFidelitya() {
  int futureReplicas = M.fidelityaMcKubowD.desiredReplicas + 1;
  condition {
    M.fidelityaMcKubowD.maxReplicas > M.fidelityaMcKubowD.desiredReplicas;
  }
  action {
    M.scaleUp(M.fidelityaMcKubowD, 1);
  }
  effect {
    futureReplicas' == M.fidelityaMcKubowD.desiredReplicas;
  }
}

tactic removeFidelitya() {
  int futureReplicas = M.fidelityaMcKubowD.desiredReplicas - 1;
  condition {
    M.fidelityaMcKubowD.minReplicas < M.fidelityaMcKubowD.desiredReplicas;
  }
  action {
    M.scaleDown(M.fidelityaMcKubowD, 1);
  }
  effect {
    futureReplicas' == M.fidelityaMcKubowD.desiredReplicas;
  }
}

tactic addFidelityb() {
  int futureReplicas = M.fidelitybMcKubowD.desiredReplicas + 1;
  condition {
    M.fidelitybMcKubowD.maxReplicas > M.fidelitybMcKubowD.desiredReplicas;
  }
  action {
    M.scaleUp(M.fidelitybMcKubowD, 1);
  }
  effect {
    futureReplicas' == M.fidelitybMcKubowD.desiredReplicas;
  }
}

tactic removeFidelityb() {
  int futureReplicas = M.fidelitybMcKubowD.desiredReplicas - 1;
  condition {
    M.fidelitybMcKubowD.minReplicas < M.fidelitybMcKubowD.desiredReplicas;
  }
  action {
    M.scaleDown(M.fidelitybMcKubowD, 1);
  }
  effect {
    futureReplicas' == M.fidelitybMcKubowD.desiredReplicas;
  }
}