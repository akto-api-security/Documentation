# Connect Akto with docker on TLS service

You can connect your services, even if they're on TLS using akto-traffic-collector service. Your APIs from this traffic will show up in Akto dashboard.

To connect follow the following steps: 

1. Set up and configure Akto Traffic Processor and save the mini-runtime service URL. The steps are mentioned [here](https://docs.akto.io/getting-started/traffic-processor/hybrid-saas). Alternatively, if you're on on-premise deployment, save the runtime service URL.
2. Run the following docker command to create a container which will collect your traffic.
    1. The kafka_ip here is the mini-runtime/runtime service URL we saved in the previous step.
    2. Ensure that the VM has `linux kernel headers` installed. They are needed for the eBPF docker container.
    3. Ensure that the docker container can connect to the mini-runtime/runtime service.

```bash
docker run -d \
  --name akto-api-security-traffic-collector \
  --restart always \
  --network host \
  --privileged \
  --cap-add SYS_PTRACE \
  --cap-add SYS_ADMIN \
  -v /lib/modules:/lib/modules \
  -v /sys/kernel:/sys/kernel \
  -v /usr/src:/usr/src \
  -v /:/host \
  -e AKTO_TRAFFIC_BATCH_TIME_SECS=10 \
  -e AKTO_TRAFFIC_BATCH_SIZE=100 \
  -e AKTO_KAFKA_BROKER_MAL="<kafka_ip>" \
  aktosecurity/mirror-api-logging:k8s_ebpf
```

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).