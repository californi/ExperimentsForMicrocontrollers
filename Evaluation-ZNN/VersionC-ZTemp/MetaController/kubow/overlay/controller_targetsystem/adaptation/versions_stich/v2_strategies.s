module kubow.strategies;
import model "KubeZnnSystem:Acme" { KubeZnnSystem as M, KubernetesFam as K };
import lib "tactics.s";

define boolean NoFailureRate = M.failureManagerS.cpufailure == 0.0;
define boolean LowFailureRate = M.failureManagerS.cpufailure > 0.0 && M.failureManagerS.cpufailure <= 0.5;
define boolean HighFailureRate = M.failureManagerS.cpufailure > 0.5;

strategy activateNoFailureRate [ NoFailureRate ] {

  define boolean canAddscalabilitya = M.scalabilityaMcKubowD.desiredReplicas < 1;
  define boolean canAddFidelitya = M.fidelityaMcKubowD.desiredReplicas < 1;  

  t0: (canAddscalabilitya && canAddFidelitya) -> addScalabilityaFidelitya() {
    t0a: (success) -> done;
  }  
  t1: (default) -> TNULL;
}

strategy activateHighFailureRate [ HighFailureRate ] {
  
  define boolean canAddscalabilityb = M.scalabilitybMcKubowD.desiredReplicas < 1;
  define boolean canAddFidelityb = M.fidelitybMcKubowD.desiredReplicas < 1;  

  t0: (canAddscalabilityb && canAddFidelityb) -> addScalabilitybFidelityb() {
    t0a: (success) -> done;
  }  
  t1: (default) -> TNULL;
}

