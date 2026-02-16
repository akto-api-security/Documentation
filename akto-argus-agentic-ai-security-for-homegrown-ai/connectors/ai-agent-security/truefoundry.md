---
description: Connect Akto with TrueFoundry AI Gateway
---

# TrueFoundry

## Overview

TrueFoundry is a comprehensive ML platform that helps you deploy and manage LLM-powered applications at scale. The **TrueFoundry AI Gateway** routes all LLM traffic through a centralized gateway, enabling security, monitoring, and cost management.

Akto integrates with TrueFoundry AI Gateway as a **custom guardrail server**, providing real-time security validation and comprehensive traffic monitoring for all your LLM interactions. Once configured, TrueFoundry AI Gateway automatically sends requests to Akto for security analysis.

The Akto TrueFoundry integration automatically:

* **Validates Input Requests**: Checks user prompts against security policies before they reach your LLM (input guardrails)
* **Blocks Malicious Requests**: Prevents prompt injection, jailbreaks, and policy violations in real-time
* **Monitors LLM Responses**: Analyzes model outputs for sensitive data leakage and policy violations (output guardrails)
* **Ingests Traffic**: Captures all LLM interactions for security analysis and compliance
* **Provides Visibility**: Centralizes monitoring of all TrueFoundry AI Gateway traffic in a unified dashboard

## How It Works

Akto acts as a **custom guardrail server** for TrueFoundry AI Gateway:

### Architecture Flow

```
1. Client Application
   ↓
2. TrueFoundry AI Gateway
   ↓
3. Akto Guardrail Server (validates/monitors)
   ↓
4. TrueFoundry AI Gateway
   ↓
5. LLM Provider (OpenAI, Anthropic, etc.)
```

## Sync vs Async Mode

The Akto TrueFoundry integration supports two operation modes controlled by the `sync` query parameter:

### Synchronous Mode (`sync=true`)

**Input Guardrails (Request Only):**
- Request is validated **before** reaching the LLM
- If validation fails: Returns HTTP 400, request is **blocked** and data is ingested for monitoring
- If validation passes: Returns HTTP 200, request proceeds to LLM

**Output Monitoring (Request + Response):**
- Data is ingested asynchronously for monitoring
- Returns HTTP 200 immediately (non-blocking)
- Used for logging completed interactions

### Asynchronous Mode (`sync=false`)

**Request Only:**
- Returns HTTP 200 immediately (no-op)
- No validation or ingestion performed

**Request + Response:**
- Both guardrails validation and ingestion happen asynchronously
- Returns HTTP 200 immediately (non-blocking)
- Violations are logged but don't block execution


## Prerequisites

Before integrating Akto with TrueFoundry AI Gateway, ensure you have:

* **TrueFoundry AI Gateway**: Active TrueFoundry AI Gateway instance (v1.0+)
* **Admin Access**: Permissions to configure guardrails in TrueFoundry dashboard
* **Akto Setup**: Running Akto instance with Data Ingestion Service
* **Network Access**: TrueFoundry AI Gateway can reach Akto Data Ingestion Service endpoint
* **HTTPS Recommended**: Secure communication between TrueFoundry and Akto

## Integration Steps

{% stepper %}

{% step %}
**Configure Akto Traffic Processor**

Set up and configure your Traffic Processor. The steps are mentioned [here](../others/hybrid-saas.md).
{% endstep %}

{% step %}
**Get your Akto TrueFoundry Service URL**

Ensure your Akto Data Ingestion Service is running and accessible. Note the endpoints:

```
https://<your-akto-host>:<port>/api/http-proxy/truefoundry?sync=true/false
```

{% hint style="warning" %}
Ensure the Akto Data Ingestion Service is reachable from your TrueFoundry AI Gateway instance. Test connectivity before proceeding.
{% endhint %}
{% endstep %}

{% step %}
**Navigate to TrueFoundry AI Gateway Dashboard**

1. Log in to your TrueFoundry account
2. Navigate to **AI Gateway** in the sidebar
3. Click on **Guardrails** tab
4. Click **Add New Guardrails Group**

{% endstep %}

{% step %}
**Configure Guardrails Group**

Fill in the guardrails form for input/output validation:

**Basic Settings:**
* **Name**: `Akto Guardrails` (or your preferred name)
* **Access Control**: Add users/teams who should have access

* **Guardrails**: This is where you configure the custom guardrails. Click on **Add Guardrail** and select **Custom** under **External Providers**.

**Adding a Guardrail:**
1. **Name**: `Akto Input Guardrail` (or your choice)
2. **Description (Optional)**: `Add a description for this guardrail`
3. **Operation**: Select **Validate**
4. **Enforcing Strategy**: Choose **Enforce**, this will block requests that fail validation
5. **Target**: Request (for input guardrails) or Response (for output guardrails)
6. **Config**: 
* **URL**: Enter your Akto Data Ingestion Service URL (e.g., `https://<your-akto-host>:<port>/api/http-proxy/truefoundry?sync=true/false`)

{% hint style="info" %}
You can add multiple guardrails for different validation rules (e.g., one for input validation, another for output monitoring). Just click on **Add Guardrails** and repeat the above steps and change the **Operation** and **Target** accordingly.
{% endhint %}

Finally, save the Guardrails Group by clicking on **Add Guardrails Group**.
{% endstep %}

{% step %}

**Add Guardrails to model:**
You can add the saved guardrails to the model in one of the two ways:

1. **In the Playground**: When testing your model in the TrueFoundry Playground, you can add guardrails by clicking on the plus icon next to Input/Output Guardrails in the left panel, and adding the desired guardrails from the list.

{% hint style="warning" %}
Guardrails are only applied in the Playground and not in production traffic. You will also need to add the guardrails for every new session in the Playground.
{% endhint %}

2. **At the Controls Page**
1. Navigate to the **Controls** tab in the TrueFoundry AI Gateway dashboard
2. Click on Guardrails
3. Click on **Add Rule**
4. Fill in the form:
* **Rule ID**: `akto-guardrail` (or your preferred name)
* **When Request Goes To**: Select the model(s) you want to apply the guardrail to (e.g., `gpt-4`, `claude-2`, etc.)
* **From Subjects**: Select the users/teams you want to include/exclude from the guardrail
* **Apply on Hooks**: Select the specific LLM Hook (input/output) and choose the corresponding guardrail that you created.
5. Click on **Submit** to save the rule.
{% endstep %}
{% endstepper %}

When Akto blocks a request (returns `allowed: false`), TrueFoundry AI Gateway will:
1. **Not forward** the request to the LLM provider
2. Return an error response to the client
3. Log the blocked request for audit purposes

## Get Support

For assistance with your TrueFoundry integration:

1. **In-app Support**: Message us via Intercom in the Akto dashboard
2. **Community**: Join our [Discord channel](https://www.akto.io/community)
3. **Email**: Contact `help@akto.io`
4. **Website**: Visit our [contact page](https://www.akto.io/contact-us)
