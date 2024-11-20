#!/bin/bash

export GATEWAY=$(oc get route istio-ingressgateway -n istio-system -o template --template '{{ .spec.host }}')
export SLEEP=1

while true
do 
  date
  curl -s $GATEWAY/web/hello-service | jq
  sleep $SLEEP
done

#curl $GATEWAY/vm/hello-service #for vm-to-vm namespace