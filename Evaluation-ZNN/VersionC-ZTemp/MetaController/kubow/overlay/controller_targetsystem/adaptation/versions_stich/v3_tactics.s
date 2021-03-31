module kubow.strategies;
import model "KubeZnnSystem:Acme" { KubeZnnSystem as M, KubernetesFam as K };


tactic activatingscalabilitya() {
  int futureReplicas = M.scalabilityaMcKubowD.desiredReplicas + 1;
  condition {
    M.scalabilityaMcKubowD.maxReplicas > M.scalabilityaMcKubowD.desiredReplicas;
  }
  action {
    M.scaleUp(M.scalabilityaMcKubowD, 1);
    M.scaleDown(M.scalabilitybMcKubowD, 1);
  }
  effect @[1250]{
    futureReplicas' == M.scalabilityaMcKubowD.desiredReplicas;
  }
}

tactic activatingscalabilityb() {
  int futureReplicas = M.scalabilitybMcKubowD.desiredReplicas + 1;
  condition {
    M.scalabilitybMcKubowD.maxReplicas > M.scalabilitybMcKubowD.desiredReplicas;
  }
  action {
    M.scaleUp(M.scalabilitybMcKubowD, 1);
    M.scaleDown(M.scalabilityaMcKubowD, 1);
  }
  effect @[1250]{
    futureReplicas' == M.scalabilitybMcKubowD.desiredReplicas;
  }
}

tactic activatingfidelitya() {
  int futureReplicas = M.fidelityaMcKubowD.desiredReplicas + 1;
  condition {
    M.fidelityaMcKubowD.maxReplicas > M.fidelityaMcKubowD.desiredReplicas;
  }
  action {
    M.scaleUp(M.fidelityaMcKubowD, 1);
    M.scaleDown(M.fidelitybMcKubowD, 1);
  }
  effect @[1250]{
    futureReplicas' == M.fidelityaMcKubowD.desiredReplicas;
  }
}

tactic activatingfidelityb() {
  int futureReplicas = M.fidelitybMcKubowD.desiredReplicas + 1;
  condition {
    M.fidelitybMcKubowD.maxReplicas > M.fidelitybMcKubowD.desiredReplicas;
  }
  action {
    M.scaleUp(M.fidelitybMcKubowD, 1);
    M.scaleDown(M.fidelityaMcKubowD, 1);
  }
  effect @[1250]{
    futureReplicas' == M.fidelitybMcKubowD.desiredReplicas;
  }
}