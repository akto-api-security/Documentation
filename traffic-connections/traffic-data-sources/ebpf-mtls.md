# Connect Akto with eBPF on mTLS setup

## Introduction

Connecting with Akto's eBPF traffic collector is recommended mTLS systems where TLS termination occurs at application ( a system where your services are just passing the traffic directly to the application ). To get a better overview of how the akto traffic collector module works and install akto data processor, check [this](./ebpf.md) out.

## Adding Akto traffic collector

1. Here's the daemonset configuration for the akto traffic collector. 

```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: akto-k8s
  namespace: {NAMESPACE}
  labels:
    app: akto-collector
spec:
  selector:
    matchLabels:
      app: akto-collector
  template:
    metadata:
      labels:
        app: akto-collector
    spec:
      hostNetwork: true
      dnsPolicy: ClusterFirstWithHostNet
      hostPID: true
      containers:
      - name: mirror-api-logging
        image: aktosecurity/mirror-api-logging:k8s_ebpf_e2e
        resources:
          limits:
            cpu: 500m
            memory: 1Gi
          requests:
            cpu: 50m
            memory: 50Mi
        env: 
          - name: AKTO_TRAFFIC_BATCH_TIME_SECS
            value: "10"
          - name: AKTO_TRAFFIC_BATCH_SIZE
            value: "100"
          - name: AKTO_KAFKA_BROKER_MAL
            value: "<AKTO_NLB_IP>:9092"
          - name: AKTO_MONGO_CONN
            value: "<AKTO_MONGO_CONN>"
          - name: CAPTURE_SSL
            value: "true"
        securityContext:
          capabilities:
            add:
            - SYS_PTRACE
            - SYS_ADMIN
          privileged: true
        volumeMounts:
          # needed to load kernel headers
          - name: lib-modules
            mountPath: /lib/modules
            readOnly: true
          # needed to trace kernel events
          - name: sys-kernel
            mountPath: /sys/kernel
            readOnly: true
          # needed to trace SSL user libraries
          - name: host
            mountPath: /host
            readOnly: true
      volumes:
        - name: sys-kernel
          hostPath:
            path: /sys/kernel
        - name: lib-modules
          hostPath:
            path: /lib/modules
        - name: host
          hostPath:
            path : /
```

## Notes:

1. If you're running the daemonset outside of the kubernetes system, set the env `PROBE_ALL_PID` as `true`.

2. Set `CAPTURE_SSL` env variable to `true` is recommended, if the TLS termination happens at the application. If the TLS termination happens at the service, we recommended to set it to `false`.

## Frequently Asked Questions (FAQs)

**The traffic will contain a lot of sensitive data - does it leave my VPC?**

Data remains strictly within your VPC. Akto doesn't take data out of your VPC at all.

**Does adding DaemonSet have any impact on performance or latency?**

Zero impact on latency. The DaemonSet doesn't sit like a proxy. It works on eBPF technology, which works on traces function calls at kernel level. It is very lightweight. We have benchmarked it against traffic as high as 20M API requests/min. It consumes very low resources (CPU & RAM).

**I don't see my error on this list here.**

Please send us all details at support@akto.io or reach out via Intercom on your Akto dashboard. We will definitely help you out.

### Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
