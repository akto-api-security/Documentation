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
    mem_limit: 512m    
    restart: always
    network_mode: host
```

## Run with a single command

You can run the traffic collector with one `docker run` command. Replace `<AKTO_NLB>` with the mini-runtime/runtime service URL.

```bash
docker run -d \
  --name akto-api-security-traffic-collector \
  --restart always \
  --network host \
  --cpus="0.5" \
  --memory="512m" \
  -e AKTO_TRAFFIC_BATCH_TIME_SECS=10 \
  -e AKTO_TRAFFIC_BATCH_SIZE=100 \
  -e AKTO_INFRA_MIRRORING_MODE=gcp \
  -e AKTO_KAFKA_BROKER_MAL="<AKTO_NLB>:9092" \
  -e AKTO_MONGO_CONN=mongodb://0.0.0.0:27017 \
  public.ecr.aws/aktosecurity/mirror-api-logging:k8s_agent
```

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `<!--email_off-->help@akto.io<!--/email_off-->` for email support.
4. Contact us [here](https://www.akto.io/contact-us).