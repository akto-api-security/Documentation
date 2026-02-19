# Connect Akto with AWS API Gateway

AWS API Gateway is a fully managed service from AWS that helps developers create, publish, monitor, and secure APIs at scale. By integrating AWS API Gateway with Akto, you'll automatically discover and test the security of all your REST APIs, HTTP APIs, and WebSocket APIs deployed through API Gateway, ensuring comprehensive API security across your AWS infrastructure.

<figure><img src="../../.gitbook/assets/image (16).png" alt=""><figcaption></figcaption></figure>

To connect Akto with AWS API Gateway, follow these steps -

1. Set up and configure Akto Traffic Processor. The steps are mentioned [here](https://docs.akto.io/getting-started/traffic-processor/hybrid-saas).
2.  Add AWS API Gateway connector

    1. Go to **API gateway** in AWS console
    2.  Go to your API, click on `Stages` from the left menu.

        <figure><img src="../../.gitbook/assets/aws-api-gateway-1.png" alt=""><figcaption></figcaption></figure>
    3.  Scroll down to `Logs and tracing` section and click on `Edit`.

        <figure><img src="../../.gitbook/assets/aws-api-gateway-2.png" alt=""><figcaption></figcaption></figure>
    4.  Select `Error and info logs` and `Data tracing` and save these settings.
        ```
        { "requestId":"$context.requestId", "extendedRequestId":"$context.extendedRequestId","ip": "$context.identity.sourceIp", "caller":"$context.identity.caller", "user":"$context.identity.user", "requestTime":"$context.requestTime", "httpMethod":"$context.httpMethod", "resourcePath":"$context.resourcePath", "status":"$context.status", "protocol":"$context.protocol", "responseLength":"$context.responseLength" }
        ```
          <figure><img src="../../.gitbook/assets/aws-api-gateway-3.png" alt=""><figcaption></figcaption></figure>
    5. Find out the `cloudwatch log group` for your API gateway for the stage which has the above logs enabled and save it. We'll need it later.
    6. Deploy the connector (Kubernetes or Docker Compose).
       1. For `LOG_GROUP_NAME`, use the CloudWatch log group name (from API Gateway Stage logs).
       2. For `AWS_REGION`, use the AWS region where that log group exists.
       3. For `AKTO_KAFKA_BROKER_MAL`, use the Akto mini-runtime Kafka endpoint (`<AktoNLB-DNS>:9092`).
       4. For `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY` and `AWS_SESSION_TOKEN`, use credentials that have permission to read the above CloudWatch log group.
       5. For `DATABASE_ABSTRACTOR_TOKEN`, copy the token from Akto dashboard.
       6. Use one of the deployment options below.

### Option A: Kubernetes deployment

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: api-gateway-logging
spec:
  replicas: 1
  selector:
    matchLabels:
        app: api-gateway-logging 
  template:
    metadata:
        labels:
          app: api-gateway-logging 
    spec:
      containers:
      - image: aktosecurity/mirror-api-logging:api-gateway-logging-openapi
        name: api-gateway-logging 
        imagePullPolicy: Always
        resources: {}
        env:
          - name: AKTO_BYTES_IN_THRESHOLD
            value: "100"
          - name: AKTO_TRAFFIC_BATCH_TIME_SECS
            value: "10"
          - name: AKTO_TRAFFIC_BATCH_SIZE
            value: "100"
          - name: AKTO_KAFKA_BROKER_MAL
            value: ""
          - name: AWS_ACCESS_KEY_ID
            value: ""
          - name: AWS_SECRET_ACCESS_KEY
            value: ""
          - name: AWS_SESSION_TOKEN
            value: ""
          - name: CLOUDWATCH_READ_BATCH_SIZE
            value: "5"
          - name: LOG_GROUP_NAME
            value: ""
          - name: AWS_REGION
            value: ""
          - name: DATABASE_ABSTRACTOR_TOKEN
            value: ""
          - name: DISCOVER_OPENAPI_SPEC
            value: "true"
          - name: OPENAPI_DISCOVERY_INTERVAL_MINUTES
            value: "15"
```

### Option B: Docker Compose

Create a `docker-compose.yml` and `watchtower.env` on your connector host:

*docker-compose.yml:*
```yaml
version: "3.9"

services:
  api-gateway-logging:
    image: aktosecurity/mirror-api-logging:api-gateway-logging-openapi
    pull_policy: always
    container_name: api-gateway-logging
    restart: unless-stopped
    environment:
      AKTO_BYTES_IN_THRESHOLD: "100"
      AKTO_TRAFFIC_BATCH_TIME_SECS: "10"
      AKTO_TRAFFIC_BATCH_SIZE: "100"
      AKTO_KAFKA_BROKER_MAL: ""
      AWS_ACCESS_KEY_ID: ""
      AWS_SECRET_ACCESS_KEY: ""
      AWS_SESSION_TOKEN: ""
      CLOUDWATCH_READ_BATCH_SIZE: "5"
      LOG_GROUP_NAME: ""
      AWS_REGION: ""
      DATABASE_ABSTRACTOR_TOKEN: ""
      DISCOVER_OPENAPI_SPEC: "true"
      OPENAPI_DISCOVERY_INTERVAL_MINUTES: "15"

  watchtower:
    image: containrrr/watchtower
    restart: always
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    env_file: ./watchtower.env
    labels:
      com.centurylinklabs.watchtower.enable: "false"
```

*watchtower.env:*
```bash
WATCHTOWER_CLEANUP=true
WATCHTOWER_POLL_INTERVAL=1800
```

Run:

```bash
docker compose up -d
docker compose logs -f --tail=200 api-gateway-logging
```

## Environment variables reference

| Variable | What to set | Where to get it |
| --- | --- | --- |
| `AKTO_BYTES_IN_THRESHOLD` | Keep default (`100`) unless tuning needed | Akto connector runtime tuning value |
| `AKTO_TRAFFIC_BATCH_TIME_SECS` | Keep default (`10`) unless tuning needed | Akto connector runtime tuning value |
| `AKTO_TRAFFIC_BATCH_SIZE` | Keep default (`100`) unless tuning needed | Akto connector runtime tuning value |
| `AKTO_KAFKA_BROKER_MAL` | `<AktoNLB-DNS>:9092` | If mini-runtime is deployed using CloudFormation, go to stack **Outputs**, copy `AktoNLB`, and append `:9092` |
| `AWS_ACCESS_KEY_ID` | Access key ID | IAM user or temporary STS credentials with CloudWatch Logs read permissions |
| `AWS_SECRET_ACCESS_KEY` | Secret access key | IAM user or temporary STS credentials with CloudWatch Logs read permissions |
| `AWS_SESSION_TOKEN` | Session token if using temporary credentials | STS/assumed role session; leave empty for long-lived IAM user keys |
| `CLOUDWATCH_READ_BATCH_SIZE` | Keep default (`5`) unless tuning needed | Connector tuning value |
| `LOG_GROUP_NAME` | API Gateway execution/access log group name | CloudWatch Logs console (for your API Gateway stage) |
| `AWS_REGION` | Region of API Gateway + CloudWatch log group | AWS region (example: `ap-south-1`) |
| `DATABASE_ABSTRACTOR_TOKEN` | Database abstractor token | Akto Dashboard > Quick Start > Hybrid SaaS > Runtime Service Command section |
| `DISCOVER_OPENAPI_SPEC` | `"true"` to enable OpenAPI discovery | Connector feature flag |
| `OPENAPI_DISCOVERY_INTERVAL_MINUTES` | Discovery interval (default `15`) | Connector tuning value |

Notes:

1. To create AWS CLI credentials, you can take reference from the [official AWS docs](https://docs.aws.amazon.com/sdkref/latest/guide/access-iam-users.html).
2. For AWS IAM policy permissions for cloudwatch, you can refer [here](https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-logging.html#apigateway-cloudwatch-log-formats).

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
