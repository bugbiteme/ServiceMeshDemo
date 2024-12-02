# Service Mesh Demo
Uses `Gateway API` for ingress  

Built for OSSM 3.x (tested on 3.0)

## Installation checklist [TODO]
[X] Gateway API  
[X] OpenShift Service Mesh  
[ ] Kiali  
[ ] Distributed Tracing (Tempo)  
[ ] Cert-Manager  
[ ] Argo Rollouts  

[Current installation documentation](https://docs.openshift.com/service-mesh/3.0.0tp1/)

You can use the Red Hat Solution Pattern to get the base OSSM install (along with RHCL), but it might cause more headaches.


[Solution Patterns: Connect, Secure and Protect with Red Hat Connectivity Link](https://www.solutionpatterns.io/soln-pattern-connectivity-link/solution-patter)

## Enable Gateway API
```bash
oc get crd gateways.gateway.networking.k8s.io &> /dev/null ||  { oc kustomize "github.com/kubernetes-sigs/gateway-api/config/crd?ref=v1.0.0" | oc apply -f -; }
```

## Install Infra Operators (Istio, Kiali, Distributed Tracing, Argo)
oc apply -k ./infra

## create Istio components
oc apply -k ./istio

## Create a shared gateway via Gatweway API
oc apply -k ./gateway

## create application
This uses `Kustomize` to deploy the application, including creating the namespace.    
  
oc apply -k ./application/kustomize/overlays/pod  
  
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