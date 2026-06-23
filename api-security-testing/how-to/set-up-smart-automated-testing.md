---
description: Install and configure the AI agent and hybrid testing module for Smart Automated Testing.
---

# Set Up Smart Automated Testing

[Smart Automated Testing](../concepts/smart-automated-testing.md) requires the **AI Automated Testing** agent running alongside your hybrid testing module. When you enable Smart Automated Testing in the dashboard, the testing module sends work to this agent via `AUTOMATED_AGENT_BASE_URL`.

## Prerequisites

1. Docker and Docker Compose on a host that can reach the APIs you want to test (typically a private subnet with outbound internet access).
2. A **Database Abstractor Token** from the Akto dashboard: **Quick Start** → **Hybrid SaaS** → **Connect**. See [Install testing module in your Cloud](install-testing-module-in-your-cloud/README.md) for Helm, Terraform, and VM setup options.

## Docker Compose

1. Create a file named `docker-compose-mini-testing.yml` with the following content. Replace the placeholder values before starting the stack.

```yaml
version: '3.8'
services:
  akto-api-security-testing:
    image: public.ecr.aws/aktosecurity/akto-api-security-mini-testing:latest
    environment:
      RUNTIME_MODE: hybrid
      DATABASE_ABSTRACTOR_SERVICE_TOKEN: "<your-database-abstractor-token>"
      PUPPETEER_REPLAY_SERVICE_URL: "http://akto-puppeteer-replay:3000"
      MINI_TESTING_NAME: "<mini-testing-name>"
      AUTOMATED_AGENT_BASE_URL: "http://ai-automated-testing:8000"
    restart: always

  akto-api-security-puppeteer-replay:
    image: public.ecr.aws/aktosecurity/akto-puppeteer-replay:latest
    ports:
      - "3000:3000"
    environment:
      NODE_ENV: production
    restart: always

  ai-automated-testing:
    container_name: ai-automated-testing
    image: public.ecr.aws/aktosecurity/akto-ai-automated-testing:latest
    environment:
      AKTO_API_BASE: "https://ultron.akto.io"
    ports:
      - "8000:8000"

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

2. Start the services:

```bash
docker compose -f docker-compose-mini-testing.yml up -d
```

3. Verify all containers are running:

```bash
docker ps
```

## Environment variables

| Variable | Service | Description |
|----------|---------|-------------|
| `DATABASE_ABSTRACTOR_SERVICE_TOKEN` | `akto-api-security-testing` | JWT from **Quick Start** → **Hybrid SaaS** → **Connect**. Links this runtime to your Akto account. |
| `MINI_TESTING_NAME` | `akto-api-security-testing` | Display name for this testing runtime in the Akto dashboard. |

## Run Smart Automated Tests

After the stack is running, go to **Testing** in the Akto dashboard, select your tests, enable **Smart Automated Testing**, and run. See [Smart Automated Testing](../concepts/smart-automated-testing.md) for details on the execution flow and AI trace.

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24x7 available on the following:

1. In-app `intercom` support — message us inside the Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Reach us [here](https://www.akto.io/contact-us).
