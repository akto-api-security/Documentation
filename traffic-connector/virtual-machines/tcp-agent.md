# Connect Akto with TCP Agent

## Introduction

You can use Akto traffic collectors to collect and send traffic to Akto. Your APIs from this traffic will show up in Akto dashboard.

## Adding Akto traffic processor

1. Set up and configure Akto Traffic Processor and save the mini-runtime service URL. The steps are mentioned [here](https://docs.akto.io/getting-started/traffic-processor/hybrid-saas). Alternatively, if you're on on-premise deployment, save the runtime service URL.

## Adding Akto traffic collector container

1. Start a docker service `aktosecurity/mirror-api-logging:k8s_agent` to any instance you want to collect traffic
2. Set the following env variables.
   1. Replace `<AKTO_NLB>` with the mini-runtime/runtime service URL saved earlier.

```
export AKTO_TRAFFIC_BATCH_TIME_SECS=10
export AKTO_TRAFFIC_BATCH_SIZE=100
export AKTO_INFRA_MIRRORING_MODE=gcp
export AKTO_KAFKA_BROKER_MAL=<AKTO_NLB>:9092
export AKTO_MONGO_CONN=mongodb://0.0.0.0:27017
```

3. Launch docker in your server instance.
