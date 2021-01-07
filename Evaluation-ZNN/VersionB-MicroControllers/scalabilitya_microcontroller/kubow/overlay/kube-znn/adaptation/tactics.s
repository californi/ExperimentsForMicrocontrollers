module kubow.strategies;
import model "KubeZnnSystem:Acme" { KubeZnnSystem as M, KubernetesFam as K };

define boolean isStable = M.kubeZnnD.stability == 0;

tactic addReplica() {
  int futureReplicas = M.kubeZnnD.desiredReplicas + 1;
  condition {
    M.kubeZnnD.maxReplicas > M.kubeZnnD.desiredReplicas;
  }
  action {
    M.scaleUp(M.kubeZnnD, 1);
  }
  effect @[10000] {
    futureReplicas == M.kubeZnnD.desiredReplicas;
  }
}

tactic removeReplica() {
  int futureReplicas = M.kubeZnnD.desiredReplicas - 1;
  condition {
    isStable && M.kubeZnnD.minReplicas < M.kubeZnnD.desiredReplicas;
  }
  action {
    M.scaleDown(M.kubeZnnD, 1);
  }
  effect @[10000] {
    futureReplicas == M.kubeZnnD.desiredReplicas;
  }
}