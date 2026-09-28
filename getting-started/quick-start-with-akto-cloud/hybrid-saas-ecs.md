---
description: Deploy the Akto mini-runtime, Kafka, and threat detection on Amazon ECS.
---

# Deploy mini-runtime and Kafka on ECS

Deploy the Hybrid SaaS traffic aggregator as one ECS service. The task runs Kafka, mini-runtime, threat detection, and Redis.

Run one task. Each extra task starts another Kafka broker with its own disk, and the load balancer can send the next client connection to a different task. Mini-runtime only reads the Kafka inside its own task, so that traffic is lost.

| Container | Image | Role |
| --- | --- | --- |
| `kafka` | `public.ecr.aws/aktosecurity/confluentinc-cp-kafka:8.2.0-1-ubi9` | Receives API logs from traffic connectors |
| `akto-mini-runtime` | `public.ecr.aws/aktosecurity/akto-api-security-mini-runtime:latest` | Reads Kafka and sends traffic to Akto Cloud |
| `threat-detection` | `public.ecr.aws/aktosecurity/akto-threat-detection:latest` | Threat detection for the hybrid runtime |
| `redis` | `public.ecr.aws/aktosecurity/redis:latest` | Local store for threat detection |

Containers in the task share one network namespace. Mini-runtime, threat detection, and Redis use `127.0.0.1`. Traffic connectors use the load balancer DNS name.

## Prerequisites

