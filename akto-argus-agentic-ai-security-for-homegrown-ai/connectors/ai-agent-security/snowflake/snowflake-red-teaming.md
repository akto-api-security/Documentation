---
description: Red team your Snowflake AI agents and Cortex endpoints with Akto.
---

# Snowflake Red Teaming

## Overview

Akto lets you run security probes against Snowflake-based AI agents and Cortex endpoints. This guide walks you through generating a Snowflake Programmatic Access Token (PAT), configuring a Scan Role, and running a red teaming scan.


## Step 1: Generate a Snowflake PAT Token

Akto uses a Snowflake Programmatic Access Token (PAT) to authenticate scan requests against your Snowflake endpoints. You can generate one via the Snowflake UI or via a SQL query.

{% tabs %}
{% tab title="Via Snowflake UI" %}
{% stepper %}
{% step %}
**Log in to Snowflake**

Log in to [Snowsight](https://app.snowflake.com).
{% endstep %}

{% step %}
**Go to Governance & Security**

From the left navigation, go to **Governance & Security**.

<div data-with-frame="true"><figure><img src="../../../../.gitbook/assets/image (114).png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
**Select the User**

Select the user you want to generate the token for.

<div data-with-frame="true"><figure><img src="../../../../.gitbook/assets/image (133).png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
**Generate the Token**

Under the **Programmatic Access Tokens** section, click **Generate Token**.

<div data-with-frame="true"><figure><img src="../../../../.gitbook/assets/image (143).png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
**Fill in Token Details**

Enter the following:

* **Name** — a descriptive label for the token (e.g. `akto-red-teaming`)
* **Comment** — an optional note for context
* **Expiry** — set an appropriate expiry duration
* **Role** — grant access to the relevant Snowflake role

<div data-with-frame="true"><figure><img src="../../../../.gitbook/assets/image (158).png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
**Copy and Save the Token**

Click **Generate**. Copy and save the token — it will not be shown again.
{% endstep %}
{% endstepper %}
{% endtab %}

{% tab title="Via SQL Query" %}
Run the following command in a Snowflake worksheet:

```sql
ALTER USER <your_username> ADD PROGRAMMATIC ACCESS TOKEN <token_name>
  DAYS_TO_EXPIRY = 90
  COMMENT = 'Akto red teaming token';
```

{% hint style="warning" %}
Copy and store the token immediately. Snowflake does not allow you to retrieve it again after generation.
{% endhint %}
{% endtab %}
{% endtabs %}

***

## Step 2: Configure a Scan Role

Create a Scan Role in Akto that uses the PAT token and scopes it to your Snowflake endpoints.

Follow the [Create a Scan Role](../../../agentic-red-teaming/how-to/create-a-test-role.md) guide and apply the Snowflake-specific settings below.

### Snowflake Scan Role Configuration

| Field | Value |
|---|---|
| **Role Name** | e.g. `snowflake-test-role` |
| **Endpoint condition** | `Endpoint` → `contains` → `snowflakecomputing.com` |
| **Auth type** | Hard-coded |
| **Header Key** | `Authorization` |
| **Header Value** | `Bearer <your-pat-token>` |

{% hint style="info" %}
The endpoint condition `snowflakecomputing.com` ensures this auth token is applied only to Snowflake requests and not to any other agentic traffic.
{% endhint %}

***

## Step 3: Run Red Teaming Scan

Once the Scan Role is configured, select your Snowflake agent components, choose the relevant probe categories, and select the Scan Role configured in Step 2 under **Scan Execution Parameters**.

For detailed steps, see [Run Scan](../../../agentic-red-teaming/how-to/run-test.md).

***

## Get Support

There are multiple ways to request support from Akto. We are 24X7 available on the following:

* **In-app chat**: Use the Intercom widget in your Akto dashboard and someone will reply.
* **Discord community**: Join our community at [akto.io/community](https://www.akto.io/community).
* **Email support**: Contact us at [support@akto.io](mailto:support@akto.io).
