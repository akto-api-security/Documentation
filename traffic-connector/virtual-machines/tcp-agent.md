# Connect Akto with TCP Agent

## Introduction

You can use Akto traffic collectors to collect and send traffic to Akto. Your APIs from this traffic will show up in Akto dashboard.

## Adding Akto traffic processor

1. Set up and configure Akto Traffic Processor and save the mini-runtime service URL. The steps are mentioned [here](https://docs.akto.io/getting-started/traffic-processor/hybrid-saas). Alternatively, if you're on on-premise deployment, save the runtime service URL.

## Adding Akto traffic collector container

1. Start a docker service `aktosecurity/mirror-api-logging:k8s_agent` to any instance you want to collect traffic&#x20;

2. Set the following env variables. 
    1. Replace `<AKTO_NLB>` with the mini-runtime/runtime service URL saved earlier.

```
export AKTO_TRAFFIC_BATCH_TIME_SECS=10
export AKTO_TRAFFIC_BATCH_SIZE=100
export AKTO_INFRA_MIRRORING_MODE=gcp
export AKTO_KAFKA_BROKER_MAL=<AKTO_NLB>:9092
```

3. (Optional) Add automated tags, to see which instance or environment each API collection came from. Set `AKTO_INJECT_TAGS` with `key=value` pairs separated by `;`. Each pair shows up as a tag on the collections created from this collector's traffic. Learn more in [Automated Tags](../../api-inventory/how-to/set-tags.md#automated-tags).

```
export AKTO_INJECT_TAGS="SOURCE=<INSTANCE_OR_ENV_NAME>"
```

4. Launch docker in your server instance.
