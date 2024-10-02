# Connect Akto with AWS ECS

## Introduction

Learn about how to send API traffic data from AWS ECS setup to Akto from your environment. 
Depending on your ECS infrastructure type refer to these respective sections:
1. [FARGATE infrastructure](#adding-akto-traffic-collector-to-ecs-fargate-cluster) 
2. [EC2 instances infrastructure](#adding-akto-traffic-collector-to-ecs-ec2-instances-cluster)

## Adding Akto traffic collector to ECS FARGATE cluster

When the ECS cluster is running on AWS FARGATE infrastructure, we will add a container to the task definition of the task, from which we want to monitor. Refer the below image to check your cluster type. <figure><img src="../../.gitbook/assets/ecs-2.png" alt="ECS FARGATE infrastructure type"><figcaption><p>ECS FARGATE infrastructure type</p></figcaption></figure>

1. Setup Akto data processor using the guide [here](./data-processor.md). Keep the values `AKTO_MONGO_IP` and `AKTO_NLB_IP` handy, as we will need them later.

2. Add a container with the configuration defined below. Please replace the `AKTO_MONGO_IP` and `AKTO_NLB_IP` variables, as obtained from [step 1](#adding-akto-traffic-collector-to-ecs-fargate-cluster).

    ```bash
    {
        "name": "mirror-api-logging",
        "image": "aktosecurity/mirror-api-logging:k8s_agent",
        "cpu": 1024,
        "memory": 1024,
        "portMappings": [],
        "essential": false,
        "environment": [
            {
                "name": "AKTO_TRAFFIC_BATCH_TIME_SECS",
                "value": "10"
            },
            {
                "name": "AKTO_MONGO_CONN",
                "value": "mongodb://<AKTO_MONGO_IP>:27017/admini"
            },
            {
                "name": "AKTO_TRAFFIC_BATCH_SIZE",
                "value": "10"
            },
            {
                "name": "AKTO_INFRA_MIRRORING_MODE",
                "value": "gcp"
            },
            {
                "name": "AKTO_KAFKA_BROKER_MAL",
                "value": "<AKTO_NLB_IP>:9092"
            }
        ],
        "environmentFiles": [],
        "mountPoints": [],
        "volumesFrom": [],
        "systemControls": []
    }
    ```
    <figure><img src="../../.gitbook/assets/ecs-1.png" alt="ECS task definition"><figcaption><p>ECS task definition</p></figcaption></figure>

3. After adding this definition to the task, update the task revision in the service. <figure><img src="../../.gitbook/assets/ecs-3.png" alt="Update ECS service"><figcaption><p>Update ECS service</p></figcaption></figure>
    
4. The containers for the task should show both your primary container and mirror-api-logging container. <figure><img src="../../.gitbook/assets/ecs-4.png" alt="Updated service"><figcaption><p>Updated service</p></figcaption></figure>
