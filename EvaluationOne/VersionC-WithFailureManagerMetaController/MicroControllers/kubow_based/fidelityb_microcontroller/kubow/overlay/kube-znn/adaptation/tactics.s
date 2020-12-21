module kubow.strategies;
import model "KubeZnnSystem:Acme" { KubeZnnSystem as M, KubernetesFam as K };

define boolean textMode = M.kubeZnnD.replicasText >= M.kubeZnnD.desiredReplicas;
define boolean lowMode = M.kubeZnnD.replicasLow >= M.kubeZnnD.desiredReplicas;
define boolean highMode = M.kubeZnnD.replicasHigh >= M.kubeZnnD.desiredReplicas;

define string highModeImage = "cmendes/znn:200k";
define string lowModeImage = "cmendes/znn:100k";
define string textModeImage = "cmendes/znn:20k";


define boolean isStable = M.kubeZnnD.stability == 0;

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
  effect @[10000] {
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
  effect @[10000] {
    highMode || lowMode;
  }
}

