# Connect Akto with Docker

## Introduction

You can add akto-traffic-collector service to your docker-compose file. Your APIs from this traffic will show up in Akto dashboard.

## Adding Akto traffic processor

1. Set up and configure Akto Traffic Processor and save the mini-runtime service URL. The steps are mentioned [here](https://docs.akto.io/getting-started/traffic-processor/hybrid-saas). Alternatively, if you're on on-premise deployment, save the runtime service URL.

## Adding Akto docker service

1. Create a file `docker-akto-collector.env` with the following content.
   1. Replace `<AKTO_NLB>` with the mini-runtime/runtime service URL saved earlier.

```bash
AKTO_TRAFFIC_BATCH_TIME_SECS=10
AKTO_TRAFFIC_BATCH_SIZE=100
AKTO_INFRA_MIRRORING_MODE=gcp
AKTO_KAFKA_BROKER_MAL=<AKTO_NLB>:9092
AKTO_MONGO_CONN=mongodb://0.0.0.0:27017
```

2. Add the following service to your docker-compose file. Adjust the mem\_limit accordingly.

```yaml
  akto-api-security-traffic-collector:
    image: aktosecurity/mirror-api-logging:k8s_agent
    env_file: ./docker-akto-collector.env
    mem_limit: 300m    
    restart: always
    network_mode: host
```
