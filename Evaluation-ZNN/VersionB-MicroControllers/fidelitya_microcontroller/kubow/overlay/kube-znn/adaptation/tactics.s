module kubow.strategies;
import model "KubeZnnSystem:Acme" { KubeZnnSystem as M, KubernetesFam as K };

define boolean textMode = M.kubeZnnD.replicasText >= M.kubeZnnD.desiredReplicas;
define boolean lowMode = M.kubeZnnD.replicasLow >= M.kubeZnnD.desiredReplicas;
define boolean highMode = M.kubeZnnD.replicasHigh >= M.kubeZnnD.desiredReplicas;

define string highModeImage = "cmendes/znn:800k";
define string lowModeImage = "cmendes/znn:600k";
define string textModeImage = "cmendes/znn:400k";

define boolean isStable = M.kubeZnnD.stability == 0;

tactic addReplica() {
  int futureReplicas = M.kubeZnnD.desiredReplicas + 1;
  condition {
    M.kubeZnnD.maxReplicas > M.kubeZnnD.desiredReplicas;
  }
  action {
    M.scaleUp(M.kubeZnnD, 1);
  }
  effect @[5000] {
    futureReplicas' == M.kubeZnnD.desiredReplicas;
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
  effect @[5000] {
    futureReplicas' == M.kubeZnnD.desiredReplicas;
  }
}

tactic lowerFidelity() {
  condition {
    highMode || lowMode;
  }
  action {
    if (highMode) {
      M.rollOut(M.kubeZnnD, "znn", lowModeImage);
    }
    if (lowMode) {
      M.rollOut(M.kubeZnnD, "znn", textModeImage);
    }
  }
  effect @[5000] {
    lowMode;
  }
}

tactic raiseFidelity() {
  condition {
    isStable && !highMode;
  }
  action {
    if (textMode) {
      M.rollOut(M.kubeZnnD, "znn", lowModeImage);
    }
    if (lowMode) {
      M.rollOut(M.kubeZnnD, "znn", highModeImage);
    }
  }
  effect @[5000] {
    highMode || lowMode;
  }
}

