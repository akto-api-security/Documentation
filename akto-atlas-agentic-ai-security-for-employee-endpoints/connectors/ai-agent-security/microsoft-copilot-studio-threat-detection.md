---
description: Connect Akto Atlas as an external threat detection provider for Microsoft Copilot Studio agents
---

# Copilot Studio (Threat Detection)

## Overview

Microsoft Copilot Studio lets you connect an [external threat detection system](https://learn.microsoft.com/en-us/microsoft-copilot-studio/external-security-provider) to your agents for real-time protection. Once connected, every time a Copilot Studio agent considers invoking a tool, it checks with Akto first. Akto evaluates the request and tells the agent to **allow** or **block** it, so risky tool calls are stopped before they run - not just flagged after the fact.

Once connected, Akto Atlas:

* **Evaluates every tool-invocation request** from your Copilot Studio agents in real time
* **Blocks unsafe or policy-violating tool calls** before they execute, with no visible interruption for the user when a call is allowed
* **Reports every decision** back to the Akto dashboard for monitoring and audit

{% hint style="warning" %}
This is a Microsoft **preview** capability. It only applies to generative agents using **generative orchestration** - classic agents are not covered. Microsoft may change this interface before general availability.
{% endhint %}

{% hint style="warning" %}
Threat detection is configured **per Power Platform environment**. There is no tenant-wide or global toggle - you (or your Power Platform admin) must repeat [Part 3](#part-3-turn-on-threat-detection-in-power-platform-admin-center) for every environment you want Akto to protect, including any new environment you create later.
{% endhint %}

## What Gets Checked (and What Doesn't)

Microsoft only calls the external threat detection system at specific points in an agent's turn. Everything else in the turn runs without a check. Use this to set expectations before you connect Akto:

| # | Point in lifecycle | Called? | Endpoint | What can be blocked | Effect on final response |
| --- | --- | --- | --- | --- | --- |
| 1 | Admin saves config in Power Platform admin center | Yes | `POST /validate` | Nothing runtime - only fails the save if the Entra app is misconfigured | None |
| 2 | User prompt received / before orchestration | No | - | Nothing | None - no hook exists here |
| 3 | Planner decides to invoke a tool (action, connector, flow, MCP tool) | **Yes** - the only runtime call | `POST /analyze-tool-execution` | The tool execution (pre-execution) | Indirect: a block halts the turn and shows a canned notice |
| 4 | Each subsequent tool in a multi-step plan | **Yes** - once per tool | `POST /analyze-tool-execution` | That specific step | Same as row 3 |
| 5 | After a tool returns, before its output is used | Indirect only | via the next tool's call | Only the next tool call - the output itself can't be retracted | None directly |
| 6 | LLM composes the final answer | No | - | Nothing | Cannot be blocked |
| 7 | Final answer rendered to the user | No | - | Nothing | Cannot be blocked |
| 8 | Turn with no tool invocation at all | No | - | Nothing | Cannot be blocked |
| 9 | Classic (non-generative) agents | No | - | Nothing - skipped entirely | None |
| 10 | Provider times out or errors | Attempted, no verdict | `POST /analyze-tool-execution` | Governed by **Set error behavior** (default: allow after 1,000 ms) | Fail-open by default |

{% hint style="warning" %}
Akto only ever sees and evaluates **tool invocations** (rows 3, 4, and 10). It cannot inspect or block the user's raw prompt, the LLM's final answer, or any turn where the agent never calls a tool - Copilot Studio doesn't call the threat detection endpoint at those points.
{% endhint %}

## Prerequisites

Before setting up Copilot Studio threat detection, ensure the following requirements are met. **Most setup issues are caused by missing prerequisites - please review them carefully.**

### 1. An Existing Microsoft Entra App Registration

This guide assumes you already have a Microsoft Entra application registered in your tenant. **Reuse the same app registration you created when setting up the [Copilot Studio (Multi Environment)](microsoft-copilot-studio-multi-environment.md#part-1-create-an-app-registration-in-microsoft-entra) connector in Akto Atlas** - you don't need to create a new one for threat detection. You'll need:

* Its **Application (Client) ID**
* Permission to add **Federated Identity Credentials** to it (see [Part 2](#part-2-trust-akto-in-your-microsoft-entra-app))

If you haven't set up that connector and don't have an app registered yet, see Microsoft's [Register an application](https://learn.microsoft.com/en-us/entra/identity-platform/quickstart-register-app) guide before continuing.

### 2. Power Platform Administrator Access

You need a user with the **Power Platform Administrator** (or **Global Administrator**) role to configure threat detection for an environment in the Power Platform admin center.

### 3. Generative Orchestration Agents

The agents you want protected must use **generative orchestration**. Classic agents do not call the external threat detection system, so enabling this integration has no effect on them.

## Steps to Connect

### Part 1 - Get Your Akto Threat Detection Endpoint

{% stepper %}
{% step %}
**Request your endpoint from Akto**

Reach out to your Akto account team or [support@akto.io](mailto:support@akto.io) and ask for your **Copilot Studio Threat Detection Endpoint**.

{% hint style="info" %}
Reference the Microsoft Entra app registration you noted in [Prerequisites](#1-an-existing-microsoft-entra-app-registration) - Akto ties the endpoint to your account, and you'll use it together with that app in the steps below.
{% endhint %}
{% endstep %}

{% step %}
**Save the endpoint URL**

Akto will give you a base URL similar to:

* Format: `https://<account-id>-guardrails.aktosecurity.com/copilot/threat-detection`

Keep this handy - you'll need it in both Part 2 and Part 3.
{% endstep %}
{% endstepper %}

### Part 2 - Trust Akto in Your Microsoft Entra App

Copilot Studio authenticates to Akto using a **Federated Identity Credential (FIC)** on your Entra app - a secret-less trust relationship scoped to your tenant and the Akto endpoint. Configure it once per app registration.

{% stepper %}
{% step %}
Go to [Microsoft Entra](https://entra.microsoft.com) > **App registrations**. Select the same app registration you used to set up the [Copilot Studio (Multi Environment)](microsoft-copilot-studio-multi-environment.md#part-1-create-an-app-registration-in-microsoft-entra) connector in Akto Atlas (see [Prerequisites](#1-an-existing-microsoft-entra-app-registration)).
{% endstep %}

{% step %}
In the sidebar, select **Manage** > **Certificates & secrets** > **Federated credentials**, then select **Add credential**.
{% endstep %}

{% step %}
In the **Federated credential scenario** dropdown, select **Other issuer**.
{% endstep %}

{% step %}
Fill in the fields as follows:

* **Issuer**: `https://login.microsoftonline.com/{tenantId}/v2.0` - replace `{tenantId}` with your organization's Microsoft Entra tenant ID.
* **Type**: **Explicit subject identifier**.
* **Value**: `/eid1/c/pub/t/{base64 tenantId}/a/m1WPnYRZpEaQKq1Cceg--g/{base64 endpoint}` - replace the two placeholders with the base64-encoded values of your tenant ID and the Akto endpoint you copied in Part 1.

    Use the following PowerShell snippet to generate both base64 values (replace the two sample values with your own tenant ID and Akto endpoint):

    ```powershell
    # Encode your Microsoft Entra tenant ID
    $tenantId = [Guid]::Parse("11111111-2222-3333-4444-555555555555")
    $base64TenantId = [Convert]::ToBase64String($tenantId.ToByteArray()).Replace('+','-').Replace('/','_').TrimEnd('=')
    Write-Output $base64TenantId

    # Encode the Akto Threat Detection Endpoint from Part 1
    $aktoEndpoint = "https://<account-id>-guardrails.aktosecurity.com/copilot/threat-detection"
    $base64Endpoint = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($aktoEndpoint)).Replace('+','-').Replace('/','_').TrimEnd('=')
    Write-Output $base64Endpoint
    ```
* **Name**: Any descriptive name, e.g. `akto-threat-detection`.
{% endstep %}

{% step %}
Select **Add**.
{% endstep %}

{% step %}
Note down the app's **Application (Client) ID** from the **Overview** page - you'll need it in Part 3.
{% endstep %}
{% endstepper %}

{% hint style="warning" %}
Double-check the **Value** field for stray whitespace or line breaks - a mismatched subject is one of the most common causes of authentication failures (see [Troubleshooting](#troubleshooting)).
{% endhint %}

### Part 3 - Turn On Threat Detection in Power Platform Admin Center

Repeat this part for **every environment** you want Akto to protect.

{% stepper %}
{% step %}
Sign in to the [Power Platform admin center](https://aka.ms/ppac).
{% endstep %}

{% step %}
On the side navigation, select **Security**, then select **Threat detection**.
{% endstep %}

{% step %}
Select **Additional threat detection**.
{% endstep %}

{% step %}
Select the environment you want to protect, then select **Set up**.
{% endstep %}

{% step %}
Select **Allow Copilot Studio to share data with a threat detection provider**.
{% endstep %}

{% step %}
Under **Azure Entra App ID**, enter the **Application (Client) ID** you noted in Part 2.
{% endstep %}

{% step %}
Under **Endpoint link**, paste the Akto Threat Detection Endpoint you copied in Part 1.
{% endstep %}

{% step %}
Under **Set error behavior**, choose how the agent should behave if Akto doesn't respond within one second:

* **Allow the agent to respond** (default) - the tool call proceeds as planned.
* **Block the query** - the tool call is blocked if Akto's decision doesn't arrive in time.

{% hint style="info" %}
Choose **Block the query** if you want to fail closed rather than fail open on a timeout.
{% endhint %}
{% endstep %}

{% step %}
Select **Save**.

{% hint style="warning" %}
Save fails if the Entra app isn't properly configured or the Federated Identity Credential doesn't match. See [Troubleshooting](#troubleshooting) below.
{% endhint %}
{% endstep %}
{% endstepper %}

Once saved, Copilot Studio starts calling Akto before every tool invocation in that environment, and decisions begin appearing in your Akto dashboard.

## Troubleshooting

### Save Fails in Power Platform Admin Center

| Error | How to Handle |
| --- | --- |
| There was a problem connecting to the protection provider. | Confirm the **Endpoint link** exactly matches the Akto Threat Detection Endpoint from Part 1, with no typos or trailing characters. |
| There was a problem with the configuration. Try checking the details you entered and the Microsoft Entra configuration. | The token acquisition failed. Recheck the **Azure Entra App ID** and the Federated Identity Credential from Part 2. Select **Copy error info** in the admin center for more detail. |
| To change a configuration, make sure you have Power Platform admin permissions. | Have a user with the **Power Platform Administrator** role perform the setup. |

### Common Entra / Authentication Issues

* **Application not found** - Verify the **Azure Entra App ID** entered in Part 3 matches the app you configured in Part 2, and that it exists in the correct tenant.
* **No Federated Identity Credential configured** - Confirm you completed [Part 2](#part-2-trust-akto-in-your-microsoft-entra-app) on the same app registration referenced in Part 3.
* **Invalid FIC issuer** - The **Issuer** must be exactly `https://login.microsoftonline.com/{tenantId}/v2.0`, with your real tenant ID substituted in.
* **Invalid FIC subject** - The **Value** must exactly match `/eid1/c/pub/t/{base64 tenantId}/a/m1WPnYRZpEaQKq1Cceg--g/{base64 endpoint}` - regenerate the base64 values with the PowerShell snippet in Part 2 and check for extra whitespace.

### No Decisions Appearing in Akto

* Confirm the environment shows **Allow Copilot Studio to share data with a threat detection provider** as enabled in the Power Platform admin center.
* Confirm the agent you're testing uses **generative orchestration** - classic agents never call the threat detection endpoint.
* Trigger a conversation that causes the agent to invoke a tool, then check the Akto dashboard for the corresponding decision.

## Disconnect Threat Detection

To stop sending an environment's tool-invocation data to Akto:

{% stepper %}
{% step %}
Sign in to the [Power Platform admin center](https://aka.ms/ppac).
{% endstep %}

{% step %}
On the side navigation, select **Security**, then select **Threat detection**.
{% endstep %}

{% step %}
Select **Additional threat detection**, choose the environment, then select **Set up**.
{% endstep %}

{% step %}
Unselect **Allow Copilot Studio to share data with your selected provider**.
{% endstep %}

{% step %}
Select **Save**.
{% endstep %}
{% endstepper %}

This only turns off threat detection for that one environment. Repeat for any other environment you want to disconnect.

## Get Support

If you need assistance with the Copilot Studio Threat Detection connector:

* **In-app Chat** - Use the chat widget in your Akto dashboard for instant support.
* **Email Support** - Contact us at [support@akto.io](mailto:support@akto.io).
