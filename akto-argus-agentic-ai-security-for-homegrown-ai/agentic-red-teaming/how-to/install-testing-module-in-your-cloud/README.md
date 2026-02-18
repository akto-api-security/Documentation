# Install testing module in your Cloud

## Overview

Agentic Security testing involves sending malicious API requests to your (staging) server. By default, these malicious testing requests are sent from the Testing module installed within Akto Cloud.

There could be multiple reasons why you'd want to install testing module within your Cloud.

1. Whitelisting Akto's IP in Security Group or WAF isn't an option
2. The staging server isn't reachable from public domain
3. The WAF would block most requests (or block Akto's IP)
4. The Agentic component domain isn't resolvable from public domain
5. The Agentic component is completely internal

## Copy the JWT Token

1. Login to Akto dashboard at [app.akto.io](https://app.akto.io)
2. Go to Quick Start > Hybrid Saas > Click on “Connect” button
3. Copy the JWT token (marked in red) \[ Also referred as `Database Abstractor Token` later]

You then have to use a Linux VM to install Akto Security Testing module in your cloud manually.

## Setup Linux VM

{% stepper %}
{% step %}
### Provision a New VM

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
### SSH into the VM

1. SSH into this new instance in your Cloud
2.  Run the following command:

    ```bash
    sudo su -
    ```
{% endstep %}

{% step %}
### Install Docker & Docker Compose

Install the [docker](https://github.com/akto-api-security/infra/blob/feature/quick-setup/get-docker.sh) and [docker-compose](https://github.com/akto-api-security/infra/blob/feature/quick-setup/get-docker-compose.sh).
{% endstep %}

{% step %}
### Create the Environment File

1.  Create:

    ```bash
    nano docker-agentic-testing.env
    ```
2.  Add the following:

    ```dotenv
    ANTHROPIC_API_KEY=<key>
    NODE_ENV=production
    PORT=5500
    AGENTIC_MODE=false
    NODE_TLS_REJECT_UNAUTHORIZED=0
    USE_SESSION_MANAGEMENT=true

    ```

{% hint style="warning" %}
## Anthropic API Key Required

You **must** replace your actual **Anthropic API Key** in the env file.
{% endhint %}

You can also reference the original template [here](https://github.com/akto-api-security/infra/blob/feature/quick-setup/docker-agentic-testing.env).
{% endstep %}

{% step %}
### Create the Docker Compose File

1.  Create:

    ```bash
    nano docker-compose-mini-testing-agentic.yml
    ```

{% hint style="danger" %}
## I**mportant Requirements**&#x20;

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
    environment:
      RUNTIME_MODE: hybrid
      DATABASE_ABSTRACTOR_SERVICE_TOKEN: <token>
      PUPPETEER_REPLAY_SERVICE_URL: "http://akto-puppeteer-replay:3000"
      MINI_TESTING_NAME: "akto-testing-module"
      AGENT_BASE_URL: "http://agent-testing:5500"
    restart: always

  akto-api-security-puppeteer-replay:
    image: public.ecr.aws/aktosecurity/akto-puppeteer-replay:latest
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
{% endstep %}

{% step %}
### Start the Testing Module

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
