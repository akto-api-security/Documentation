# Configure External Kafka Broker for Mini Runtime

You can configure the mini_runtime deployment to connect to an external Kafka broker instead of deploying a built-in Kafka instance. This is useful when you want to use a managed Kafka service or share a Kafka cluster across multiple deployments.

## Features

- Support for external Kafka brokers (single or multiple brokers)
- SASL/PLAIN authentication support

## Prerequisites

Before configuring an external Kafka broker, ensure:

1. Your Kafka broker is accessible from your Kubernetes cluster
2. Required Kafka topics are created
3. If using SASL authentication, you have valid credentials
4. Network connectivity is established between Kubernetes pods and Kafka broker

## Configuration Steps

### Step 1: Set Up Your Kafka Cluster

You can use a managed Kafka service from cloud providers or set up your own Kafka cluster. Below are links to official documentation for creating Kafka clusters on major cloud platforms:

#### Cloud-Managed Kafka Services

**Amazon Web Services (AWS):**
- **Amazon MSK (Managed Streaming for Apache Kafka)**
  - [Getting Started with Amazon MSK](https://docs.aws.amazon.com/msk/latest/developerguide/getting-started.html)

**Google Cloud Platform (GCP):**
- **Apache Kafka**
  - [Apache Kafka on GCP](https://cloud.google.com/products/managed-service-for-apache-kafka?hl=en)

**Microsoft Azure:**
- **Azure Event Hubs for Apache Kafka**
  - [Event Hubs for Kafka Overview](https://learn.microsoft.com/en-us/azure/event-hubs/azure-event-hubs-kafka-overview)

#### Create Required Kafka Topics

Regardless of which platform you choose, ensure the following topics are created:

**Required Topics:**
- `akto.api.logs` (recommended: 3 partitions, replication factor 3 for production)
- `akto.api.producer.logs` (recommended: 3 partitions, replication factor 3 for production)

**Note:** Many managed Kafka services support automatic topic creation. If enabled, topics will be created automatically when the application first connects.

### Step 2: Determine Kafka Broker Address

Obtain the broker address (hostname:port or IP:port) that is accessible from your Kubernetes cluster. Ensure the address is routable from within your cluster and not using `localhost`, `127.0.0.1`, or `host.docker.internal`.

### Step 3: Install Mini Runtime with External Kafka

#### For Kafka Without Authentication:

Create a values file (`custom-kafka-values.yaml`):

```yaml
mini_runtime:
  useExternalKafka: true
  externalKafka:
    brokerUrl: "<YOUR_HOST_IP>:9093"  # External listener address
    username: ""  # Empty for no authentication
    password: ""  # Empty for no authentication
```

Install or upgrade the Helm chart:

```bash
helm install akto-runtime ./charts/mini-runtime \
  -f custom-kafka-values.yaml \
  -n akto \
  --create-namespace \
  --set mini_runtime.aktoApiSecurityRuntime.env.databaseAbstractorToken="<YOUR_TOKEN>"
```

#### For Kafka With SASL Authentication:

Create a values file (`custom-kafka-sasl-values.yaml`):

```yaml
mini_runtime:
  useExternalKafka: true
  externalKafka:
    brokerUrl: "<YOUR_HOST_IP>:9093"  # External SASL listener address
    username: "aktouser"  # Your Kafka SASL username
    password: "akto-password"  # Your Kafka SASL password
```

Install or upgrade the Helm chart:

```bash
helm install akto-runtime ./charts/mini-runtime \
  -f custom-kafka-sasl-values.yaml \
  -n akto \
  --create-namespace \
  --set mini_runtime.aktoApiSecurityRuntime.env.databaseAbstractorToken="<YOUR_TOKEN>"
```

#### Using Command-Line Parameters:

You can also configure external Kafka directly via command-line parameters:

```bash
# Without authentication
helm install akto-runtime ./charts/mini-runtime \
  --set mini_runtime.useExternalKafka=true \
  --set mini_runtime.externalKafka.brokerUrl="<YOUR_HOST_IP>:9093" \
  --set mini_runtime.externalKafka.username="" \
  --set mini_runtime.externalKafka.password="" \
  --set mini_runtime.aktoApiSecurityRuntime.env.databaseAbstractorToken="<YOUR_TOKEN>" \
  -n akto \
  --create-namespace

# With SASL authentication
helm install akto-runtime ./charts/mini-runtime \
  --set mini_runtime.useExternalKafka=true \
  --set mini_runtime.externalKafka.brokerUrl="<YOUR_HOST_IP>:9093" \
  --set mini_runtime.externalKafka.username="aktouser" \
  --set mini_runtime.externalKafka.password="akto-password" \
  --set mini_runtime.aktoApiSecurityRuntime.env.databaseAbstractorToken="<YOUR_TOKEN>" \
  -n akto \
  --create-namespace
```

### Step 4: Verify Connection

Check that the mini_runtime pods are connecting to Kafka successfully:

```bash
# Get the pod name
kubectl get pods -n akto

# Check logs for successful Kafka connection
kubectl logs <mini-runtime-pod-name> -n akto | grep -i "kafka\|consumer"

# You should see messages like:
# "Successfully synced group in generation"
# "Discovered group coordinator"
# "Adding newly assigned partitions"
```

## Troubleshooting

### Connection Refused Errors

If you see errors like "Connection to node -1 could not be established":

1. **Verify Kafka is running:**
   ```bash
   docker ps | grep kafka
   docker logs <kafka-container-name>
   ```

2. **Test network connectivity:**
   ```bash
   # From inside a Kubernetes pod
   kubectl run test-connectivity --rm -it --image=busybox -- sh
   # Inside the pod:
   telnet <YOUR_HOST_IP> 9093
   ```

3. **Check advertised listeners match your configuration:**
   ```bash
   docker logs <kafka-container-name> | grep "advertised.listeners"
   ```

### Authentication Failures

If you see "Failed authentication" errors in Kafka logs:

1. **Verify credentials are correct** in your values file
2. **Check JAAS configuration** matches the username/password
3. **Ensure SASL mechanism is PLAIN:**
   ```bash
   kubectl get deployment <mini-runtime-deployment> -n akto -o yaml | grep SASL
   ```

### DNS Resolution Issues

If you see "UnknownHostException" errors:

1. Use IP addresses instead of hostnames
2. Test DNS resolution from within the cluster:
   ```bash
   kubectl run test-dns --rm -it --image=busybox -- nslookup <your-hostname>
   ```

### Pods Not Starting

Check the deployment environment variables:

```bash
kubectl get deployment <mini-runtime-deployment> -n akto -o jsonpath='{.spec.template.spec.containers[0].env}' | jq '.'
```

Verify these variables are set correctly:
- `AKTO_KAFKA_BROKER_URL`
- `KAFKA_AUTH_ENABLED` (should be "true" for SASL, absent for PLAINTEXT)
- `KAFKA_USERNAME` and `KAFKA_PASSWORD` (for SASL)

## Environment Variables Set by Configuration

When you enable external Kafka, the following environment variables are automatically configured:

### Without Authentication (PLAINTEXT):
- `AKTO_KAFKA_BROKER_URL`: Your broker URL
- `AKTO_KAFKA_BROKER_MAL`: Your broker URL
- `KAFKA_AUTH_ENABLED`: Not set (defaults to false)

### With SASL Authentication:
- `AKTO_KAFKA_BROKER_URL`: Your broker URL
- `AKTO_KAFKA_BROKER_MAL`: Your broker URL
- `KAFKA_AUTH_ENABLED`: "true"
- `AKTO_KAFKA_SASL_MECHANISM`: "PLAIN"
- `KAFKA_USERNAME`: Your username
- `KAFKA_PASSWORD`: Your password