---
description: Red team your Snowflake AI agents and Cortex endpoints with Akto.
---

# Snowflake Red Teaming

Akto lets you run security probes against Snowflake-based AI agents and Cortex endpoints. This guide walks you through generating a Snowflake Programmatic Access Token (PAT), configuring a Scan Role, and running a red teaming scan.

## Step 1: Generate a Snowflake PAT Token

Akto uses a Snowflake Programmatic Access Token (PAT) to authenticate scan requests against your Snowflake endpoints. You can generate one via the Snowflake UI or via a SQL query.

### Option A: Via the Snowflake UI

{% stepper %}
{% step %}
Log in to [Snowflake](https://app.snowflake.com).
{% endstep %}

{% step %}
From the left navigation, go to **Governance & Security**.

<div data-with-frame="true"><figure><img src="../../../../.gitbook/assets/image (114).png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
Select the **user** you want to generate the token for.

<div data-with-frame="true"><figure><img src="../../../../.gitbook/assets/image (133).png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
Under the **Programmatic Access Tokens** section, click **Generate Token**.

<div data-with-frame="true"><figure><img src="../../../../.gitbook/assets/image (143).png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
Fill in the token details:

* **Name** - a descriptive label for the token (e.g. `akto-red-teaming`)
* **Comment** - an optional note for context
* **Expiry** - set an appropriate expiry duration
* **Role** - grant access to the relevant Snowflake role

<div data-with-frame="true"><figure><img src="../../../../.gitbook/assets/image (158).png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
Click **Generate**. Copy and save the token - it will not be shown again.
{% endstep %}
{% endstepper %}

### Option B: Via SQL Query

Run the following command in a Snowflake worksheet:

```sql
ALTER USER <your_username> ADD PROGRAMMATIC ACCESS TOKEN <token_name>
  DAYS_TO_EXPIRY = 90
  COMMENT = 'Akto red teaming token';
```

{% hint style="warning" %}
Copy and store the token immediately. Snowflake does not allow you to retrieve it again after generation.
{% endhint %}

***

## Step 2: Configure a Scan Role

Create a Scan Role in Akto that uses the PAT token and scopes it to your Snowflake endpoints.

Follow the [Create a Scan Role](../../../agentic-red-teaming/how-to/create-a-test-role.md) guide and apply the Snowflake-specific settings below.

### Snowflake Scan Role Configuration

<table><thead><tr><th width="352.53125">Field</th><th>Value</th></tr></thead><tbody><tr><td><strong>Role Name</strong></td><td>e.g. <code>snowflake-test-role</code></td></tr><tr><td><strong>Endpoint condition</strong></td><td><code>Endpoint</code> → <code>contains</code> → <code>snowflakecomputing.com</code></td></tr><tr><td><strong>Auth type</strong></td><td>Hard-coded</td></tr><tr><td><strong>Header Key</strong></td><td><code>Authorization</code></td></tr><tr><td><strong>Header Value</strong></td><td><code>Bearer &#x3C;your-pat-token></code></td></tr></tbody></table>

{% hint style="info" %}
The endpoint condition `snowflakecomputing.com` ensures this auth token is applied only to Snowflake requests and not to any other agentic traffic.
{% endhint %}

***

## Step 3: Run Red Teaming Scan

Once the Scan Role is configured, run the security scan against your Snowflake agent components.

{% stepper %}
{% step %}
Navigate to **Agentic Discovery > Collections** and select the collection containing your Snowflake agent components.
{% endstep %}

{% step %}
Select the agent components you want to probe, then click **Run Scan**.
{% endstep %}

{% step %}
Choose the probe categories relevant to your Snowflake agents (e.g. **Prompt Injection**, **Sensitive Information Disclosure**, **Excessive Agency**).
{% endstep %}

{% step %}
Under **Scan Execution Parameters**, select the Scan Role you created in Step 2 from the **Select Scan Role** dropdown.
{% endstep %}

{% step %}
Click **Run once now** to start the scan.
{% endstep %}
{% endstepper %}

For a full description of all scan execution parameters, see [Run Scan](../../../agentic-red-teaming/how-to/run-test.md).

***

### Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
