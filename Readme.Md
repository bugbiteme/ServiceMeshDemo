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

curl http://toolkit-toolkit-gateway-1-684888c0ebb17f37-istio-system.apps.cluster-2z7g7.dynamic.redhatworkshops.io/main-page

## do the same with GatewayInjection
oc apply -f ./GatewayInjection/gatewayInjection.yaml
oc apply -f ./GatewayInjection/traffic-pattern.yaml

curl http://toolkit.apps.cluster-2z7g7.dynamic.redhatworkshops.io/main-page