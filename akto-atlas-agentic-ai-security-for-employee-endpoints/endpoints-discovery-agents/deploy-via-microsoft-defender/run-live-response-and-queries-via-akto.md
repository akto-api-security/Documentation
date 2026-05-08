# Run Live Response & Queries via Akto

## Overview

You can use **Microsoft Defender Run Queries** in Akto Atlas to discover agentic activity and endpoints directly from employee devices.

To access this feature, navigate to:

**Akto Atlas → Connectors → Microsoft Defender → Run Queries**

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (3) (1) (1) (1).png" alt="" width="563"><figcaption></figcaption></figure></div>

This integration allows you to:

* Run scripts on endpoints (**Live Response**)
* Query Defender telemetry (**KQL / Advanced Hunting**)

Both methods help you uncover API usage, shadow endpoints, and external services used across your organisation.

### What You Use This For in Akto

This feature has two clear purposes:

<table><thead><tr><th width="250.984375">Option</th><th width="489.26953125">Usecase</th></tr></thead><tbody><tr><td><a href="run-live-response-and-queries-via-akto.md#option-1-run-live-response-scripts"><strong>Deploy Guardrails (Live Response)</strong></a></td><td>Remotely install Akto scripts for guardrails on endpoint devices.</td></tr><tr><td><a href="run-live-response-and-queries-via-akto.md#option-2-run-kql-queries"><strong>Detect Agentic Applications (KQL Queries)</strong></a></td><td>Identify AI tools like Cursor, Claude, and similar applications running on endpoints.</td></tr></tbody></table>

## 1. **Set Up Microsoft Defender Connector**

Before running queries or deploying guardrails, you need to connect Microsoft Defender to Akto.

You can find this setup in:

**Akto Atlas → Connectors → Microsoft Defender for Endpoint**

In the connector setup screen, provide the following:

* **Tenant ID**
* **Client ID**
* **Client Secret**
* **Data Ingestion Service URL**
*   **Polling Interval (seconds)**

    <div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (160).png" alt="" width="375"><figcaption></figcaption></figure></div>

### Credentials & Permissions (Required)

Akto authenticates to Microsoft Defender via the OAuth 2.0 client credentials flow against a Microsoft Entra app registration. Grant the app the following four **Application** API permissions (under **Microsoft Threat Protection** / **WindowsDefenderATP**) and **grant admin consent** in the Entra portal.

<details>

<summary><strong>Permissions Required (minimal set)</strong></summary>

<table><thead><tr><th width="220">Permission</th><th width="120">Type</th><th>Why Akto needs it</th></tr></thead><tbody>
<tr><td><code>AdvancedQuery.Read.All</code></td><td>Application</td><td><strong>Critical</strong> — Run KQL Advanced Hunting queries (<code>POST /api/advancedqueries/run</code>) used to discover installed AI software and AI CLI process activity.</td></tr>
<tr><td><code>Machine.ReadWrite.All</code></td><td>Application</td><td>List onboarded devices (<code>GET /api/machines</code>), read Live Response action status (<code>GET /api/machineactions/{id}</code>), and obtain the result download link (<code>GetLiveResponseResultDownloadLink</code>). Microsoft requires <code>Machine.ReadWrite.All</code> (not just <code>Machine.Read.All</code>) for the download-link endpoint.</td></tr>
<tr><td><code>Machine.LiveResponse</code></td><td>Application</td><td><strong>Critical</strong> — Initiate Live Response sessions on devices (<code>POST /api/machines/{id}/runliveresponse</code>) to deploy Akto guardrails or run discovery scripts.</td></tr>
<tr><td><code>Library.Manage</code></td><td>Application</td><td>Upload Akto scripts to the Live Response file library (<code>POST /api/libraryfiles</code>) before they can be executed on devices.</td></tr>
</tbody></table>

</details>

<details>

<summary><strong>Additional Defender configuration (not API permissions)</strong></summary>

API permissions alone are not enough for Live Response. Also confirm:

