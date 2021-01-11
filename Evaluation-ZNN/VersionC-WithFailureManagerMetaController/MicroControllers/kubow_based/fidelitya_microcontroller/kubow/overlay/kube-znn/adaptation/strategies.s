module kubow.strategies;
import model "KubeZnnSystem:Acme" { KubeZnnSystem as M, KubernetesFam as K };
import lib "tactics.s";

define boolean highMode = M.kubeZnnD.replicasHigha >= M.kubeZnnD.desiredReplicas || M.kubeZnnD.replicasHighb >= M.kubeZnnD.desiredReplicas;


define boolean sloRed = M.kubeZnnS.slo <= 0.95;
define boolean sloGreen = M.kubeZnnS.slo >= 0.99;


define boolean canAddReplica = M.kubeZnnD.maxReplicas > M.kubeZnnD.desiredReplicas;
define boolean canRemoveReplica = M.kubeZnnD.minReplicas < M.kubeZnnD.desiredReplicas;

/*
 * ----
 */
strategy ImproveSlo [ sloRed ] {
  t0: (sloRed && !canAddReplica) -> lowerFidelity() @[20000 /*ms*/] {
    t0a: (success) -> done;
  }
  t1: (default) -> TNULL;
}


/*
 * ----
 */
strategy ImproveFidelity [ sloGreen ] {
  t0: (sloGreen && !highMode) -> raiseFidelity() @[20000 /*ms*/] {
    t0a: (success) -> done;
  }
  t1: (default) -> TNULL;
}
