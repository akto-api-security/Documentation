# MCP Registry Integratio

## Overview

The MCP Registry integration allows you to configure external registry endpoints that Akto uses to discover and validate Model Context Protocol (MCP) servers. This integration defines the authoritative sources Akto queries for MCP server metadata during agentic discovery.

The integration supports official, third-party, and custom registries that implement the MCP Registry API specification.

## Integrating the MCP Registry

You can configure MCP registries from **Settings → Integrations → MCP Registry**.\
.

For integration follow the following steps:&#x20;

{% stepper %}
{% step %}
**Open MCP Registry settings**

Navigate to **Settings → Integrations → MCP Registry** to view existing configured registries.

<figure><img src="../.gitbook/assets/image (46).png" alt="" width="563"><figcaption></figcaption></figure>

{% hint style="info" %}
This page maintains the complete list of registry endpoints used by Akto.
{% endhint %}
{% endstep %}

{% step %}
**Add a new registry**

Select **Add Registry** to register a new MCP registry endpoint.
{% endstep %}

{% step %}
**Provide registry details**

Enter the following information:

* **Registry Name**: A descriptive identifier for the registry within Akto.
*   **Registry URL**: The full MCP Registry API endpoint, typically ending with `/v0/servers`.

    <figure><img src="../.gitbook/assets/image (1).png" alt="" width="563"><figcaption></figcaption></figure>

The registry URL must follow the MCP Registry API specification and must be reachable from the Akto instance.
{% endstep %}

{% step %}
**Save the configuration**

Save the registry configuration to include the registry in MCP server discovery.
{% endstep %}
{% endstepper %}

You can configure multiple registries simultaneously. All configured registries participate equally in discovery and validation.

## Testing a Connected Registry

Each configured registry includes a **Test Connection** option.

The connection test validates:

* Network accessibility from the Akto instance.
* API responsiveness of the registry endpoint.
* Basic compatibility with the MCP Registry API format.

<figure><img src="../.gitbook/assets/image.png" alt="" width="563"><figcaption></figcaption></figure>

Only registries that respond successfully are used for MCP server discovery and validation. This testing step helps confirm registry readiness before relying on registry data in agentic workflows.

{% hint style="warning" %}
## Important Notes

* All registries will be used for MCP server discovery and validation
* Custom registries must follow the MCP Registry API specification
* Ensure your custom registries are accessible from your Akto instance
{% endhint %}

## Configuration Impact

Configured MCP registries define:

* The scope of MCP server discovery.
* The sources used for MCP server validation.

This integration helps you manage MCP server provenance while keeping discovery behavior controlled and transparent.
