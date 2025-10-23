---
description: Learn how to export agent and MCP collections to Burp Suite for manual security testing.
hidden: true
---

# Export an Agentic Collection to Burp

Akto allows you to export any of your agent or MCP collections and import them into your Burp Suite setup. This enables you to use Burp Suite's powerful manual testing capabilities to interact with and test your AI agents and MCP endpoints however you want. It's a handy way to perform deep security analysis on agentic components right from your local Burp Suite.

## Setup Akto Extension in Burp Suite

To export collections to Burp, you first need to install and configure the Akto extension in Burp Suite.

### Installation Steps

1. Navigate to **Quick Start > Burp Suite > Configure** in your Akto dashboard
2. Click **Download** to download the executable JAR file (Akto extension for Burp Suite)
3. Open Burp Suite and go to the **Extensions** tab
4. Click **Add** and select the downloaded JAR file
5. Once loaded, click on the **Options** tab inside the Akto plugin

### Configuration Steps

1. Copy the **AKTO_IP** value from your Akto account
2. Copy the **AKTO_TOKEN** value from your Akto account
3. Paste both values into the Options tab of the Akto plugin in Burp Suite
4. Click **Save** to confirm the configuration

{% hint style="info" %}
A **JAR file** is used to install extensions in Burp Suite, which add additional functionalities or modules that enhance the capabilities of this security testing software. The Akto JAR file enables seamless integration between Akto and Burp Suite.
{% endhint %}

## Export a Collection to Burp

Once the Akto plugin is configured in Burp Suite:

1. In the Akto plugin within Burp Suite, enter the name of the collection you want to export
2. Click on **Import from Akto**
3. The collection will be imported into Burp Suite with all agent components and MCP endpoints

## What Gets Exported

When you export a collection to Burp, you receive:

- **Agent Components**: All AI agent endpoints with their request/response structures
- **MCP Endpoints**: All Model Context Protocol tools and resources
- **Sample Requests**: Example requests for each component
- **Authentication Details**: Configured authentication methods (if applicable)
- **Parameters**: Input and output parameters for each component

## Use Cases for Burp Suite Integration

- **Manual Security Testing**: Perform in-depth manual testing on agent components
- **Custom Attack Scenarios**: Create custom attacks specific to agentic vulnerabilities
- **Intercepting Traffic**: Use Burp Proxy to intercept and modify agent requests
- **Advanced Scanning**: Leverage Burp's scanner for deeper vulnerability analysis
- **Payload Crafting**: Manually craft payloads to test prompt injection and tool misuse
- **Session Testing**: Test authentication and session management in agentic workflows

## Troubleshooting

If the export fails:
- Verify AKTO_IP and AKTO_TOKEN are correct
- Check network connectivity between Burp Suite and Akto
- Ensure the collection name is exact (case-sensitive)
- Verify you have permissions to access the collection in Akto
