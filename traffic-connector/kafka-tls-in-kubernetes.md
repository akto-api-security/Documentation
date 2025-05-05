# Configure Kafka broker and producers to use TLS

We can configure kafka which is deployed as part of the hybrid runtime setup to use TLS for all producers.

Steps:

1. Create certificates stores and certificate authority. The script below will create `ca.crt`, `kafka.server.keystore.jks` and `kafka.server.truststore.jks`.

```bash
openssl req -x509 -new -nodes -days 365 -newkey rsa:2048 -keyout ca.key -out ca.crt -subj "/CN=MyKafkaCA"

keytool -keystore kafka.server.keystore.jks -alias kafka-server -validity 365 -genkey -storepass password -keypass password -dname "CN=kafka-broker"
keytool -keystore kafka.server.keystore.jks -alias kafka-server -certreq -file kafka.server.csr -storepass password

openssl x509 -req -CA ca.crt -CAkey ca.key -in kafka.server.csr -out kafka.server.crt -days 365 -CAcreateserial
keytool -keystore kafka.server.keystore.jks -alias CARoot -import -file ca.crt -storepass password -noprompt
keytool -keystore kafka.server.keystore.jks -alias kafka-server -import -file kafka.server.crt -storepass password -noprompt

keytool -keystore kafka.server.truststore.jks -alias CARoot -import -file ca.crt -storepass password -noprompt
```

2. Crete secret in kubernetes cluster to store these certificates.

```bash
kubectl create secret generic kafka-certs \
  --from-file=kafka.server.keystore.jks \
  --from-file=kafka.server.truststore.jks \
  --from-file=ca.crt
```

3. Install the helm chart for [hybrid-saas](../getting-started/quick-start-with-akto-cloud/hybrid-saas.md#helm-chart) and add the following attribute at the end of the helm install command. This will configure kafka to use TLS on port `9093`

```bash
--set mini_runtime.kafka1.useTls=true
```

4. Configure producers to use TLS.

    1. Traffic connectors which are generally deployed as daemonsets need to be configured to use TLS to send data to the kafka broker. Here is the updated configuration for the [kubernetes connector](./kubernetes/kubernetes.md#setting-up-akto-daemonset-pod-on-your-k8s-cluster). Here, we've mounted the `ca.crt` file on the file system for the daemonset.

    ```bash
    apiVersion: apps/v1
    kind: DaemonSet
    metadata:
      name: akto-k8s
      namespace: {NAMESPACE}
      labels:
        app: {APP_NAME}
    spec:
      selector:
        matchLabels:
          app: {APP_NAME}
      template:
        metadata:
          labels:
            app: {APP_NAME}
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
                value: "<AKTO_NLB_IP>:9093"
              - name: AKTO_MONGO_CONN
                value: "mongodb://0.0.0.0:27017"
            # additional configuration
              - name: USE_TLS
                value: "true"
              - name: TLS_CA_CERT_PATH
                value: "/app/certs/ca.crt"
            volumeMounts:
              - name: kafka-certs
                mountPath: /app/certs
          volumes:
            - name: kafka-certs
              secret:
                secretName: kafka-certs
    ```

    2. Similar configuration can also be added to the [eBPF](../traffic-connector/ebpf/ebpf.md) traffic connector.

### Note:

1. You can also enable hostname verification for added security.

### Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
