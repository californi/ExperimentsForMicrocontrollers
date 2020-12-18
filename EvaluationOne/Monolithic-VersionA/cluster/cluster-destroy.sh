set -e

export NAME=testbed.k8s.local
export KOPS_STATE_STORE=s3://testbed.k8s.local
export REGION=us-east-1
export ZONES=us-east-1a

kops delete cluster $NAME --yes
aws s3 rm --recursive $KOPS_STATE_STORE