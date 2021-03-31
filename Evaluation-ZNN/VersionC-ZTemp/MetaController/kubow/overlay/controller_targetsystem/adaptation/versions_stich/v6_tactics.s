module kubow.strategies;
import model "KubeZnnSystem:Acme" { KubeZnnSystem as M, KubernetesFam as K };


tactic activatingscalabilitya() {
  int futureReplicasScalabilitya = M.scalabilityaMcKubowD.desiredReplicas + 1;
  int futureReplicasScalabilityb = M.scalabilitybMcKubowD.desiredReplicas - 1;
  condition {
    (M.scalabilityaMcKubowD.desiredReplicas < 1 && M.scalabilitybMcKubowD.desiredReplicas > 0);
  }
  action {
    M.scaleUp(M.scalabilityaMcKubowD, 1);
    M.scaleDown(M.scalabilitybMcKubowD, 1);
  }
  effect {
    futureReplicasScalabilitya == M.scalabilityaMcKubowD.desiredReplicas && futureReplicasScalabilityb == M.scalabilitybMcKubowD.desiredReplicas;
  }
}

tactic activatingscalabilityb() {
  int futureReplicasScalabilityb = M.scalabilitybMcKubowD.desiredReplicas + 1;
  int futureReplicasScalabilitya = M.scalabilityaMcKubowD.desiredReplicas - 1;
  condition {
    (M.scalabilitybMcKubowD.desiredReplicas < 1 && M.scalabilityaMcKubowD.desiredReplicas > 0);
  }
  action {
    M.scaleUp(M.scalabilitybMcKubowD, 1);
    M.scaleDown(M.scalabilityaMcKubowD, 1);
  }
  effect {
    futureReplicasScalabilityb == M.scalabilitybMcKubowD.desiredReplicas && futureReplicasScalabilitya == M.scalabilityaMcKubowD.desiredReplicas;
  }
}

tactic activatingfidelitya() {
  int futureReplicasfidelitya = M.fidelityaMcKubowD.desiredReplicas + 1;
  int futureReplicasfidelityb = M.fidelitybMcKubowD.desiredReplicas - 1;
  condition {
    (M.fidelityaMcKubowD.desiredReplicas < 1 && M.fidelitybMcKubowD.desiredReplicas > 0);
  }
  action {
    M.scaleUp(M.fidelityaMcKubowD, 1);
    M.scaleDown(M.fidelitybMcKubowD, 1);
  }
  effect {
    futureReplicasfidelitya == M.fidelityaMcKubowD.desiredReplicas && futureReplicasfidelityb == M.fidelitybMcKubowD.desiredReplicas;
  }
}

tactic activatingfidelityb() {
  int futureReplicasfidelityb = M.fidelitybMcKubowD.desiredReplicas + 1;
  int futureReplicasfidelitya = M.fidelityaMcKubowD.desiredReplicas - 1;
  condition {
    (M.fidelitybMcKubowD.desiredReplicas < 1 && M.fidelityaMcKubowD.desiredReplicas > 0);
  }
  action {
    M.scaleUp(M.fidelitybMcKubowD, 1);
    M.scaleDown(M.fidelityaMcKubowD, 1);
  }
  effect {
    futureReplicasfidelityb == M.fidelitybMcKubowD.desiredReplicas && futureReplicasfidelitya == M.fidelityaMcKubowD.desiredReplicas;
  }
}