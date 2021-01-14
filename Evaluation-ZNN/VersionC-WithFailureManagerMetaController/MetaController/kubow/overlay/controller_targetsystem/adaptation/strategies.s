module kubow.strategies;
import model "KubeZnnSystem:Acme" { KubeZnnSystem as M, KubernetesFam as K };
import lib "tactics.s";

define boolean NoFailureRate = M.failureManagerS.cpufailure == 0.0;
define boolean LowFailureRate = M.failureManagerS.cpufailure > 0.0 && M.failureManagerS.cpufailure <= 0.5;
define boolean HighFailureRate = M.failureManagerS.cpufailure > 0.5;

define boolean IsScalabilitya = M.kubeZnnD.desiredReplicas > 9;

strategy activateNoFailureRate [ NoFailureRate ] {  
  t0: (NoFailureRate) -> addHighScalabilityHighQuality() @[40000 /*ms*/] {
    t0a: (success) -> done;
  }   
  t1: (default) -> TNULL;
}

strategy activateLowFailureRate [ LowFailureRate && IsScalabilitya ] {  
  t0: (LowFailureRate) -> activateLowScalabilityHighQuality() @[40000 /*ms*/] {
    t0a: (success) -> done;
  }      
  t1: (default) -> TNULL;
}


strategy activateHighFailureRate [ HighFailureRate && IsScalabilitya ] {    
  t0: (HighFailureRate && IsScalabilitya) -> addLowScalabilityLowQuality() @[40000 /*ms*/] {
    t0a: (success) -> done;
  }   
  t1: (default) -> TNULL;
}