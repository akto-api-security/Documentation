# Azure DevOps Boards

The Azure DevOps Boards integration in Akto allows you to seamlessly create and manage work items for agentic security vulnerabilities directly in your Azure Boards. This integration streamlines the process of tracking and remediating vulnerabilities in your AI agents, MCP endpoints, and LLM components, ensuring your teams stay aligned and proactive.

#### How It Works

Once integrated, Akto automatically pushes agentic security vulnerability findings as work items into your specified Azure Boards projects. This provides real-time visibility and traceability of agent component security issues within your existing DevOps workflow.

#### Setting Up the Integration

Follow these steps to integrate Azure DevOps Boards with Akto:

1. **Azure DevOps Board URL**
   * Enter the base URL of your Azure DevOps board dashboard.
   * Example:
     * `https://dev.azure.com`
     * `https://{organization}.visualstudio.com`
2. **Organization**
   * Input the name of your Azure DevOps organization.
   * This is the unique identifier for your DevOps environment.
3. **Personal Auth Token**
   * Generate a Personal Access Token (PAT) in Azure DevOps with the necessary permissions (typically, work item read/write).
   * Enter the token here to authorize Akto to create and manage work items.
4. **Projects**
   * List the project names where the work items should be created.
   * Use a comma-separated format for multiple projects (e.g., `Project1,Project2`).
5. **Save**
   * Click the **Save** button to complete the setup.

#### Example Setup

| Field                  | Example Value                       |
| ---------------------- | ----------------------------------- |
| Azure DevOps Board URL | `https://dev.azure.com`             |
| Organization           | `my-organization`                   |
| Personal Auth Token    | `****************`                  |
| Projects               | `Agentic-Security,Agent-Components` |

#### Permissions

Ensure your Personal Access Token has the following scopes:

* **Work Items (Read & Write)**
* **Project and Team (Read)**

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
