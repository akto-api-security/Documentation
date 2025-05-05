# Configure Kafka broker and producers to use TLS

We can configure kafka which is deployed as part of the hybrid runtime setup to use TLS for all producers.

Steps:

1. Create `openssl-san.cnf` file with the content below. This file configures the SAN for the certificates we will create in the next step.

```bash
[ req ]
distinguished_name = req_distinguished_name
req_extensions = v3_req
prompt = no

[ req_distinguished_name ]
CN = kafka-broker

[ v3_req ]
basicConstraints = CA:FALSE
keyUsage = digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names

[ alt_names ]
DNS.1 = akto-mini-runtime-mini-runtime.default.svc.cluster.local
```

2. Create certificates stores and certificate authority. The script below will create `ca-cert.pem`, `server.keystore.jks` and `server.truststore.jks`.

```bash
#!/bin/bash

# Create the CA key
openssl genrsa -out ca-key.pem 4096

# Create the CA cert
openssl req -x509 -new -key ca-key.pem -out ca-cert.pem -days 365 \
  -subj "/CN=MyKafkaCA"

keytool -genkeypair -alias kafka-server \
  -keyalg RSA -keysize 2048 \
  -keystore server.keystore.jks \
  -storetype PKCS12 \
  -dname "CN=kafka-broker" \
  -validity 365 \
  -storepass password -keypass password

keytool -certreq -alias kafka-server \
  -keystore server.keystore.jks \
  -file kafka-server.csr \
  -storepass password

openssl x509 -req \
  -in kafka-server.csr \
  -CA ca-cert.pem -CAkey ca-key.pem -CAcreateserial \
  -out kafka-server-signed.crt \
  -days 365 \
  -extensions v3_req \
  -extfile openssl-san.cnf

# Import CA
keytool -keystore server.keystore.jks \
  -alias CARoot \
  -import -file ca-cert.pem \
  -storepass password -noprompt

# Import signed cert
keytool -keystore server.keystore.jks \
  -alias kafka-server \
  -import -file kafka-server-signed.crt \
  -storepass password

keytool -keystore server.truststore.jks \
  -alias CARoot \
  -import -file ca-cert.pem \
  -storepass password -noprompt
```

3. Crete secret in kubernetes cluster to store these certificates.

```bash
kubectl create secret generic kafka-certs \
  --from-file=server.keystore.jks \
  --from-file=server.truststore.jks \
  --from-file=ca-cert.pem
```

4. Install the helm chart for [hybrid-saas](../getting-started/quick-start-with-akto-cloud/hybrid-saas.md#helm-chart) and add the following attribute at the end of the helm install command. This will configure kafka to use TLS on port `9093`.

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
                value: "<AKTO_NLB_IP>:9093"
              - name: AKTO_MONGO_CONN
                value: "mongodb://0.0.0.0:27017"
            # additional configuration
              - name: USE_TLS
                value: "true"
              - name: TLS_CA_CERT_PATH
                value: "/app/certs/ca-cert.pem"
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

1. You can disable hostname verification as well by adding `INSECURE_SKIP_VERIFY` environment variable in the traffic connector and setting its value as `true`.
2. You might need to change the value of `DNS.1` based on your deployment in step 4. In that case, recreate the certificates after deploying the helm chart and use them.
3. To customize the helm chart you may take reference from [helm-charts](https://github.com/akto-api-security/helm-charts/tree/master/charts/mini-runtime).

### Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