1. **Microsoft Defender for Endpoint Plan 2** license — Live Response is a Plan 2-only capability.
2. **Live Response feature enabled** in `Settings → Endpoints → Advanced features → Live Response`. Enable `Live Response for servers` and `Live Response unsigned script execution` if your discovery scripts are unsigned or your targets include servers/Linux/macOS.
3. **Device group automated remediation level** must be at least **Standard** for every group Akto should reach. Groups configured as **No remediation** will reject Live Response API calls.
4. **Defender RBAC** — If your tenant uses Defender role-based access (instead of the default *Use basic permissions*), the app's service principal must be assigned a custom role with **View data** + **Active remediation actions**, scoped to the relevant device groups.

</details>

<details>

<summary><strong>Common 403 errors and what they mean</strong></summary>

| Error | Cause |
| --- | --- |
| `Missing application roles. API required roles: Machine.Read.All, Machine.ReadWrite.All` | `Machine.ReadWrite.All` is missing or admin consent wasn't granted. |
| `Missing application roles. API required roles: AdvancedQuery.Read.All` | `AdvancedQuery.Read.All` is missing or admin consent wasn't granted. |
| `Forbidden — needs minimum remediation level` | Device group automated remediation is **No remediation** — raise to **Standard** or higher. |

</details>

## Option 1: Run Live Response Scripts

You run scripts on selected devices to actively collect data.

Use this when you want to:

* Deploy Akto collectors
* Extract API traffic or logs
* Gather system/network metadata from endpoints

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1).png" alt="" width="375"><figcaption></figcaption></figure></div>

### Steps to Run

{% stepper %}
{% step %}
**Select Live Response**

Choose **Live Response** from the Run Queries screen.
{% endstep %}

{% step %}
**Select Devices**

Search and select the devices where you want to run your script.

* You can select multiple devices
* Scripts will run sequentially on each device
{% endstep %}

{% step %}
**Add Your Script**

You have two options:

* **Upload new script**
* **Use existing library script**

Supported formats:

* `.ps1` (Windows)
* `.sh` (macOS/Linux)
* `.bat`
{% endstep %}

{% step %}
**(Optional) Add Script Parameters**

You can pass parameters to your script at runtime.

Example:

```
AKTO_PROXY_URL=https://example.ngrok-free.dev/v1
```
{% endstep %}

{% step %}
**Run the Script**

Click **Run on Selected Devices** to execute the script.
{% endstep %}
{% endstepper %}

### What Happens Next

* The script runs remotely via Microsoft Defender
* Guardrails are installed on each selected device
* Execution happens sequentially per endpoint

### Example Use Cases

You use Live Response primarily to:

* Deploy **Akto guardrails** across endpoint devices
* Enforce safe usage policies for agentic AI tools
* Standardize security controls across your organization

## Option 2: Run KQL Queries

You can query existing Microsoft Defender telemetry using Kusto Query Language (KQL).

You use KQL queries to:

* Detect installations of agentic tools such as:
  * Cursor
  * Claude
  * Other AI-assisted development tools
* Identify which devices are running these applications
* Monitor adoption and potential risk exposure

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (2) (1) (1) (1) (1).png" alt="" width="375"><figcaption></figcaption></figure></div>

### Steps to Run

{% stepper %}
{% step %}
**Select KQL Query**

Switch to the **KQL Query** tab.
{% endstep %}

{% step %}
**Enter Your Query**

Example:

```kql
DeviceNetworkEvents
| where RemotePort == 443
| project DeviceName, RemoteIP, RemoteUrl
| limit 100
```
{% endstep %}

{% step %}
**Run Query**

Click **Run Query** to execute.
{% endstep %}
{% endstepper %}

## What You Get

You’ll receive structured results showing:

* Devices with agentic tools installed
* Software versions
* Visibility into tool distribution across your organization

#### Best Practices for You

* Always filter results to keep queries fast
* Use `limit` to control output size
* Focus on relevant fields like `RemoteUrl`
* Start simple, then refine queries

## What Next

Now that you’ve configured and used Microsoft Defender Run Queries, you can proceed with:

*   **Deploy via Microsoft Defender Endpoints**\
    Continue setting up endpoint-level integration and guardrail deployment:

    [.](./ "mention")
*   **Need Help?**\
    Reach out to the Akto team or explore support resources:

    [support.md](../../../troubleshooting/support.md "mention")
