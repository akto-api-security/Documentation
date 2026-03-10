# Github Copilot Enterprise

## Overview&#x20;

This page explains how you can integrate **GitHub Copilot Enterprise** with Akto Atlas to enable **agent discovery, centralized guardrails, and enterprise-wide policy enforcement**.

As an Akto user, you can secure Copilot Enterprise using two complementary integration layers:

1. **Endpoint-level control via Copilot Hooks**
2. **Model-level control via Akto Agent Proxy (custom model routing)**

Together, these provide visibility and enforcement both at the developer endpoint and before requests reach the AI model.

## **1.** Endpoint Enforcement (CLI Hooks)

You can secure Copilot usage using the **Copilot  Hooks integration** (refer to the [copilot-cli-hooks.md](copilot-cli-hooks.md "mention") page for complete setup details).

This integration allows you to:

* Monitor prompt submissions
* Block unsafe tool executions before they run
* Send events to Akto Atlas for centralized visibility

This layer secures Copilot usage directly at employee endpoints.

## **2.** Model Routing (Agent Proxy)

To enforce guardrails before requests reach the AI provider, you can configure Copilot Enterprise to route model traffic through the **Akto Agent Proxy**.

Instead of allowing Copilot to directly access built-in models, you configure a **custom model endpoint** that points to Akto’s proxy.

Akto then:

1. Inspects and validates the request
2. Applies guardrails and policy enforcement
3. Forwards approved traffic to the configured backend model (Foundry or OpenAI-compatible)

This ensures centralized enforcement across all Copilot Enterprise users.

### **Prerequisites**

Before configuring GitHub:

* Ensure **Akto Agent Proxy is deployed and reachable**
* Ensure the proxy is connected to:
  * Azure Foundry **or**
  * An OpenAI-compatible backend
* Validate that the proxy endpoint is functioning correctly

{% hint style="warning" %}
## **Important**

The Agent Proxy must already be connected to the target model backend before you configure it in GitHub. Misconfiguration will cause Copilot requests to fail.
{% endhint %}

### **Configuration Steps in GitHub**

After completing the prerequisites (including Akto Agent Proxy deployment), perform the following:

{% stepper %}
{% step %}
Go to **GitHub → Enterprise Settings**
{% endstep %}

{% step %}
Navigate to **AI Controls**
{% endstep %}

{% step %}
Open **Copilot**
{% endstep %}

{% step %}
Locate the **Configured Models** section

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/image (1) (2).png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
Disable all default or built-in models (if you want full proxy enforcement)
{% endstep %}

{% step %}
Select **Add Custom Model**

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/image (2) (3).png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
Choose the appropriate provider type:

* Foundry
* OpenAI-compatible
{% endstep %}

{% step %}
Enter the **Akto Agent Proxy URL** as the model endpoint

*   For OpenAI-compatible

    <div data-with-frame="true"><figure><img src="../../.gitbook/assets/image (3).png" alt="" width="563"><figcaption></figcaption></figure></div>
*   For Microsofy Foundry

    <div data-with-frame="true"><figure><img src="../../.gitbook/assets/image (4).png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
1. Save and apply the configuration.
{% endstep %}
{% endstepper %}

All Copilot Enterprise model requests will now flow through Akto Agent Proxy before reaching the selected backend.

## **Operational Flow**

Once fully configured:

1. User interacts with Copilot
2. (Optional) Copilot Hooks capture endpoint events
3. Copilot sends model request
4. Request is routed to **Akto Agent Proxy**
5. Akto applies guardrails and validation
6. Approved requests are forwarded to the backend model
7. Responses return through the proxy to Copilot

This provides layered security across the Copilot lifecycle.

## **Best Practices**

* Use **both Copilot Hooks and Proxy routing** for complete coverage
* Disable direct access to built-in models to avoid bypass paths
* Validate proxy connectivity before enterprise rollout
* Test with a limited user group before full deployment
* Decide your enforcement posture (observe vs block) before enabling strict policies

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `support@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
