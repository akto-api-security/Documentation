---
description: Real-time threat protection for AI agents and MCP endpoints
---

# Get Started

Deploy real-time protection for your AI agents and MCP servers. Akto Guardrails blocks threats as they occur, preventing prompt injections, tool abuse, and unauthorized access before they impact your systems.

## Quick Start

### Step 1: Sign Up or Log In

1. Go to [app.akto.io](https://app.akto.io)
2. Sign up for a new account or log in to your existing account

### Step 2: Navigate to Connectors

1. Go to **Quick Start** in your Akto dashboard
2. Scroll to the **Guardrails** section
3. Choose the proxy type that matches your setup

### Step 3: Configure Your Proxy

Select and configure the appropriate protection proxy:

#### For MCP Servers

Deploy real-time protection for Model Context Protocol servers, tools, and resources.

→ [Set Up MCP Proxy](proxy/akto-mcp-proxy.md)

**What it protects:**

* MCP tool invocations
* Resource access patterns
* Prompt handling
* Schema compliance

#### For AI Agents

Deploy real-time protection for AI agents and LLM applications.

→ [Set Up Agent Proxy](proxy/akto-agent-proxy.md)

**What it protects:**

* Agent requests and responses
* Tool permission enforcement
* Authentication patterns
* Data leakage prevention

### Step 4: Enable Protection

Once your proxy is configured:

1. Set environment variable: `AKTO_THREAT_ENABLED=true`
2. Start routing traffic through the proxy
3. Monitor threats in **Guardrails** dashboard
4. Configure custom policies as needed

### Step 5: Monitor & Respond

From your Guardrails dashboard:

1. View real-time threat detection
2. See blocked attacks and patterns
3. Configure blocking rules
4. Set up alerts for critical threats

## What Gets Protected

Akto Guardrails defends against:

* Prompt injection attacks
* Tool abuse and permission escalation
* Unauthorized access attempts
* Schema violations
* Suspicious data patterns
* Known attack signatures

## Key Features

* **Real-Time Threat Detection**: Identify and respond to agentic security threats as they occur
* **OWASP Core Rule Set Support**: Detect common attack patterns including XSS and SQL injection in agent interactions
* **Prompt Injection Protection**: Block malicious prompts attempting to manipulate agent behavior
* **Tool Permission Enforcement**: Prevent unauthorized tool access and permission escalation
* **Schema Conformance**: Ensure agent requests comply with expected MCP schemas
* **Geofencing**: Restrict agent component access based on geographic locations
* **IP-Based Blocking**: Block or allow traffic from specific IP addresses or CIDR ranges

## Next Steps

* [Discover your agents](../../agentic-discovery/get-started.md) to get full visibility
* [Run security tests](../../agentic-red-teaming/get-started/) to identify vulnerabilities
* Configure custom blocking policies for your use case

Need help? Contact support@akto.io or use in-app Intercom.
