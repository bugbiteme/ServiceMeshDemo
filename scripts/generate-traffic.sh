#!/bin/bash

export GATEWAY=$(oc get route istio-ingressgateway -n istio-system -o template --template '{{ .spec.host }}')
export SLEEP=1

while true
do 
  date
  response=$(curl -s -w "%{http_code}" $GATEWAY/web/hello-service)
  http_code="${response: -3}"  # Extracts the last 3 characters as the HTTP code
  response_body="${response:0:-3}"  # Extracts the response body
  echo "HTTP Code: $http_code"
  echo "$response_body" | jq
  echo ""
  sleep $SLEEP
done

#curl $GATEWAY/vm/hello-service #for vm-to-vm namespace