module kubow.strategies;
import model "KubeZnnSystem:Acme" { KubeZnnSystem as M, KubernetesFam as K };

define boolean textMode = M.kubeZnnD.replicasText > 0;
define boolean lowMode = M.kubeZnnD.replicasLow > 0;
define boolean highMode = M.kubeZnnD.replicasHigh > 0;

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

