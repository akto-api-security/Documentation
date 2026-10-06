# Install Scanning module in your Cloud

## Overview

Red Teaming Modules involves sending malicious agentic requests to your (staging) server. By default, these malicious scanning requests are sent from the Red Teaming module installed within Akto Cloud.

There could be multiple reasons why you'd want to install probing module within your Cloud.

1. Whitelisting Akto's IP in Security Group or WAF isn't an option
2. The staging server isn't reachable from public domain
3. The WAF would block most requests (or block Akto's IP)
4. The Agentic component domain isn't resolvable from public domain
5. The Agentic component is completely internal

## Copy the JWT Token

1. Login to Akto dashboard at [app.akto.io](https://app.akto.io)
2. Go to **Connectors** in the left nav.
3. Open the **Setup Guardrail** card and copy your token (also referred to as the database abstractor token in later steps).

You then have to use a Linux VM or a Helm chart to install Akto AI Red Teaming module in your cloud.

## Setup with Helm Chart

{% stepper %}
{% step %}
**Add the Akto Helm Repository**

Run the following commands to add and update the Akto Helm repo:

```bash
helm repo add akto https://akto-api-security.github.io/helm-charts
helm repo update
```
{% endstep %}

{% step %}
**Install the Chart**

Replace `<token>` with the **Database Abstractor Token** copied from [#copy-the-jwt-token](./#copy-the-jwt-token "mention"), and the provider placeholders with your own credentials. The scanning module supports **Anthropic**, **Azure OpenAI**, **Google Vertex AI**, and **AWS Bedrock** as the LLM backing the red teaming engine.

{% tabs %}
{% tab title="Anthropic" %}
{% code overflow="wrap" %}
```bash
helm install akto-mini-testing akto/akto-mini-testing \
  --set testing.agentTesting.enabled=true \
  --set testing.agentTesting.env.llm.provider=anthropic \
  --set testing.agentTesting.env.llm.anthropic.apiKey="<anthropic-api-key>" \
  --set testing.aktoApiSecurityTesting.env.databaseAbstractorToken="<token>"
```
{% endcode %}

{% hint style="warning" %}
**Anthropic API Key Required**

You **must** replace `<anthropic-api-key>` with your actual Anthropic API key.
{% endhint %}
{% endtab %}

{% tab title="Azure OpenAI" %}
{% code overflow="wrap" %}
```bash
helm install akto-mini-testing akto/akto-mini-testing \
  --set testing.agentTesting.enabled=true \
  --set testing.agentTesting.env.llm.provider=azure \
  --set testing.agentTesting.env.llm.azure.endpoint="<azure-openai-endpoint>" \
  --set testing.agentTesting.env.llm.azure.model="<azure-openai-model>" \
  --set testing.agentTesting.env.llm.azure.apiKey="<azure-openai-api-key>" \
  --set testing.aktoApiSecurityTesting.env.databaseAbstractorToken="<token>"
```
{% endcode %}

{% hint style="warning" %}
**Azure OpenAI Credentials Required**

The endpoint must include its `/openai/v1` suffix, for example `https://your-resource.services.ai.azure.com/openai/v1`.
{% endhint %}
{% endtab %}

{% tab title="Google Vertex AI" %}
{% code overflow="wrap" %}
```bash
helm install akto-mini-testing akto/akto-mini-testing \
  --set testing.agentTesting.enabled=true \
  --set testing.agentTesting.env.llm.provider=vertex \
  --set testing.agentTesting.env.llm.vertex.projectId="<gcp-project-id>" \
  --set testing.agentTesting.env.llm.vertex.location="<gcp-region>" \
  --set testing.agentTesting.env.llm.vertex.endpointId="<vertex-endpoint-id>" \
  --set testing.agentTesting.env.llm.vertex.endpointDomain="<vertex-endpoint-domain>" \
  --set-file testing.agentTesting.env.llm.vertex.credentialsJson=./gcp-key.json \
  --set testing.aktoApiSecurityTesting.env.databaseAbstractorToken="<token>"
```
{% endcode %}

{% hint style="warning" %}
**Vertex AI Credentials Required**

Use `--set-file` for the service account JSON — passing it with `--set` breaks on the commas and braces inside the file.
{% endhint %}
{% endtab %}

{% tab title="AWS Bedrock" %}
{% code overflow="wrap" %}
```bash
helm install akto-mini-testing akto/akto-mini-testing \
  --set testing.agentTesting.enabled=true \
  --set testing.agentTesting.env.llm.provider=bedrock \
  --set testing.agentTesting.env.llm.bedrock.awsRegion="<aws-region>" \
  --set testing.aktoApiSecurityTesting.env.databaseAbstractorToken="<token>"
```
{% endcode %}

{% hint style="warning" %}
**Bedrock Credentials**

`awsRegion` is required. Bedrock takes no API key — on EKS the pod gets credentials from an IAM role via IRSA or Pod Identity. Where no role is available, pass a bearer token instead with `--set testing.agentTesting.env.llm.bedrock.bearerToken="<token>"`.

The models the engine resolves to must be enabled for that region in the Bedrock console; they are off by default on a new AWS account.
{% endhint %}
{% endtab %}
{% endtabs %}
{% endstep %}

{% step %}
**Keep credentials in Kubernetes Secrets (recommended)**

Passing a credential inline puts it in your shell history, and the chart writes it into a Secret it manages. To use a Secret you create yourself, set `existingSecret` and `existingSecretKey` instead of the inline value.

```bash
kubectl create secret generic akto-llm-creds \
  --from-literal=azureOpenAiApiKey="<azure-openai-api-key>"

kubectl create secret generic akto-db-token --from-literal=token="<token>"
```

{% code overflow="wrap" %}
```bash
helm install akto-mini-testing akto/akto-mini-testing \
  --set testing.agentTesting.enabled=true \
  --set testing.agentTesting.env.llm.provider=azure \
  --set testing.agentTesting.env.llm.azure.endpoint="<azure-openai-endpoint>" \
  --set testing.agentTesting.env.llm.azure.model="<azure-openai-model>" \
  --set testing.agentTesting.env.llm.azure.existingSecret=akto-llm-creds \
  --set testing.agentTesting.env.llm.azure.existingSecretKey=azureOpenAiApiKey \
  --set testing.aktoApiSecurityTesting.env.useSecretsForDatabaseAbstractorToken=true \
  --set testing.aktoApiSecurityTesting.env.databaseAbstractorTokenSecrets.existingSecret=akto-db-token
```
{% endcode %}

The same `existingSecret` / `existingSecretKey` pair works for every provider — `llm.anthropic`, `llm.vertex` (key holds the service account JSON), and `llm.bedrock` (key holds the bearer token). The database abstractor token secret must be of type `Opaque` with its value under a key named `token`.
{% endstep %}
{% endstepper %}

{% hint style="info" %}
**Upgrading from an earlier chart**

`testing.agentTesting.env.anthropicApiKey`, `useSecretsForAnthropicApiKey`, and `anthropicApiKeySecrets` still work and need no changes. They are deprecated in favour of `llm.anthropic.*`, which routes the key through a Secret rather than writing it into the Deployment spec.
{% endhint %}

## Setup Linux VM

{% stepper %}
{% step %}
**Provision a New VM**

Minimum recommended configuration:

* **Platform**: Amazon Linux 2023
* **CPU:** 2 vCPUs
* **Memory:** 4 GB RAM
* **Disk:** 20 GB

{% hint style="warning" %}
Don’t use burstable instances.
{% endhint %}

* **Network**:
  * Private subnet
  * connectivity to internet (typically via NAT)
  * connectivity to your staging service
* **Security groups**
  * Inbound - Open only port 22 for SSH
  * Outbound - Open all
{% endstep %}

{% step %}
**SSH into the VM**

1. SSH into this new instance in your Cloud
2.  Run the following command:

    ```bash
    sudo su -
    ```
{% endstep %}

{% step %}
**Install Docker & Docker Compose**

Install the [docker](https://github.com/akto-api-security/infra/blob/feature/quick-setup/get-docker.sh) and [docker-compose](https://github.com/akto-api-security/infra/blob/feature/quick-setup/get-docker-compose.sh).
{% endstep %}

{% step %}
**Create the Environment File**

1.  Create:

    ```bash
    nano docker-agentic-testing.env
    ```
2.  Add the following common configuration, then append the block for your chosen LLM provider below. The scanning module supports **Anthropic**, **Azure OpenAI**, and **Google Vertex AI** as the LLM backing the red teaming engine.

    ```dotenv
    NODE_ENV=dev
    PORT=5500
    AGENTIC_MODE=false
    NODE_TLS_REJECT_UNAUTHORIZED=0
    AKTO_UTILITY_SERVER=http://akto-api-security-testing:8001
    USE_SESSION_MANAGEMENT=true
    ```

{% tabs %}
{% tab title="Anthropic" %}
```dotenv
ANTHROPIC_API_KEY=<key>
```

{% hint style="warning" %}
**Anthropic API Key Required**

You **must** replace your actual **Anthropic API Key** in the env file.
{% endhint %}
{% endtab %}

{% tab title="Azure OpenAI" %}
```dotenv
LLM_PROVIDER=azure
AZURE_OPENAI_ENDPOINT=<azure-openai-endpoint>
AZURE_OPENAI_API_KEY=<azure-openai-api-key>
AZURE_OPENAI_MODEL=<azure-openai-model>
```

{% hint style="warning" %}
**Azure OpenAI Credentials Required**

You **must** replace `AZURE_OPENAI_ENDPOINT`, `AZURE_OPENAI_API_KEY`, and `AZURE_OPENAI_MODEL` with your actual Azure OpenAI deployment details.
{% endhint %}
{% endtab %}

{% tab title="Google Vertex AI" %}
```dotenv
LLM_PROVIDER=vertex
VERTEX_PROJECT_ID=<gcp-project-id>
VERTEX_LOCATION=<gcp-region>
VERTEX_ENDPOINT_ID=<vertex-endpoint-id>
VERTEX_ENDPOINT_DOMAIN=<vertex-endpoint-domain>
GOOGLE_CREDENTIALS_JSON=<google-service-account-credentials-json>
```

{% hint style="warning" %}
**Vertex AI Credentials Required**

You **must** replace `VERTEX_PROJECT_ID`, `VERTEX_LOCATION`, `VERTEX_ENDPOINT_ID`, `VERTEX_ENDPOINT_DOMAIN`, and `GOOGLE_CREDENTIALS_JSON` with your actual Vertex AI project and service account details.
{% endhint %}
{% endtab %}
{% endtabs %}

You can also reference the original template is [here](https://github.com/akto-api-security/infra/blob/feature/quick-setup/docker-agentic-testing.env).
{% endstep %}

{% step %}
**Create the Docker Compose File**

1.  Create:

    ```bash
    nano docker-compose-mini-testing-agentic.yml
    ```

{% hint style="danger" %}
**Important Requirements**

* You must replace `<your-database-abstractor-token>` with the actual **Database Abstractor Service Token (JWT)** copied from the Step 3 of [#copy-the-jwt-token](./#copy-the-jwt-token "mention").
* Ensure **both files** below are in the **same directory**:
  * `docker-compose-mini-testing-agentic.yml`
  * `docker-agentic-testing.env`
{% endhint %}

2. Add the following configuration:

```yml
version: '3.8'
services:
  agent-testing:
    container_name: agent-testing
    image: public.ecr.aws/aktosecurity/akto-agentic-testing:latest
    ports:
      - "5500:5500"
    env_file:
      - ./docker-agentic-testing.env
    restart: always

  akto-api-security-testing:
    image: public.ecr.aws/aktosecurity/akto-api-security-mini-testing:latest
    container_name: akto-api-security-testing
    environment:
      RUNTIME_MODE: hybrid
      DATABASE_ABSTRACTOR_SERVICE_TOKEN: <token>
      PUPPETEER_REPLAY_SERVICE_URL: "http://akto-puppeteer-replay:3000"
      MINI_TESTING_NAME: "akto-testing-module"
      AGENT_BASE_URL: "http://agent-testing:5500"
    ports:
      - "8001:8001"
    restart: always

  akto-api-security-puppeteer-replay:
    image: public.ecr.aws/aktosecurity/akto-puppeteer-replay:latest
    container_name: akto-puppeteer-replay
    ports:
      - "3000:3000"
    environment:
      NODE_ENV: production
    restart: always

  watchtower:
    image: containrrr/watchtower
    restart: always
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    environment:
      WATCHTOWER_CLEANUP: true
      WATCHTOWER_POLL_INTERVAL: 1800
    labels:
      com.centurylinklabs.watchtower.enable: "false"
```

For the reference,the original template is [here](https://github.com/akto-api-security/infra/blob/feature/quick-setup/docker-compose-mini-testing-agentic.yml).
{% endstep %}

{% step %}
**Start the Scanning Module**

*   Run:

    ```bash
    docker-compose -f docker-compose-mini-testing-agentic.yml up -d
    ```
*   Run the following command to ensure Docker starts up in case of instance restarts:

    ```bash
    systemctl enable /usr/lib/systemd/system/docker.service
    ```
{% endstep %}
{% endstepper %}

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `support@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
