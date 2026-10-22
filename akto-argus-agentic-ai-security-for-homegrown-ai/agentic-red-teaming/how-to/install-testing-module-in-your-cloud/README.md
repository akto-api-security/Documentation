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

## Configure the LLM in Akto

The red teaming engine needs an LLM. You choose it in the Akto dashboard, and the scanning module fetches it from Akto, so you don't pass any LLM credentials when you install the module. You can change the provider, model or key later without reinstalling; restart the module to apply the change.

1. In the Akto dashboard, go to **Settings** → **Integrations** → **Agents**.
2. Choose the provider and fill in its fields (see the table below).
3. Set **Name** to `red-teaming`. Red teaming uses only the model with this name.
4. Save the model.

**Fields per provider**

| Provider | Required | Optional | Notes |
|---|---|---|---|
| Anthropic | API Key | Model, Fast model | Without a model, the default Claude models are used. |
| AWS Bedrock | AWS Region | Bedrock API Key, Model, Fast model | Without an API key, the module uses its own AWS credentials, such as an IAM role (IRSA or Pod Identity on EKS, an instance profile on a VM). The models must be enabled for that region in the Bedrock console; they are off by default on a new AWS account. |
| Google Vertex AI | Service account JSON, GCP Project ID, Location, Endpoint ID | Dedicated endpoint domain, Model, Fast model | Paste the whole service account key file into **Service account JSON**. It is used for calls to your Vertex AI endpoint; the agent loop needs separate Google credentials (see below). |
| Azure OpenAI | API Key, Azure OpenAI Endpoint, Model | Fast model | Set **Model** to your deployment name. A `https://<resource>.openai.azure.com` endpoint gets `/openai/v1` added automatically; any other endpoint must already end in `/openai/v1`. |
| OpenAI | API Key, Model | Fast model | |
| Gemini | API Key, Model | Fast model | |
| Cloudflare | API Key (API token), Cloudflare Account ID, Model | Fast model | |
| Ollama | OLLAMA Server Endpoint, Model | API Key, Fast model | The Ollama server must be reachable from the scanning module. |
| Databricks | API Key, Databricks Model Serving Endpoint, Model | Fast model | For the endpoint, use the workspace's base URL, `https://<workspace-host>/serving-endpoints`, and set **Model** to the serving endpoint name. A full `.../invocations` URL does not work for red teaming. |

GitHub Copilot models can't be used for red teaming.

**How the models are used**

* **Model** serves the analysis role (validation, remediation, prompt optimisation). **Fast model** serves the fast role (request rewriting and field extraction); when it's empty, **Model** is used.
* The agent loop runs on the Claude Agent SDK, so it needs **Anthropic**, **AWS Bedrock** or **Google Vertex AI**, where it uses the default Claude agent model. With OpenAI, Azure OpenAI, Gemini, Cloudflare, Ollama or Databricks, **Model** and **Fast model** serve only the analysis and fast roles, and red teaming steps that use the agent loop don't work.
* On Google Vertex AI, the agent loop runs Claude on Vertex AI with the module's own Google credentials, not the service account JSON saved in Akto. Give the module credentials for that project, for example GKE Workload Identity, and enable the Claude models in the project.

**Changes and fallback**

* Add the `red-teaming` model before you install the module. The module reads it at startup.
* After you add, change or delete the model, restart the module so every part of it uses the new configuration:
  * Helm: `kubectl rollout restart deploy/akto-mini-testing`
  * Linux VM: `docker restart agent-testing`
* If Akto can't be reached, or the `red-teaming` model is missing a required field, the module keeps the configuration already in use and logs the reason with `AktoModelConfig`.

{% hint style="warning" %}
Add the `red-teaming` model before running scans. Without it, the module has no LLM to use, and the `agent-testing` logs show `LLM provider not configured from env` at startup.
{% endhint %}

You then have to use a Linux VM or a Helm chart to install Akto AI Red Teaming module in your cloud.

To run several scans in parallel on Kubernetes, see [Autoscale the Scanning Module](autoscaling-testing-module.md).

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

Replace `<token>` with the **Database Abstractor Token** copied from [#copy-the-jwt-token](./#copy-the-jwt-token "mention"):

{% code overflow="wrap" %}
```bash
helm install akto-mini-testing akto/akto-mini-testing \
  --set testing.agentTesting.enabled=true \
  --set testing.aktoApiSecurityTesting.env.databaseAbstractorToken="<token>"
```
{% endcode %}

The LLM comes from the `red-teaming` model you added in [#configure-the-llm-in-akto](./#configure-the-llm-in-akto "mention").

{% hint style="info" %}
**AWS Bedrock without an API key**

On EKS, give the pod an IAM role through IRSA or Pod Identity so it can call Bedrock. The role's credentials are used when the `red-teaming` model has no Bedrock API key.
{% endhint %}
{% endstep %}

{% step %}
**Keep the token in a Kubernetes Secret (recommended)**

Passing the token inline puts it in your shell history. To read it from a Secret you create yourself instead:

```bash
kubectl create secret generic akto-db-token --from-literal=token="<token>"
```

{% code overflow="wrap" %}
```bash
helm install akto-mini-testing akto/akto-mini-testing \
  --set testing.agentTesting.enabled=true \
  --set testing.aktoApiSecurityTesting.env.useSecretsForDatabaseAbstractorToken=true \
  --set testing.aktoApiSecurityTesting.env.databaseAbstractorTokenSecrets.existingSecret=akto-db-token
```
{% endcode %}

The secret must be of type `Opaque` with its value under a key named `token`.
{% endstep %}

{% step %}
**Check that the model is in use**

```bash
kubectl logs deploy/akto-mini-testing -c agent-testing | grep AktoModelConfig
```

You should see a line like:

```
[AktoModelConfig] using Akto model "red-teaming" (ANTHROPIC claude-sonnet-4-6)
```
{% endstep %}
{% endstepper %}

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
2.  Add the following configuration:

    ```dotenv
    NODE_ENV=dev
    PORT=5500
    AGENTIC_MODE=false
    NODE_TLS_REJECT_UNAUTHORIZED=0
    AKTO_UTILITY_SERVER=http://akto-api-security-testing:8001
    USE_SESSION_MANAGEMENT=true
    ```

The LLM comes from the `red-teaming` model you added in [#configure-the-llm-in-akto](./#configure-the-llm-in-akto "mention"). `AKTO_UTILITY_SERVER` is how the module fetches it, so keep it as shown.

{% hint style="info" %}
**AWS Bedrock without an API key**

Attach an IAM role to the VM (instance profile) so the container can call Bedrock. On IMDSv2 the instance metadata hop limit must be at least `2`, or the container cannot reach it.
{% endhint %}

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

{% step %}
**Check that the model is in use**

```bash
docker logs agent-testing 2>&1 | grep AktoModelConfig
```

You should see a line like:

```
[AktoModelConfig] using Akto model "red-teaming" (ANTHROPIC claude-sonnet-4-6)
```
{% endstep %}
{% endstepper %}

{% hint style="info" %}
**Existing installs**

Installs that already pass LLM credentials at install time keep working and need no changes. Once you add a `red-teaming` model in Akto and restart the module, that model is used instead.
{% endhint %}

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `support@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
