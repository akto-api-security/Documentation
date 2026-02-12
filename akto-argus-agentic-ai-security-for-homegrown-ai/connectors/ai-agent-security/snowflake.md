# Snowflake

## Overview

Snowflake is a cloud-based data platform that enables organizations to build data pipelines, analytics, and AI applications. Connect Akto Argus to your Snowflake account to discover Cortex-based agents and fetch related metadata.

The visibility helps you identify agentic workloads running in Snowflake and assess associated security risks. Once connected, Akto Argus automatically:

* **Discovers Cortex AI Agents**: Fetches all AI agents built using Snowflake Cortex from your account
* **Monitors Agent Activity**: Captures agent execution data, including prompts, responses, and API interactions
* **Sends Traffic to Akto**: Transmits API traffic data to Akto for comprehensive security analysis

## Prerequisites

Before setting up the Snowflake connector, ensure you have completed the following:

1. **Traffic Processor** – Configure your Traffic Processor first. Follow the [Hybrid SaaS Setup Guide](../others/hybrid-saas.md) for detailed instructions.
2. **Snowflake Account** – Active Snowflake account with Cortex AI capabilities enabled
3. **Authentication Credentials** – One of the following authentication methods:
   * Username and password
   * OAuth token
   * RSA key pair (recommended for production)
4. **Network Access** – Ensure connectivity between the connector service and:
   * Your Snowflake account URL
   * Akto Data Ingestion Service
   * Kafka broker endpoint

## Steps to Connect

{% stepper %}
{% step %}
#### Open the Snowflake Connector in Akto Argus

1. Navigate to **Akto Argus**.
2. Open **Connectors**.
3. Under **AI Agent Security**, locate the **Snowflake** connector card.
4.  Select **Connect** to open setup dialog.

    <div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (9).png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
#### Enter the Snowflake Account URL

Enter the base URL of your Snowflake account in the **Snowflake Account URL** field.

* Format:\
  `https://<account_identifier>.<region>.snowflakecomputing.com`
* The value can be obtained from:
  * The browser address bar when accessing the Snowflake UI, or
  * Snowflake account settings.
{% endstep %}

{% step %}
#### Select the Authentication Method

Select the authentication method used to access your Snowflake account from the **Authentication Method** dropdown.

Available options:

{% tabs %}
{% tab title="Username & Password" %}
* Enter the Snowflake username in the **Username** field.
  * The username must exist in the target Snowflake account.
  * The user must have permissions to query Cortex-related metadata.
* Enter the password for the specified Snowflake user in the **Password** field.

{% hint style="info" %}
The password is used only for authentication. Akto Argus does not modify Snowflake configuration.
{% endhint %}

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (6).png" alt="" width="375"><figcaption></figcaption></figure></div>
{% endtab %}

{% tab title="OAuth Token" %}
Enter a valid Snowflake OAuth access token in the **OAuth Token** field.

* The token must be generated using a Snowflake-configured OAuth integration.
*   The token must grant read access to required metadata.

    <div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (7).png" alt="" width="375"><figcaption></figcaption></figure></div>
{% endtab %}

{% tab title="Key Pair (RSA)" %}
* Enter the Snowflake username associated with the RSA key pair.
  * The user must have the public key registered in Snowflake.
* Paste the RSA private key in PEM format into the **Private Key (RSA)** field.
  *   Format:

      ```
      -----BEGIN PRIVATE KEY-----
      ...
      -----END PRIVATE KEY-----
      ```
  * The corresponding public key must already be associated with the Snowflake user.
*   If the private key is encrypted, enter the passphrase in the **Private Key Passphrase** field.

    <div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (8).png" alt="" width="375"><figcaption></figcaption></figure></div>
{% endtab %}
{% endtabs %}
{% endstep %}

{% step %}
#### Specify Warehouse, Database, and Schema(Optional)

You may optionally specify:

* **Warehouse**
* **Database**
* **Schema**

