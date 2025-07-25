# Connect Akto on TLS service

Akto can automatically detect and analyze your API traffic—even if it's encrypted using TLS. This is achieved using **Akto Traffic Collector**, which leverages **eBPF** to passively observe kernel-level network activity.

You can deploy this collector on **any Linux-based system** (VM, bare metal, or cloud instance) to forward traffic insights to Akto. Here's how:

#### Step 1: Set Up Akto Traffic Processor (Mini-Runtime)

First, set up and configure the **Akto Traffic Processor (Mini-Runtime)**.

* You’ll get a **runtime service URL** or **Kafka IP** once setup is complete.
* If you're using **on-prem Akto**, this will be your internal runtime URL.

📘 [Follow this setup guide](https://docs.akto.io/getting-started/traffic-processor/hybrid-saas) for instructions.

#### Step 2: Deploy Traffic Collector (Supports TLS via eBPF)

This Docker container uses **eBPF** to mirror all API traffic at the kernel level—including **TLS-encrypted** traffic—without needing to decrypt it manually or modify applications.

**⚠ Prerequisites:**

* **Linux VM** or system with **kernel headers installed** (required for eBPF)
* Docker daemon installed and running
* Access to your Akto runtime (Kafka IP)

#### Run the Traffic Collector

The kafka\_ip here is the mini-runtime/runtime service URL we saved in the previous step.

```bash
docker run -d \
  --name akto-api-security-traffic-collector \
  --restart always \
  --network host \
  --privileged \
  --pid=host \
  --cap-add SYS_PTRACE \
  --cap-add SYS_ADMIN \
  -v /lib/modules:/lib/modules \
  -v /sys/kernel:/sys/kernel \
  -v /usr/src:/usr/src \
  -v /:/host \
  -e AKTO_TRAFFIC_BATCH_TIME_SECS=10 \
  -e AKTO_TRAFFIC_BATCH_SIZE=100 \
  -e AKTO_KAFKA_BROKER_MAL=<kafka-ip> \
  -e PROBE_ALL_PID=true \
  aktosecurity/mirror-api-logging:k8s_ebpf
```

In case you face an issue with the spaces in the command above

```bash
docker run -d --name akto-api-security-traffic-collector --restart always --network host --pid=host --privileged --cap-add SYS_PTRACE --cap-add SYS_ADMIN -v /lib/modules:/lib/modules -v /sys/kernel:/sys/kernel -v /usr/src:/usr/src -v /:/host -e AKTO_TRAFFIC_BATCH_TIME_SECS=10 -e AKTO_TRAFFIC_BATCH_SIZE=100 -e AKTO_KAFKA_BROKER_MAL=<kafka_ip> -e PROBE_ALL_PID=true aktosecurity/mirror-api-logging:k8s_ebpf
```

#### What’s Happening Behind the Scenes?

* **eBPF hooks into your Linux kernel** to capture real-time traffic—even if it’s encrypted (TLS).
* No code changes, no traffic proxying, no SSL termination.
* The collector forwards API traces to Akto for real-time inventory and security analysis.

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
