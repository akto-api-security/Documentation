# Akto MCP Server

### **What is Model Context Protocol?**

The Model Context Protocol (MCP) is a standardized protocol that enables AI models to interact with external tools and services. In the context of Akto, the MCP server acts as a bridge between AI-powered tools (like Claude, Cursor, etc.) and Akto's API security platform, allowing these tools to access and analyze your API security data.

{% embed url="https://youtu.be/QXdGqadpos4" %}

### **Prerequisites**

* Docker installed and running
* Akto API Key

***

### **Getting Started**

#### **Step 1: Generating an API Key**

For detailed information about generating and managing API keys, refer to the [Akto API Reference Documentation](../api-reference/api-reference.md).

<figure><img src="../.gitbook/assets/image (2).png" alt=""><figcaption></figcaption></figure>

#### **Step 2: Configuring MCP Clients**

{% tabs fullWidth="false" %}
{% tab title="Cursor" %}
1. **Open Settings**
   * Launch Cursor
   * Go to Settings
   * Navigate to the MCP tab
2.  **Add MCP Server**

    * Click "Add new global MCP server"
    * Paste the following configuration:

    ```json
    {
      "mcpServers": {
        "akto-mcp-server": {
          "command": "docker",
          "args": [
            "run",
            "--rm",
            "-i",
            "-e",
            "AKTO_API_KEY",
            "aktosecurity/akto-mcp-server:latest"
          ],
          "env": {
            "AKTO_API_KEY": "your_api_key"
          }
        }
      }
    }

    ```

    * Replace `your_api_key` with your actual API key
    * Click Save to activate
    * Check the status of the server by clicking on the "MCP" tab and looking for "akto-mcp-server" under Active Servers
{% endtab %}

{% tab title="Claude Desktop" %}
1. **Locate Config File**
   * macOS: `~/Library/Application Support/Claude/claude_desktop_config.json`
   * Windows: `%APPDATA%\\Claude\\claude_desktop_config.json`
2.  **Update Configuration**

    * Add the following configuration:

    ```json
    {
      "mcpServers": {
        "akto-mcp-server": {
          "command": "docker",
          "args": [
            "run",
            "--rm",
            "-i",
            "-e",
            "AKTO_API_KEY",
            "aktosecurity/akto-mcp-server:latest"
          ],
          "env": {
            "AKTO_API_KEY": "your_api_key"
          }
        }
      }
    }

    ```

    * Replace `your_api_key` with your actual API key
    * Save the file
    * Restart Claude Desktop
    * Open Claude's Settings > MCP tab to check server status and connection details
{% endtab %}
{% endtabs %}

Each tool is designed to work seamlessly with AI models to provide comprehensive access to your API security data and analysis capabilities.

***

### **Feature Highlights**

The MCP server provides easy access to Akto's powerful API security features through AI tools. Here's what you can do:

1. **View Your APIs**: Get a complete list of all your APIs and their details in one place
2. **Track API Changes**: Monitor new endpoints and changes in your API landscape
3. **Find Security Issues**: Automatically detect vulnerabilities and security risks in your APIs
4. **Analyze Sensitive Data**: Identify and track sensitive information in your API responses
5. **Monitor API Health**: Keep track of API performance and security status
6. **Track Issues**: View and monitor the status of security issues
7. **Get Security Insights**: Receive AI-powered analysis and recommendations for your APIs
8. **View Risk Scores**: Access risk scores for your APIs to understand their security posture

Each of these capabilities is designed to work seamlessly with AI tools like Claude and Cursor, making API security management more intuitive and efficient.

***

### Prompt Examples

1. List active API collections.
2. How many endpoints in `Collection_Name`? Show the one with the highest risk.
3. List top 5 high severity issues.
4. Get schema for API: `API_Path`
5. How many test runs in the last 48 hours?
6. Summarize issues by status (open, ignored, fixed) and severity.
7. List sensitive parameters for `API_Path`

***

### **Troubleshooting**

#### **Server Connection Issues**

* Verify API key is correct
* Check network connectivity
* Ensure Docker is running
* Verify Docker image pull was successful

#### **Client Configuration**

* Validate JSON configuration
* Check file permissions
* Verify environment variables
* Ensure Docker image name is correct (`aktosecurity/akto-mcp-server`)

***

### Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
