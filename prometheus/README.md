this needs to be patched first and the Prometheus pod needs to be deleted after to appy the updated config
  
```bash
oc patch prometheus user-workload -n openshift-user-workload-monitoring --type=merge -p '{"spec": {"listenLocal": false}}'
oc delete pod -n openshift-user-workload-monitoring -l app.kubernetes.io/name=prometheus
```