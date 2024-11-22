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

## create istio-cni (needed for proxie containers)
`oc apply -f istio`  

## create application
This uses `Kustomize` to deploy the application, including creating the namespace.  
  
`oc apply -k ./application/kustomize/overlays/pod`  

## create Gateway (Gateway API) + HTTPRoute  
`oc apply -f gateway`  

## Test gateway connection to app
`sh ./scripts/test-api.sh `  

```json
{
  "message": "Hello World from web-front-end"
}
{
  "response": {
    "message": "Hello World from service-b-v1"
  }
}
```

## Canary deployment
run the scripts:  
`scripts/generate-traffic.sh` - While loop that gets message from backend service via the front-end  
  
`scripts/canary-rollout.sh` - to simulate a canary roll out while traffic is live.  
  
You can see real time updates from the first script during the canary deployment (so have two terminals open for this)

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