1. Go to [app.akto.io](https://app.akto.io) and open Quick Start > Hybrid SaaS Connector > Connect.
2. Copy the database abstractor token. The same value is used for `DATABASE_ABSTRACTOR_SERVICE_TOKEN` and `AKTO_THREAT_PROTECTION_BACKEND_TOKEN`.
3. Use an ECS cluster whose tasks can reach the internet. Mini-runtime calls `https://ultron.akto.io`. Threat detection calls `https://tbs.akto.io`.
4. Create two security groups.
   1. Load balancer: inbound TCP `9092` from your traffic connectors.
   2. Task: inbound TCP `9092` from the load balancer security group, and outbound traffic so the task can reach Akto Cloud.

## Create the load balancer

Create an internal Network Load Balancer before the task. Its DNS name is what Kafka advertises, and connectors keep using that name when ECS replaces the task.

1. Create a target group. Target type is `ip`. Leave it empty. The ECS service registers the task.

```bash
aws elbv2 create-target-group \
  --name akto-kafka \
  --protocol TCP \
  --port 9092 \
  --vpc-id <vpc-id> \
  --target-type ip \
  --health-check-protocol TCP \
  --health-check-port 9092 \
  --region <aws-region>
```

2. Create the load balancer in the subnets the service will use. Use at least two Availability Zones. Copy the DNS name. That value is `<NLB_DNS>`.

```bash
aws elbv2 create-load-balancer \
  --name akto-kafka \
  --type network \
  --scheme internal \
  --subnets <subnet-id-a> <subnet-id-b> \
  --security-groups <nlb-security-group-id> \
  --region <aws-region>
```

3. Turn on cross-zone load balancing so connectors in any subnet reach the task.

```bash
aws elbv2 modify-load-balancer-attributes \
  --load-balancer-arn <nlb-arn> \
  --attributes Key=load_balancing.cross_zone.enabled,Value=true \
  --region <aws-region>
```

4. Forward TCP `9092` to the target group.

```bash
aws elbv2 create-listener \
  --load-balancer-arn <nlb-arn> \
  --protocol TCP \
  --port 9092 \
  --default-actions Type=forward,TargetGroupArn=<target-group-arn> \
  --region <aws-region>
```

## Register the task definition

`AmazonECSTaskExecutionRolePolicy` cannot create a log group. Add that permission once. The task creates `/ecs/akto-mini-runtime` on startup.

```bash
aws iam put-role-policy \
  --role-name <execution-role-name> \
  --policy-name ecs-create-log-group \
  --policy-document '{"Version":"2012-10-17","Statement":[{"Effect":"Allow","Action":"logs:CreateLogGroup","Resource":"*"}]}'
```

In the JSON below, replace `<NLB_DNS>` with the load balancer DNS name, `<DATABASE_ABSTRACTOR_SERVICE_TOKEN>` with the dashboard token, `<aws-region>`, and `<ecsTaskExecutionRoleArn>`. Replace `<your_mini_runtime_name>` with a name such as `staging_runtime`, or delete that environment entry.

The Kafka `command` starts the broker, then creates the `akto.api.logs` topic. Kafka advertises `<NLB_DNS>:9092`. The other containers use `127.0.0.1:19092`.

```json
{
    "family": "akto-mini-runtime",
    "networkMode": "awsvpc",
    "requiresCompatibilities": ["FARGATE"],
    "cpu": "4096",
    "memory": "20480",
    "executionRoleArn": "<ecsTaskExecutionRoleArn>",
    "runtimePlatform": {
        "cpuArchitecture": "X86_64",
        "operatingSystemFamily": "LINUX"
    },
    "containerDefinitions": [
        {
            "name": "kafka",
            "image": "public.ecr.aws/aktosecurity/confluentinc-cp-kafka:8.2.0-1-ubi9",
            "essential": true,
            "user": "0",
            "cpu": 1024,
            "memory": 4096,
            "entryPoint": ["bash", "-c"],
            "command": [
                "/etc/confluent/docker/run & kpid=$!; trap 'kill $kpid' TERM INT; for i in $(seq 1 60); do kafka-topics --bootstrap-server 127.0.0.1:19092 --list >/dev/null 2>&1 && break; sleep 2; done; kafka-topics --bootstrap-server 127.0.0.1:19092 --create --if-not-exists --topic akto.api.logs --partitions 3 --replication-factor 1; wait $kpid"
            ],
            "portMappings": [
                {
                    "containerPort": 9092,
                    "hostPort": 9092,
                    "protocol": "tcp"
                }
            ],
            "environment": [
                { "name": "KAFKA_PROCESS_ROLES", "value": "broker,controller" },
                { "name": "KAFKA_NODE_ID", "value": "1" },
                { "name": "KAFKA_BROKER_ID", "value": "1" },
                { "name": "KAFKA_CONTROLLER_LISTENER_NAMES", "value": "CONTROLLER" },
                { "name": "KAFKA_CONTROLLER_QUORUM_VOTERS", "value": "1@127.0.0.1:9094" },
                { "name": "KAFKA_CLUSTER_ID", "value": "c6a1b8e2-4f2a-4b2a-9c3f-1a2b3c4d5e6f" },
                {
                    "name": "KAFKA_LISTENERS",
                    "value": "CONTROLLER://0.0.0.0:9094,LISTENER_DOCKER_EXTERNAL_DIFFHOST://0.0.0.0:9092,LISTENER_DOCKER_INTERNAL://0.0.0.0:19092"
                },
                {
                    "name": "KAFKA_ADVERTISED_LISTENERS",
                    "value": "LISTENER_DOCKER_EXTERNAL_DIFFHOST://<NLB_DNS>:9092,LISTENER_DOCKER_INTERNAL://127.0.0.1:19092"
                },
                {
                    "name": "KAFKA_LISTENER_SECURITY_PROTOCOL_MAP",
                    "value": "CONTROLLER:PLAINTEXT,LISTENER_DOCKER_EXTERNAL_DIFFHOST:PLAINTEXT,LISTENER_DOCKER_INTERNAL:PLAINTEXT"
                },
                { "name": "KAFKA_INTER_BROKER_LISTENER_NAME", "value": "LISTENER_DOCKER_INTERNAL" },
                { "name": "KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR", "value": "1" },
                { "name": "KAFKA_TRANSACTION_STATE_LOG_REPLICATION_FACTOR", "value": "1" },
                { "name": "KAFKA_TRANSACTION_STATE_LOG_MIN_ISR", "value": "1" },
                { "name": "KAFKA_LOG_RETENTION_CHECK_INTERVAL_MS", "value": "60000" },
                { "name": "KAFKA_LOG_RETENTION_HOURS", "value": "5" },
                { "name": "KAFKA_LOG_SEGMENT_BYTES", "value": "104857600" },
                { "name": "KAFKA_LOG_CLEANER_ENABLE", "value": "true" },
                { "name": "KAFKA_CLEANUP_POLICY", "value": "delete" },
                { "name": "KAFKA_LOG_RETENTION_BYTES", "value": "10737418240" }
            ],
            "healthCheck": {
                "command": ["CMD-SHELL", "kafka-broker-api-versions --bootstrap-server 127.0.0.1:19092 >/dev/null 2>&1 || exit 1"],
                "interval": 30,
                "timeout": 10,
                "retries": 5,
                "startPeriod": 120
            },
            "logConfiguration": {
                "logDriver": "awslogs",
                "options": {
                    "awslogs-create-group": "true",
                    "awslogs-group": "/ecs/akto-mini-runtime",
                    "awslogs-region": "<aws-region>",
                    "awslogs-stream-prefix": "kafka"
                }
            }
        },
        {
            "name": "redis",
            "image": "public.ecr.aws/aktosecurity/redis:latest",
            "essential": true,
            "cpu": 512,
            "memory": 2048,
            "healthCheck": {
                "command": ["CMD", "redis-cli", "ping"],
                "interval": 30,
                "timeout": 5,
                "retries": 3,
                "startPeriod": 10
            },
            "logConfiguration": {
                "logDriver": "awslogs",
                "options": {
                    "awslogs-create-group": "true",
                    "awslogs-group": "/ecs/akto-mini-runtime",
                    "awslogs-region": "<aws-region>",
                    "awslogs-stream-prefix": "redis"
                }
            }
        },
        {
            "name": "akto-mini-runtime",
            "image": "public.ecr.aws/aktosecurity/akto-api-security-mini-runtime:latest",
            "essential": true,
            "cpu": 1536,
            "memory": 8192,
            "dependsOn": [
                {
                    "containerName": "kafka",
                    "condition": "HEALTHY"
                }
            ],
            "environment": [
                { "name": "AKTO_CONFIG_NAME", "value": "staging" },
                { "name": "AKTO_KAFKA_TOPIC_NAME", "value": "akto.api.logs" },
                { "name": "AKTO_KAFKA_BROKER_URL", "value": "127.0.0.1:19092" },
                { "name": "AKTO_KAFKA_BROKER_MAL", "value": "127.0.0.1:19092" },
                { "name": "AKTO_KAFKA_GROUP_ID_CONFIG", "value": "asdf" },
                { "name": "AKTO_KAFKA_MAX_POLL_RECORDS_CONFIG", "value": "100" },
                { "name": "AKTO_ACCOUNT_NAME", "value": "Helios" },
                { "name": "AKTO_TRAFFIC_BATCH_SIZE", "value": "100" },
                { "name": "AKTO_TRAFFIC_BATCH_TIME_SECS", "value": "10" },
                { "name": "USE_HOSTNAME", "value": "true" },
                { "name": "AKTO_INSTANCE_TYPE", "value": "RUNTIME" },
                { "name": "DATABASE_ABSTRACTOR_SERVICE_URL", "value": "https://ultron.akto.io" },
                { "name": "DATABASE_ABSTRACTOR_SERVICE_TOKEN", "value": "<DATABASE_ABSTRACTOR_SERVICE_TOKEN>" },
                { "name": "RUNTIME_MODE", "value": "hybrid" },
                { "name": "AKTO_THREAT_ENABLED", "value": "true" },
                { "name": "MINI_RUNTIME_NAME", "value": "<your_mini_runtime_name>" }
            ],
            "logConfiguration": {
                "logDriver": "awslogs",
                "options": {
                    "awslogs-create-group": "true",
                    "awslogs-group": "/ecs/akto-mini-runtime",
                    "awslogs-region": "<aws-region>",
                    "awslogs-stream-prefix": "mini-runtime"
                }
            }
        },
        {
            "name": "threat-detection",
            "image": "public.ecr.aws/aktosecurity/akto-threat-detection:latest",
            "essential": true,
            "cpu": 1024,
            "memory": 4096,
            "dependsOn": [
                {
                    "containerName": "kafka",
                    "condition": "HEALTHY"
                },
                {
                    "containerName": "redis",
                    "condition": "HEALTHY"
                }
            ],
            "environment": [
                { "name": "AKTO_TRAFFIC_KAFKA_BOOTSTRAP_SERVER", "value": "127.0.0.1:19092" },
                { "name": "AKTO_INTERNAL_KAFKA_BOOTSTRAP_SERVER", "value": "127.0.0.1:19092" },
                { "name": "AKTO_THREAT_PROTECTION_BACKEND_URL", "value": "https://tbs.akto.io" },
                { "name": "RUNTIME_MODE", "value": "hybrid" },
                { "name": "AKTO_THREAT_PROTECTION_BACKEND_TOKEN", "value": "<DATABASE_ABSTRACTOR_SERVICE_TOKEN>" },
                { "name": "DATABASE_ABSTRACTOR_SERVICE_TOKEN", "value": "<DATABASE_ABSTRACTOR_SERVICE_TOKEN>" },
                { "name": "AKTO_LOG_LEVEL", "value": "DEBUG" },
                { "name": "AGGREGATION_RULES_ENABLED", "value": "true" },
                { "name": "AKTO_THREAT_DETECTION_LOCAL_REDIS_URI", "value": "redis://127.0.0.1:6379" }
            ],
            "logConfiguration": {
                "logDriver": "awslogs",
                "options": {
                    "awslogs-create-group": "true",
                    "awslogs-group": "/ecs/akto-mini-runtime",
                    "awslogs-region": "<aws-region>",
                    "awslogs-stream-prefix": "threat-detection"
                }
            }
        }
    ]
}
```

Register it with the AWS CLI or paste it into the ECS console as a new task definition revision:

```bash
aws ecs register-task-definition --cli-input-json file://akto-mini-runtime-task.json
```

## Create the service

Create an ECS service from the `akto-mini-runtime` task definition and attach the `kafka` container to the target group. Leave the desired count at `1`. The grace period gives Kafka time to open port `9092` before a failed health check fails the deployment.

```bash
aws ecs create-service \
  --cluster <cluster-name> \
  --service-name akto-mini-runtime \
  --task-definition akto-mini-runtime \
  --desired-count 1 \
  --launch-type FARGATE \
  --health-check-grace-period-seconds 180 \
  --network-configuration "awsvpcConfiguration={subnets=[<subnet-id>],securityGroups=[<task-security-group-id>],assignPublicIp=DISABLED}" \
  --load-balancers "targetGroupArn=<target-group-arn>,containerName=kafka,containerPort=9092" \
  --region <aws-region>
```

Set `assignPublicIp` to `ENABLED` when the subnets have no NAT gateway. Without a public IP or a NAT gateway, Fargate cannot pull the images or reach Akto Cloud.

Wait until the target group is healthy and all four containers are running.

## Send traffic to this Kafka broker

On each traffic connector, set:

```bash
AKTO_KAFKA_BROKER_MAL=<NLB_DNS>:9092
```

Example: `akto-kafka-a1b2c3.elb.ap-south-1.amazonaws.com:9092`.

```bash
nc -vz <NLB_DNS> 9092
```

## Notes

1. When ECS replaces the task, it registers the new IP on the same load balancer. Connectors keep the same `AKTO_KAFKA_BROKER_MAL`.
2. Broker log data does not survive a new task.
3. In a closed network, allow outbound HTTPS to `https://ultron.akto.io` and `https://tbs.akto.io`.

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
