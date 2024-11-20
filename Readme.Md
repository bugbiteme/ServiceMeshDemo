# Service Mesh Demo

Built for OSSM 3.x (tested on 3.0)

You can use the Red Hat Solution Pattern to get the base OSSM install (along with RHCL)

[Solution Patterns: Connect, Secure and Protect with Red Hat Connectivity Link](https://www.solutionpatterns.io/soln-pattern-connectivity-link/solution-patter)

## create Infra (Kiali, Distributed Tracing)
oc apply -k ./infra

## create controlplane
oc new-project istio-system
oc new-project toolkit

oc apply -f ./control-plane

## create application
oc new-project rest-api-with-mesh
oc apply -k ./application/kustomize/overlays/pod -n rest-api-with-mesh

## create traffic pattern
oc apply -f ./TrafficPattern

## Test External Traffic If OpenshiftRoute Disabled for Gateways in Control Plane
curl http://istio-ingressgateway-istio-system.apps.cluster-2z7g7.dynamic.redhatworkshops.io/main-page

## Test with external traffic If OpenshiftRoute Enabled for Gateways in Control Plane
curl http://toolkit-toolkit-gateway-1-684888c0ebb17f37-istio-system.apps.cluster-2z7g7.dynamic.redhatworkshops.io/main-page

## do the same with GatewayInjection
``` 
    oc apply -f ./GatewayInjection/gatewayInjection.yaml
    oc apply -f ./GatewayInjection/traffic-pattern.yaml
```    

## Test with external traffic If OpenshiftRoute Enabled for Gateways in Control Plane
curl http://toolkit.apps.cluster-2z7g7.dynamic.redhatworkshops.io/main-page