These fields control query execution context.

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (5).png" alt="" width="375"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
#### Enter the Data Ingestion Service URL

Enter the URL of your **self-hosted data ingestion service** in the **URL for Data Ingestion Service** field in order to forward agent execution and telemetry data into your environment for processing.

{% hint style="warning" %}
### Note

* The ingestion service must be deployed and exposed in your infrastructure.
* The URL must be reachable from Akto.
* The endpoint receives metadata collected by Akto for this connector.
{% endhint %}
{% endstep %}

{% step %}
#### Complete the Integration

1. Review all entered values.
2. Select **Import** to finalize the connection.
{% endstep %}
{% endstepper %}

## Data Collection

The Snowflake connector captures two categories of information:

### Agent Metadata

* **Cortex AI Agents**: All AI agents built using Snowflake Cortex in your account
* **Agent Configurations**: Model selection, parameters, and settings
* **Cortex Functions**: Usage of built-in Cortex AI functions (COMPLETE, SENTIMENT, TRANSLATE, etc.)

### Agent Execution Data

* **Recent Activity**: Agent executions from the past 60 minutes
* **Input Data**: Prompts, queries, and parameters sent to agents
* **Output Data**: Agent responses and generated content
* **API Interactions**: External API calls made by agents
* **Performance Metrics**: Execution time and resource consumption

## Troubleshooting

### Connection Issues

**Problem**: Cannot connect to Snowflake account

**Solutions**:

* Verify `SNOWFLAKE_ACCOUNT_URL` is correct and includes the region (e.g., `xyz12345.us-east-1.snowflakecomputing.com`)
* Ensure network connectivity from the connector to Snowflake
* Check firewall rules allow outbound HTTPS connections to Snowflake

### Authentication Errors

**Problem**: Authentication failed

**Solutions**:

* **For Password Auth**: Verify username and password are correct
* **For Token Auth**: Ensure OAuth token is valid and not expired
* **For Key Pair Auth**:
  * Verify public key is registered in Snowflake (`DESC USER username`)
  * Ensure private key format is correct (PKCS#8 PEM format)
  * Check passphrase if the private key is encrypted

### Permission Issues

**Problem**: Access denied to warehouse/database/schema

**Solutions**:

*   Grant necessary permissions to your Snowflake user:

    ```sql
    -- Grant usage on warehouse
    GRANT USAGE ON WAREHOUSE COMPUTE_WH TO USER your_username;

    -- Grant usage on database
    GRANT USAGE ON DATABASE SNOWFLAKE TO USER your_username;

    -- Grant usage on schema
    GRANT USAGE ON SCHEMA SNOWFLAKE.PUBLIC TO USER your_username;

    -- Grant select on tables (for Cortex agent discovery)
    GRANT SELECT ON ALL TABLES IN SCHEMA SNOWFLAKE.PUBLIC TO USER your_username;
    ```

### No Agents Appearing

**Problem**: Connector is running but no agents appear in Akto

**Solutions**:

* Verify Snowflake Cortex is enabled in your account
* Ensure you have AI agents deployed in Snowflake
* Check `SNOWFLAKE_DATABASE` and `SNOWFLAKE_SCHEMA` point to the correct location
*   Review connector logs for errors:

    ```bash
    docker compose -f docker-compose-snowflake-cron.yaml logs -f
    ```
* Verify Traffic Processor is running and accessible

## Get Support

If you need assistance with the Snowflake connector:

* **In-app Chat**: Use the chat widget in your Akto dashboard for instant support
* **Discord Community**: Join our community at [discord.gg/Wpc6xVME4s](https://discord.gg/Wpc6xVME4s)
* **Email Support**: Contact us at [help@akto.io](mailto:help@akto.io)
* **Contact Form**: Submit a support request at [https://www.akto.io/contact-us](https://www.akto.io/contact-us)

Our team is available 24/7 to help with setup, troubleshooting, and best practices.
