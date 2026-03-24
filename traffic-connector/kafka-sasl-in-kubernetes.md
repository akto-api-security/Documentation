# Configure Kafka broker and producers to use SASL authentication

We can configure kafka which is deployed as part of the hybrid runtime setup to use SASL as authentication for all producers and consumers connecting to kafka.

Steps:

1. Install the helm chart for [hybrid-saas](../getting-started/quick-start-with-akto-cloud/hybrid-saas.md#helm-chart) and add the following attributes at the end of the helm install command. This will configure kafka to use SASL authentication:

```bash
--set mini_runtime.kafka1.useSasl=true \
--set mini_runtime.kafka1.env.saslUsername=<your_username> \
--set mini_runtime.kafka1.env.saslPassword=<your_password>\
--set mini_runtime.zoo1.env.saslPassword=<your_password>
```

2. Configure producers to use SASL authentication.

    1. Traffic connectors which are generally deployed as daemonsets need to be configured to use SASL authentication to send data to the kafka broker. Here is the updated configuration for the [kubernetes connector](./kubernetes/kubernetes.md#setting-up-akto-daemonset-pod-on-your-k8s-cluster) with SASL authentication:

    ```bash
    apiVersion: apps/v1
    kind: DaemonSet
    metadata:
      name: akto-k8s
      namespace: {NAMESPACE}
      labels:
        app: akto-collector
    spec:
      selector:
        matchLabels:
          app: akto-collector
      template:
        metadata:
          labels:
            app: akto-collector
        spec:
          hostNetwork: true
          dnsPolicy: ClusterFirstWithHostNet
          containers:
          - name: mirror-api-logging
            image: aktosecurity/mirror-api-logging:k8s_agent
            env: 
              - name: AKTO_TRAFFIC_BATCH_TIME_SECS
                value: "10"
              - name: AKTO_TRAFFIC_BATCH_SIZE
                value: "100"
              - name: AKTO_INFRA_MIRRORING_MODE
                value: "gcp"
              - name: AKTO_KAFKA_BROKER_MAL
                value: "<AKTO_NLB_IP>:9092"
              - name: AKTO_MONGO_CONN
                value: "mongodb://0.0.0.0:27017"
            # SASL authentication configuration
              - name: IS_AUTH_IMPLEMENTED
                value: "true"
              - name: KAFKA_USERNAME
                value: "<your_username>"
              - name: KAFKA_PASSWORD
                value: "<your_password>"
    ```

    2. For Docker-based traffic connectors, add the following environment variables:

    ```bash
    # SASL authentication environment variables for Docker
    -e IS_AUTH_IMPLEMENTED=true \
    -e KAFKA_USERNAME=<your_username> \
    -e KAFKA_PASSWORD=<your_password>
    ```

    3. Similar configuration can also be added to the [eBPF](../traffic-connector/ebpf/ebpf.md) traffic connector.
    4. For Docker-based traffic collectors, add the following:
    ```bash
    # SASL authentication environment variables for Docker
    -e KAFKA_AUTH_ENABLED=true \
    -e KAFKA_USERNAME=<your_username> \
    -e KAFKA_PASSWORD=<your_password>
    ```

### Note:

1. For SASL authentication, ensure that your Kafka broker is configured to use SASL/PLAIN authentication mechanism.
2. Replace `<your_username>` and `<your_password>` with your actual Kafka credentials in both the traffic connector configuration and Helm chart parameters.
3. If you want to configure both TLS and SASL plain authentication to kafka, configure the env variables from above and follow the [KAFKA-TLS](./kafka-tls-in-kubernetes.md) documentation
4. To customize the helm chart you may take reference from [helm-charts](https://github.com/akto-api-security/helm-charts/tree/master/charts/mini-runtime).

### Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
