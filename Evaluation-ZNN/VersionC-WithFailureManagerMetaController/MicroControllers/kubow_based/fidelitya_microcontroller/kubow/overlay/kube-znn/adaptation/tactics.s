module kubow.strategies;
import model "KubeZnnSystem:Acme" { KubeZnnSystem as M, KubernetesFam as K };

//define boolean textMode = M.kubeZnnD.replicasTexta >= M.kubeZnnD.desiredReplicas || M.kubeZnnD.replicasTextb >= M.kubeZnnD.desiredReplicas;
//define boolean lowMode = M.kubeZnnD.replicasLowa >= M.kubeZnnD.desiredReplicas || M.kubeZnnD.replicasLowb >= M.kubeZnnD.desiredReplicas;
//define boolean highMode = M.kubeZnnD.replicasHigha >= M.kubeZnnD.desiredReplicas || M.kubeZnnD.replicasHighb >= M.kubeZnnD.desiredReplicas;

define boolean textMode = M.kubeZnnD.replicasTexta > 0;
define boolean lowMode = M.kubeZnnD.replicasLowa > 0;
define boolean highMode = M.kubeZnnD.replicasHigha > 0;

define string highModeImage = "cmendes/znn:800k";
define string lowModeImage = "cmendes/znn:600k";
define string textModeImage = "cmendes/znn:400k";

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

