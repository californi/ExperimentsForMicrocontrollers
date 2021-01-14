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
  int mismatchingReplicas = M.kubeZnnD.desiredReplicas - M.kubeZnnD.maxReplicas;
  int futureReplicas = M.kubeZnnD.desiredReplicas - 1;
  int futureReplicasOver = M.kubeZnnD.desiredReplicas - mismatchingReplicas;
  condition {
    isStable && M.kubeZnnD.minReplicas < M.kubeZnnD.desiredReplicas;
  }
  action {
    if(mismatchingReplicas > 0){
      M.scaleDown(M.kubeZnnD, mismatchingReplicas);
    }
    if(mismatchingReplicas <= 0){
      M.scaleDown(M.kubeZnnD, 1);
    }
  }
  effect @[10000] {
    futureReplicas == M.kubeZnnD.desiredReplicas || futureReplicasOver == M.kubeZnnD.desiredReplicas;
  }
}

tactic AdjustReplicas(){
  int mismatchingReplicas = M.kubeZnnD.desiredReplicas - M.kubeZnnD.maxReplicas;
  int futureReplicas = M.kubeZnnD.desiredReplicas - mismatchingReplicas;
  condition {
    M.kubeZnnD.maxReplicas < M.kubeZnnD.desiredReplicas;
  }
  action {
    if(mismatchingReplicas > 0){
      M.scaleDown(M.kubeZnnD, mismatchingReplicas);
    }
  }
  effect @[15000] {
    futureReplicas == M.kubeZnnD.desiredReplicas;
  }

}