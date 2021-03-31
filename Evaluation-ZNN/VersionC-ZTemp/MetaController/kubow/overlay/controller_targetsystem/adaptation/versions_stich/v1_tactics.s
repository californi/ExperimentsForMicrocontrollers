module kubow.strategies;
import model "KubeZnnSystem:Acme" { KubeZnnSystem as M, KubernetesFam as K };

tactic addScalabilitya() {
  int futureReplicas = M.scalabilityaMcKubowD.desiredReplicas + 1;
  condition {
    M.scalabilityaMcKubowD.maxReplicas > M.scalabilityaMcKubowD.desiredReplicas;
  }
  action {
    M.scaleUp(M.scalabilityaMcKubowD, 1);
  }
  effect @[2500] {
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
  effect @[2500] {
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
  effect @[2500] {
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
  effect @[2500] {
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
  effect @[2500] {
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
  effect @[2500] {
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
  effect @[2500] {
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
  effect @[2500] {
    futureReplicas' == M.fidelitybMcKubowD.desiredReplicas;
  }
}