module kubow.strategies;
import model "KubeZnnSystem:Acme" { KubeZnnSystem as M, KubernetesFam as K };
import lib "tactics.s";

define boolean NoFailureRate = M.failureManagerS.cpufailure == 0.0;
define boolean LowFailureRate = M.failureManagerS.cpufailure > 0.0 && M.failureManagerS.cpufailure <= 0.5;
define boolean HighFailureRate = M.failureManagerS.cpufailure > 0.5;

strategy dealingWithCPUFailure [ NoFailureRate || LowFailureRate || HighFailureRate ] {
  t0: (NoFailureRate) -> activateHighScalabilityHighQuality() @[2500 /*ms*/] {
    t0a: (success) -> done;
  }
  t1: (LowFailureRate) -> activateLowScalabilityHighQuality() @[2500 /*ms*/] {
    t1a: (success) -> done;
  }  
  t2: (HighFailureRate) -> activateLowScalabilityLowQuality() @[2500 /*ms*/] {
    t2a: (success) -> done;
  }    
  t3: (default) -> TNULL;
}