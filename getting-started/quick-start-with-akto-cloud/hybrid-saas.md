---
description: Learn how to send API traffic data to Akto SaaS from your cloud setup.
---

# Connect Akto with Hybrid SaaS

1\. Go to [app.akto.io](https://app.akto.io)

2\. Login/Signup into your account.

3\. Click on Quick Start tab in left nav.

<figure><img src="../../.gitbook/assets/Quick-Start.png" alt=""><figcaption></figcaption></figure>

4\. Search for Hybrid SaaS Connector and click connect.

<figure><img src="../../.gitbook/assets/HybridSaaSConnector.png" alt=""><figcaption></figcaption></figure>

### Installing Traffic connector

You can use either a CloudFormation template, Terraform template or a Helm chart to install Traffic aggregator in your env.&#x20;

#### Terraform

1. To install using Terraform, use the Terraform script [here](https://github.com/akto-api-security/infra/blob/mini\_runtime\_tf\_script/templates/mini-runtime.tf).
   1. Please make sure you install it in a private subnet from your application VPC.&#x20;
   2. This private subnet should also have network connectivity (typically via NAT).&#x20;
2. You can use `https://cyborg.akto.io` as `DatabaseAbstractorUrl` . For `DatabaseAbstractorToken` you can copy it from the helm install command in the above screenshot.&#x20;
3. Once complete, copy `akto_nlb_dns` from the output.&#x20;
4. The next step is to install a traffic connector.&#x20;
   1. You can use the above copied `AktoNLBIP` as `AKTO_KAFKA_BROKER_MAL` in your traffic connectors. Note that `AKTO_KAFKA_BROKER_MAL` is inclusive of port (eg `akto-N-.....amazonaws.com:9092`)

#### CloudFormation template

1. To install using CloudFormation, run the Cloudformation template [here](https://raw.githubusercontent.com/akto-api-security/infra/feature/quick-setup/templates/mini-runtime.yml).&#x20;

&#x20;     i) Please make sure you install it in a private subnet from your application VPC.&#x20;

&#x20;     ii) This private subnet should also have network connectivity (typically via NAT).&#x20;

2. You can use `https://cyborg.akto.io` as `DatabaseAbstractorUrl` . For `DatabaseAbstractorToken` you can copy it from the helm install command in the above screenshot.&#x20;
3. Once complete, go to the **Output** section of CloudFormation Stack and copy `AktoNLBIP`.&#x20;
4. The next step is to install a traffic connector.&#x20;
   1. You can use the above copied `AktoNLBIP` as `AKTO_KAFKA_BROKER_MAL` in your traffic connectors. Note that `AKTO_KAFKA_BROKER_MAL` is inclusive of port (eg `akto-N-.....amazonaws.com:9092`)

#### Helm chart

1\. If you have K8s clusters, you can use helm chart to install Traffic aggregator. 

2\. Add akto helm repository.

```bash
helm repo add akto https://akto-api-security.github.io/helm-charts/
```

<figure><img src="../../.gitbook/assets/helm-repo-add.png" alt=""><figcaption></figcaption></figure>

3. Install akto-mini-runtime helm chart in your kubernetes cluster.

      1. Directly using database abstractor token

         ```bash
         helm install akto-mini-runtime akto/akto-mini-runtime -n <your-namespace> --set mini_runtime.aktoApiSecurityRuntime.env.databaseAbstractorToken="<your-database-abstractor-token>"
         ```

      2. Storing the database abstractor token in a secret

         ```bash
         helm install akto-mini-runtime akto/akto-mini-runtime -n <your-namespace> --set mini_runtime.aktoApiSecurityRuntime.env.useSecretsForDatabaseAbstractorToken=true --set mini_runtime.aktoApiSecurityRuntime.env.databaseAbstractorTokenSecrets.token="<your-database-abstractor-token>"
         ```

      3. Bring your own secret which has the database abstractor token

         ```bash
         helm install akto-mini-runtime akto/akto-mini-runtime -n <your-namespace> --set mini_runtime.aktoApiSecurityRuntime.env.useSecretsForDatabaseAbstractorToken=true --set mini_runtime.aktoApiSecurityRuntime.env.databaseAbstractorTokenSecrets.existingSecret=<my-secret>
         ```

<figure><img src="../../.gitbook/assets/helm-repo-install.png" alt=""><figcaption></figcaption></figure>


4\. Running the above commands in your k8s cluster will deploy a new Akto Traffic aggregator service.

5\. Run the below command and copy the `CLUSTER-IP` and `PORT` value for Traffic aggregator  service. In the below example it will be `10.0.23.145:9092`. You can also use the kubernetes service ip, which in this case will be `akto-mini-runtime-mini-runtime.dev.svc.cluster.local:9092`

```bash
kubectl get svc -n <namespace>
```

<figure><img src="../../.gitbook/assets/mini-runtime-ip-1.png" alt=""><figcaption></figcaption></figure>

6\. The next step is to install a traffic connector.&#x20;

1. You can use the above copied `IP:PORT` value as `AKTO_KAFKA_BROKER_MAL` in your traffic connectors. Note that `AKTO_KAFKA_BROKER_MAL` is inclusive of port (eg `10.0.23.145:9092` , `akto-mini-runtime-mini-runtime.dev.svc.cluster.local:9092`)

<figure><img src="../../.gitbook/assets/mini-runtime-ip-2.png" alt=""><figcaption></figcaption></figure>

### Linux VM

1. Create a new instance with the following requirements
   1. Platform
      1. Amazon Linux 2023
   2. Spec
      1. 2 vCPU
      2. 4GB RAM
      3. 20GB Hard disk
      4. Don’t use burstable instances
   3. Network
      1. Private subnet
      2. connectivity to internet (typically via NAT)
      3. connectivity to your staging service
   4. Security groups
      1. Inbound - Open ports 22, 9092
      2. Outbound - Open all
2. SSH into this new instance in your Cloud
3. Run `sudo su -`
4. Install [docker](https://github.com/akto-api-security/infra/blob/feature/quick-setup/get-docker.sh) and [docker-compose](https://github.com/akto-api-security/infra/blob/feature/quick-setup/get-docker-compose.sh).
5.  Run the following commands to download setup files - 
   
   ```
      wget https://raw.githubusercontent.com/akto-api-security/infra/refs/heads/feature/quick-setup/docker-compose-mini-runtime.yml
      wget https://raw.githubusercontent.com/akto-api-security/infra/refs/heads/feature/quick-setup/watchtower.env
      wget https://raw.githubusercontent.com/akto-api-security/infra/refs/heads/feature/quick-setup/docker-mini-runtime.env
      wget https://raw.githubusercontent.com/akto-api-security/infra/refs/heads/feature/quick-setup/docker-threat-detection.env
   ```
6. Modify ${AKTO_KAFKA_IP} in the `docker-compose-mini-runtime.yml` with the ip of your instance on which runtime will be deployed
7. Replace the value of `DATABASE_ABSTRACTOR_SERVICE_TOKEN` in `docker-mini-runtime.yml` with the token value copied from Akto's Hybrid Saas Connector in the quick start menu. Also Replace the value of `AKTO_KAFKA_BROKER_URL` with <instance_ip>:9092. Also Replace the value of `AKTO_THREAT_PROTECTION_BACKEND_TOKEN` and `DATABASE_ABSTRACTOR_SERVICE_TOKEN` in `docker-threat-detection.env` with the token value copied from Akto's Hybrid Saas Connector in the quick start menu.

8. Run `docker-compose -f docker-compose-mini-runtime.yml up -d`
9. Run `systemctl enable /usr/lib/systemd/system/docker.service` to ensure Docker starts up in case of instance restarts


## Notes:

1. Ensure internet connectivity in Traffic aggregator  service.
2. In case of closed network, please whitelist (https://cyborg.akto.io)
3. Ensure that traffic connector is able to connect to Traffic aggregator service
4. Log levels for Akto services can be configured by setting the environment variable `AKTO_LOG_LEVEL`
   - Supported values include `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR` and `OFF`.
   - Default log level is set to `WARN`.

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
