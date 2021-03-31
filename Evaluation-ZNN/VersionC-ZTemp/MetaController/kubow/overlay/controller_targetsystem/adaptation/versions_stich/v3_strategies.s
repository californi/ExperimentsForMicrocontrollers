module kubow.strategies;
import model "KubeZnnSystem:Acme" { KubeZnnSystem as M, KubernetesFam as K };
import lib "tactics.s";

define boolean NoFailureRate = M.failureManagerS.cpufailure == 0.0;
define boolean LowFailureRate = M.failureManagerS.cpufailure > 0.0 && M.failureManagerS.cpufailure <= 0.5;
define boolean HighFailureRate = M.failureManagerS.cpufailure > 0.5;

strategy activateHighScalabilityHighQuality [ NoFailureRate ] {
  t0: (NoFailureRate) -> activatingscalabilitya() @[5000 /*ms*/] {
    t0a: (success) -> activatingfidelitya() @[5000 /*ms*/] {
      t0b: (success) -> done;
    }
  }   
  t1: (default) -> TNULL;
}

strategy activateLowScalabilityHighQuality [ LowFailureRate ] {
  t0: (LowFailureRate) -> activatingscalabilityb() @[5000 /*ms*/] {
    t0a: (success) -> activatingfidelitya() @[5000 /*ms*/] {
      t0b: (success) -> done;
    } 
  }   
  t1: (default) -> TNULL;
}

strategy activateLowScalabilityLowQuality [ HighFailureRate ] {
  t0: (HighFailureRate) -> activatingscalabilityb() @[5000 /*ms*/] {
    t0a: (success) -> activatingfidelitya() @[5000 /*ms*/] {
      t0b: (success) -> done;
  } 
  t1: (default) -> TNULL;
}