module kubow.strategies;
import model "KubeZnnSystem:Acme" { KubeZnnSystem as M, KubernetesFam as K };
import lib "tactics.s";

define boolean canAddScalabilitya = M.scalabilityaMcKubowD.maxReplicas > M.scalabilityaMcKubowD.desiredReplicas;
define boolean canRemoveScalabilitya = M.scalabilityaMcKubowD.minReplicas < M.scalabilityaMcKubowD.desiredReplicas;

define boolean canAddScalabilityb = M.scalabilitybMcKubowD.maxReplicas > M.scalabilitybMcKubowD.desiredReplicas;
define boolean canRemoveScalabilityb = M.scalabilitybMcKubowD.minReplicas < M.scalabilitybMcKubowD.desiredReplicas;

define boolean canAddFidelitya = M.fidelityaMcKubowD.maxReplicas > M.fidelityaMcKubowD.desiredReplicas;
define boolean canRemoveFidelitya = M.fidelityaMcKubowD.minReplicas < M.fidelityaMcKubowD.desiredReplicas;

define boolean canAddFidelityb = M.fidelitybMcKubowD.maxReplicas > M.fidelitybMcKubowD.desiredReplicas;
define boolean canRemoveFidelityb = M.fidelitybMcKubowD.minReplicas < M.fidelitybMcKubowD.desiredReplicas;

define boolean NoFailureRate = M.failureManagerS.cpufailure == 0.0;
define boolean LowFailureRate = M.failureManagerS.cpufailure > 0.0 && M.failureManagerS.cpufailure <= 0.5;
define boolean HighFailureRate = M.failureManagerS.cpufailure > 0.5;


strategy ActivateScalabilitya [ canAddScalabilitya && NoFailureRate ] {
  t0: (NoFailureRate && canAddScalabilitya) -> addScalabilitya() @[5000 /*ms*/] {
    t0a: (success) -> done;
  }
  t1: (default) -> TNULL;
}

strategy ActivateScalabilityb [ canAddScalabilityb || LowFailureRate || HighFailureRate] {
  t0: (canAddScalabilityb && (LowFailureRate || HighFailureRate)) -> addScalabilityb() @[5000 /*ms*/] {
    t0a: (success) -> done;
  }
  t1: (default) -> TNULL;
}

strategy ActivateFidelitya [ canAddFidelitya || NoFailureRate || LowFailureRate ] {
  t0: (canAddFidelitya && (NoFailureRate || LowFailureRate)) -> addFidelitya() @[5000 /*ms*/] {
    t0a: (success) -> done;
  }
  t1: (default) -> TNULL;
}

strategy ActivateFidelityb [ canAddFidelityb && HighFailureRate ] {
  t0: (canAddFidelityb && HighFailureRate) -> addFidelityb() @[5000 /*ms*/] {
    t0a: (success) -> done;
  }
  t1: (default) -> TNULL;
}

strategy DeactivateScalabilitya [ canRemoveScalabilitya || LowFailureRate || HighFailureRate ] {
  t0: (canRemoveScalabilitya && (LowFailureRate || HighFailureRate)) -> removeScalabilitya() @[5000 /*ms*/] {
    t0a: (success) -> done;
  }
  t1: (default) -> TNULL;
}

strategy DeactivateScalabilityb [ canRemoveScalabilityb && NoFailureRate ] {
  t0: (canRemoveScalabilityb && NoFailureRate) -> removeScalabilityb() @[5000 /*ms*/] {
    t0a: (success) -> done;
  }
  t1: (default) -> TNULL;
}

strategy DeactivateFidelitya [ canRemoveFidelitya && HighFailureRate ] {
  t0: (canRemoveFidelitya && HighFailureRate) -> removeFidelitya() @[5000 /*ms*/] {
    t0a: (success) -> done;
  }
  t1: (default) -> TNULL;
}


strategy DeactivateFidelityb [ canRemoveFidelityb || NoFailureRate || LowFailureRate ] {
  t0: (canRemoveFidelityb && (NoFailureRate || LowFailureRate)) -> removeFidelityb() @[5000 /*ms*/] {
    t0a: (success) -> done;
  }
  t1: (default) -> TNULL;
}

