---
description: Integrate arcade.dev with Akto Argus
hidden: true
---

# Arcade

## Overview

Arcade is a real-time traffic processing engine that enables secure collection and forwarding of network events into Akto for runtime API visibility and analysis. This integration lets you capture API traffic and metadata from Arcade and send it into your Akto environment for security monitoring and enforcement.

The Arcade Integration automatically:

* Collects API request and response metadata from your Arcade deployment.
* Forwards structured traffic events to Akto’s Traffic Processor.
* Supports downstream security analysis and dashboard visualization in Akto.

## Steps to Connect

{% stepper %}
{% step %}
### Configure Akto Traffic Processor

Set up and configure your Traffic Processor. The steps are mentioned [here](../others/hybrid-saas.md).

{% hint style="warning" %}
**Important**

Keep the your Data ingestion URL ready. It will be required in the next steps.
{% endhint %}
{% endstep %}

{% step %}
### Navigate to Contextual Access in Arcade

1. Log in to your Arcade Dashboard.
2. From the left navigation panel, select **Contextual Access**.
3.  Under the **Extensions** section, click **Add Extension**.

    <div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (130).png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
### Create a New Webhook Extension

In the **Add Extension** screen enter the Basic Information such as:

* **System Type:** Select `Webhook`
* **Name:** Provide a descriptive name (e.g., `Akto Security Integration`)
* **Description (optional):**\
  Example:\
  `Forwards tool execution events to Akto Traffic Processor for security analysis`
*   **Scope:** Select the appropriate scope (Project or Organization)

    <div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (129).png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
### Configure Webhook Endpoints

Under **Webhook Endpoints**, configure the execution stages that should be intercepted.

{% hint style="warning" %}
## Note

You must enter your Akto Traffic Processor ingestion URL in each enabled stage.\
All other fields can be left as default unless you require a custom configuration.
{% endhint %}

#### 1. Tool Access

Enable **Tool Access** if you want Akto to control which users can see or use specific tools.

**Configure:**

*   **Webhook URL:**\
    Enter your Data Ingestion ingestion endpoint:

    ```
    <your-data-ingestion-url>
    ```
* **Priority:** Leave as default (`0`) unless you need custom execution ordering.
* **On Failure:** See explanation below.
* **Timeout:** Leave default (recommended: 5 seconds).
*   **Response Caching:** Keep disabled unless explicitly required.

    <div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (131).png" alt="" width="563"><figcaption></figcaption></figure></div>

{% hint style="success" %}
## Configure Failure Mode (Blocking vs Async)

The **On Failure** setting determines whether the integration operates in enforcement (blocking) mode or monitoring (async) mode.

#### Recommended Configuration

For production environments requiring enforcement:

* **On Failure:** `Block request`

For monitoring-only deployments:

* **On Failure:** `Allow request`
{% endhint %}

#### 2. Pre Tool Execution

Enable **Pre tool execution** to validate and inspect tool inputs before the tool runs.

**Configure:**

*   **Webhook URL:**

    ```
    <your-data-ingestion-url>
    ```
* Leave **Priority**, **Timeout**, and other fields as default unless you require custom behaviour.
*   Configure **On Failure** based on your enforcement requirements.

    <div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (133).png" alt="" width="563"><figcaption></figcaption></figure></div>

{% hint style="danger" %}
## **Important**

If Pre tool execution is not enabled, Akto will not be able to inspect or enforce policies on tool inputs before execution. This means unsafe or malicious inputs may reach the tool without being evaluated.
{% endhint %}

#### 3. Post Tool Execution

Enable **Post tool execution** to inspect tool outputs after execution.

**Configure:**

*   **Webhook URL:**

    ```
    <your-data-ingestion-url>
    ```
* Leave **Priority**, **Timeout**, and other fields as default unless custom configuration is required.
*   Configure **On Failure** as needed.

    <div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (134).png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
### Save and Enable the Extension

After configuring all required webhook stages:

1. Click **Add Extension** present in the top right corner.
2. Ensure the extension is marked as **Enabled**.
3.  Review the **Execution Order Preview** to confirm hooks are active.

    <div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (143).png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}
{% endstepper %}

## Data Collected

The Arcade integration captures:

### Tool Access Events

* Tool visibility decisions
* User metadata
* Access enforcement decisions

### Pre-Execution Data

* Tool input payloads
* Validation and policy enforcement results

### Post-Execution Data

* Tool output payloads
* Redaction or blocking decisions

## Get Support

If you need assistance with the Snowflake connector:

* **In-app Chat**: Use the chat widget in your Akto dashboard for instant support
* **Discord Community**: Join our community at [discord.gg/Wpc6xVME4s](https://discord.gg/Wpc6xVME4s)
* **Email Support**: Contact us at [support@akto.io](mailto:support@akto.io)
* **Contact Form**: Submit a support request at [https://www.akto.io/contact-us](https://www.akto.io/contact-us)

Our team is available 24/7 to help with setup, troubleshooting, and best practices.
