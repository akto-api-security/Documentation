---
description: Learn how to export agent and MCP collections to Postman for testing and documentation.
hidden: true
---

# Export an Agentic Collection to Postman

Exporting an agent or MCP collection to Postman allows you to use Postman's tools for testing your agentic components, including running tests, writing scripts, and visualizing responses. This makes working with AI agents and MCP servers easier and more efficient by providing a structured development and testing environment.

If your team uses Postman to maintain records of all components, you can use the export functionality from Akto. Once Akto has created an agentic inventory for you, you can export it to your Postman Workspace, ensuring that your team has access to the latest agent and MCP resources.

## Setup Postman Integration using API Keys

First, establish a connection between your Akto and Postman accounts through API Keys.

### Configuration Steps

1. Navigate to **Settings > Integrations > Postman > Configure** in Akto
2. Enter your Postman API Key
3. Select your Postman Workspace where you would like to establish integration
4. Click **Save** to confirm the integration

Your Postman account is now connected to Akto and ready to receive exported collections.

## Export Collection to Postman

Once you have configured Postman with your Akto account, you can easily export your agent and MCP collections to your Postman workspace.

### Export Steps

1. Navigate to **Agentic Discovery > Collections**
2. Select the collection you want to export (Agent Collection or MCP Collection)
3. Click on **Export > Postman**
4. Confirm the export in the dialog
5. The collection will appear in your Postman workspace within moments

## What Gets Exported

When you export a collection to Postman, you receive:

- **Agent Components**: All AI agent endpoints with their configurations
- **MCP Endpoints**: All Model Context Protocol tools, resources, and prompts
- **Request Examples**: Sample requests with parameters and payloads
- **Response Examples**: Expected responses from agent components
- **Authentication**: Configured authentication methods and credentials
- **Environment Variables**: Relevant variables for the collection
- **Documentation**: Auto-generated documentation for each component

## Use Cases for Postman Integration

- **Component Testing**: Test individual agent components and MCP endpoints
- **Team Collaboration**: Share agentic inventories with team members
- **Documentation**: Auto-generate and maintain component documentation
- **Integration Testing**: Test multi-step agent workflows
- **Mock Servers**: Create mock agent endpoints for development
- **Monitoring**: Set up monitors to check agent availability
- **CI/CD Integration**: Use Postman collections in automated pipelines

## Update Postman Collections Automatically

You can keep your Postman workspace synchronized with Akto:

1. Enable auto-sync in the Postman integration settings
2. Set the sync frequency (hourly, daily, or on-demand)
3. Akto will automatically update your Postman collections when new agent components are discovered

This ensures your team always has the latest agentic inventory in Postman.

## Troubleshooting

If the export fails:
- Verify your Postman API Key is valid and has write permissions
- Check that the selected Postman Workspace is accessible
- Ensure you have permissions to export the collection in Akto
- Verify network connectivity between Akto and Postman API
- Check Postman workspace limits haven't been exceeded
