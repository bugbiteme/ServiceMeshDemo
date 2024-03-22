# Service Mesh Demo
## create Infra
oc apply -k ./infra

## create controlplane

oc new-project istio-system
oc new-project toolkit
oc apply -f ./control-plane

## create application
oc apply -f ./application

## create traffic pattern
oc apply -f ./TrafficPattern