#!/bin/bash

export GATEWAY=$(oc get route istio-ingressgateway -n istio-system -o template --template '{{ .spec.host }}')
export SLEEP=1

curl -s $GATEWAY/web/hello | jq
curl -s $GATEWAY/web/hello-service | jq



#curl $GATEWAY/vm/hello-service #for vm-to-vm namespace