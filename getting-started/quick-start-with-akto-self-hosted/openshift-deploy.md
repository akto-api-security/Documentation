---
description: Learn how to deploy Akto on Openshift cluster
---

# Openshift Deploy

Openshift is RedHat's managed private cluster offering - based on Docker and orchestration by Kubernetes.&#x20;

Steps to get Akto running on your Openshift cluster -&#x20;

1. You can use same steps as [Helm Deploy](helm-deploy.md) to deploy Akto.&#x20;
2. [Add service account](openshift-deploy.md#service-account-manifest) to get permissions for traffic connector.
3. You can use [Kubernetes Daemonset connector](../../traffic-connector/kubernetes/kubernetes.md) or [eBPF on mTLS](../../traffic-connector/ebpf/ebpf-mtls.md) as your traffic connector.&#x20;

Add the following to the Daemonset connector -&#x20;

> They listen to `any` interface by default - which might NOT be allowed in some Openshift clusters. If that's the case, contact support@akto.io - we can help listen traffic on `br-ex` interface.

```yaml
     containers:
      - name: mirror-api-logging
        ... 
        # add the following lines to add additional privileges
        privileged: true	
        securityContext:
          runAsUser: 0
          privileged: true
```

#### Service account manifest&#x20;

On Openshift, for a pod to be able to listen to node traffic (eg. a daemonset pod), it needs to be assigned some special permissions.

1\. Create a Service Account&#x20;

```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: akto-daemonset-serviceaccount
  annotations:
    "scc.openshift.io/scc": "akto-daemonset-scc"
```

2. Create a Security Context Constraint. Substitute \<NAMESPACE> with Akto daemonset yaml namespace.

```yaml
apiVersion: security.openshift.io/v1
kind: SecurityContextConstraints
metadata:
  name: akto-daemonset-scc
allowPrivilegedContainer: true
allowHostNetwork: true
requiredDropCapabilities:
- NET_ADMIN
seLinuxContext:
  type: RunAsAny
runAsUser:
  type: RunAsAny
runAsUser:
  type: RunAsAny
seLinuxContext:
  type: MustRunAs
users:
- system:serviceaccount:<NAMESPACE>:akto-daemonset-serviceaccount
```

3. Add SCC to service account

```bash
oc adm policy add-scc-to-user akto-daemonset-scc -z akto-daemonset-serviceaccount
```
