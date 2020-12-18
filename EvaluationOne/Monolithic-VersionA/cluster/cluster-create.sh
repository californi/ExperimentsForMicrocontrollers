#!/usr/bin/env bash
set -e

export NAME=testbed.k8s.local
export KOPS_STATE_STORE=s3://testbed.k8s.local
export REGION=us-east-1
export ZONES=us-east-1a

kops create -f cluster.yaml
kops create secret --name testbed.k8s.local sshpublickey admin -i ~/.ssh/id_rsa.pub
kops create -f ig-kube-znn.yaml
kops create -f ig-monitoring.yaml
kops create -f ig-testing.yaml
kops create -f ig-ingress.yaml
kops create -f ig-kubow.yaml
kops update cluster testbed.k8s.local --yes
