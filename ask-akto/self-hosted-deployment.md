# Self-Hosted Deployment

## **Overview**

**Ask Akto** is an AI-powered conversational assistant integrated into Akto's security platform that enables users to have real-time conversations about Agentic vulnerabilities, scan results, and security insights.

## Key Capabilities

* **Interactive Vulnerability Analysis**: Ask questions about scan results and vulnerabilities in natural language
* **Agentic and agentic AI security Guidance**: Get AI-powered remediation suggestions and security best practices
* **Scan Result Analysis**: Deep-dive into why scans passed/failed with AI assistance
* **Dashboard Metrics Discussion**: Analyse Agentic collections, endpoints, and risk scores
* **Conversation History**: Track and search through past security discussions
* **Multi-Conversation Support**: Maintain separate conversation threads for different contexts

## Pre-requisites

* Docker and Docker Compose installed
* Anthropic API Key
* Akto Agentic AI Security Dashboard running (self-hosted instance)

## Deployment Setup

{% stepper %}
{% step %}
#### Create the Deployment Directory

Create a directory that stores the Docker Compose configuration and environment files.

```
mkdir -p ~/akto-agentic-testing
cd ~/akto-agentic-testing
```

The directory acts as the working location for the deployment.
{% endstep %}

{% step %}
#### Create Docker Compose File

Create a `docker-compose.yml` file with the following configuration:

```yaml
version: '3.8'

services:
  agent-testing:
    container_name: agent-testing
    image: public.ecr.aws/aktosecurity/akto-agentic-testing:latest
    ports:
      - "5500:5500"
    env_file:
      - ./docker-agentic-testing-dashboard.env
    restart: always

  mcp-server:
    container_name: mcp-server
    image: public.ecr.aws/aktosecurity/akto-agentic-testing:mcp_latest
    ports:
      - "4000:4000"
    env_file:
      - ./docker-mcp-server.env
    restart: always
```

The Docker Compose configuration defines two services:

* **agent-testing** – runs the AI-driven Agentic engine.
* **mcp-server** – provides the MCP interface used by the AI agent.
{% endstep %}

{% step %}
#### Create Environment Files

Two environment files configure runtime behavior for the containers.

**Environment File for Agent Testing Service**

Create a file named: `docker-agentic-testing-dashboard.env`

```bash
# Anthropic API Configuration
ANTHROPIC_API_KEY=<YOUR_ANTHROPIC_API_KEY>

# Node Environment
NODE_ENV=production

# Agent Testing Service Port
PORT=5500

# Enable Agentic Mode
AGENTIC_MODE=true

# MCP Server Connection
MCP_SERVER_URL=http://<YOUR_MCP_SERVER_HOST>:<YOUR_MCP_SERVER_PORT>
```

**Environment variables**

<table><thead><tr><th width="197.41796875">Variable</th><th>Purpose</th></tr></thead><tbody><tr><td><code>ANTHROPIC_API_KEY</code></td><td>API key used for accessing Anthropic Claude models.</td></tr><tr><td><code>PORT</code></td><td>Port exposed by the agent-testing service. Default value: <code>5500</code>.</td></tr><tr><td><code>MCP_SERVER_URL</code></td><td>URL used by the agent-testing service to communicate with the MCP server.<br>Replace <code>&#x3C;YOUR_MCP_SERVER_HOST></code> and <code>&#x3C;YOUR_MCP_SERVER_PORT></code> with the MCP server host and port configured in the deployment environment.</td></tr></tbody></table>

**Environment File for MCP Server**

Create a file named: `docker-mcp-server.env`

```bash
# Dashboard Connection
AKTO_BASE_URL=http://<YOUR_AKTO_DASHBOARD_HOST>:<PORT>

# MCP Server Configuration
MCP_MODE=internal
MCP_API_KEY="abc"

# Debug Logging
DEBUG=true
```

**Environment variables**

<table><thead><tr><th width="160.5078125">Variable</th><th>Purpose</th></tr></thead><tbody><tr><td><code>AKTO_BASE_URL</code></td><td>Base URL of the Akto Agentic AI Security Dashboard.<br>Replace <code>&#x3C;YOUR_AKTO_DASHBOARD_HOST></code> and <code>&#x3C;PORT></code> with the hostname and port configured in the on-prem deployment.</td></tr><tr><td><code>MCP_MODE</code></td><td>Deployment mode of the MCP server. Value <code>internal</code> is used for on-prem environments.</td></tr><tr><td><code>MCP_API_KEY</code></td><td>Authentication key used for MCP server access.</td></tr></tbody></table>
{% endstep %}

{% step %}
#### Start the Services

```bash
# From the deployment directory
docker-compose up -d

# Verify services are running
docker-compose ps
```

Expected output:

```
NAME              STATUS        PORTS
agent-testing     Up ...        0.0.0.0:5500->5500/tcp
mcp-server        Up ...        0.0.0.0:4000->4000/tcp
```
{% endstep %}

{% step %}
#### Verify Connectivity

You can verify that both services started successfully by checking the health endpoints.

**Agent Testing Service**

```bash
curl http://<AGENT_TESTING_HOST>:<AGENT_TESTING_PORT>/health
```

**MCP Server**

```bash
curl http://<MCP_SERVER_HOST>:<MCP_SERVER_PORT>/health
```
{% endstep %}
{% endstepper %}

## Usage

Once deployed, **Ask Akto** can be accessed through the Akto's Security Dashboard:

1. Navigate to your Akto dashboard
2. Access the **Ask Akto** feature section
3. Start conversing with the agent.

## Support

If you need help with the deployment:

* **Discord Community**: Join our community at [discord.gg/Wpc6xVME4s](https://discord.gg/Wpc6xVME4s)
* **Email Support**: Contact us at [support@akto.io](mailto:support@akto.io)

Our team is available 24/7 to assist you with setup, troubleshooting, and best practices.
