module kubow.strategies;
import model "KubeZnnSystem:Acme" { KubeZnnSystem as M, KubernetesFam as K };
import lib "tactics.s";

define boolean canAddScalabilitya = M.scalabilityaMcKubowD.maxReplicas > M.scalabilityaMcKubowD.desiredReplicas;
define boolean canAddScalabilityb = M.scalabilitybMcKubowD.maxReplicas > M.scalabilitybMcKubowD.desiredReplicas;
define boolean canAddFidelitya = M.fidelityaMcKubowD.maxReplicas > M.fidelityaMcKubowD.desiredReplicas;
define boolean canAddFidelityb = M.fidelitybMcKubowD.maxReplicas > M.fidelitybMcKubowD.desiredReplicas;

define boolean NoFailureRate = M.failureManagerS.cpufailure == 0.0;
define boolean LowFailureRate = M.failureManagerS.cpufailure > 0.0 && M.failureManagerS.cpufailure <= 0.5;
define boolean HighFailureRate = M.failureManagerS.cpufailure > 0.5;

strategy dealingWithCPUFailure [ NoFailureRate || LowFailureRate || HighFailureRate ] {
  t0: (NoFailureRate && canAddScalabilitya) -> activatingscalabilitya() @[2500 /*ms*/] {
    t0a: (success) -> done;
  }
  t1: (canAddFidelitya && (NoFailureRate || LowFailureRate)) -> activatingfidelitya() @[2500 /*ms*/] {
    t1a: (success) -> done;
  }  
  t2: (canAddScalabilityb && (LowFailureRate || HighFailureRate)) -> activatingscalabilityb() @[2500 /*ms*/] {
    t2a: (success) -> done; 
  } 
  t3: (canAddFidelityb && HighFailureRate) -> activatingfidelityb() @[2500 /*ms*/] {
    t3a: (success) -> done;
  }    
  t4: (default) -> TNULL;     
}