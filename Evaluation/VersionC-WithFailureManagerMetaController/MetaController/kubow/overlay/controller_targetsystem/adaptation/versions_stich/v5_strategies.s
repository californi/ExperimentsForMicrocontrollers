module kubow.strategies;
import model "KubeZnnSystem:Acme" { KubeZnnSystem as M, KubernetesFam as K };
import lib "tactics.s";

define boolean NoFailureRate = M.failureManagerS.cpufailure == 0.0;
define boolean LowFailureRate = M.failureManagerS.cpufailure > 0.0 && M.failureManagerS.cpufailure <= 0.5;
define boolean HighFailureRate = M.failureManagerS.cpufailure > 0.5;

strategy dealingWithCPUFailure [ NoFailureRate || LowFailureRate || HighFailureRate ] {
  t0: (NoFailureRate) -> activatingscalabilitya() @[2500 /*ms*/] {
    t1: (success) -> activatingfidelitya() @[2500 /*ms*/] {
      t1a: (success) -> done;
      t1b: (default) -> TNULL;
    }
  }
  t2: (LowFailureRate) -> activatingscalabilityb() @[2500 /*ms*/] {
    t3: (success) -> activatingfidelitya() @[2500 /*ms*/] {
      t3a: (success) -> done;
      t3b: (default) -> TNULL;
    } 
  }
  t4: (HighFailureRate) -> activatingscalabilityb() @[2500 /*ms*/] {
    t5: (success) -> activatingfidelitya() @[2500 /*ms*/] {
      t5a: (success) -> done;
      t5b: (default) -> TNULL;
  }       
}