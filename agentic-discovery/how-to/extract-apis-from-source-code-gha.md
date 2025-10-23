---
hidden: true
description: Extract agent components from GitHub repositories using Akto's GitHub Action for continuous discovery.
---

# Extract Agent Components from GitHub using GitHub Actions

You can extract agent components and MCP endpoints from your GitHub code repositories using our [GitHub Action](https://github.com/akto-api-security/code-analysis-action). This enables continuous discovery of your agentic systems as code changes.

## How to Use

Prepare the following variables:

1. `AKTO_API_KEY` - Go to My accounts > Settings > Integrations > Akto API > Generate token. Copy the token generated
2. `AKTO_DASHBOARD_URL` - URL of your Akto dashboard. Please ensure the GitHub Action runner can access the Akto dashboard
3. `COLLECTION_NAME` - The agentic collection name into which you want to import the extracted components. Ensure that this collection exists

## Setup GitHub Action

Add a step in your GitHub Action workflow based on the following example:

```yaml
- name: Akto Agentic Code Analysis
  uses: akto-api-security/code-analysis-action@v1
  with:
    AKTO_DASHBOARD_URL: "<AKTO_DASHBOARD_URL>"
    AKTO_API_KEY: ${{ secrets.AKTO_API_KEY }}
    COLLECTION_NAME: production_ai_agents
```

## Complete Workflow Example

Here's a complete GitHub Actions workflow for continuous agent component discovery:

```yaml
name: Agentic Security - Component Discovery

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  discover-agents:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Akto Agentic Code Analysis
        uses: akto-api-security/code-analysis-action@v1
        with:
          AKTO_DASHBOARD_URL: ${{ secrets.AKTO_DASHBOARD_URL }}
          AKTO_API_KEY: ${{ secrets.AKTO_API_KEY }}
          COLLECTION_NAME: production_ai_agents
```

## What Gets Analyzed

The GitHub Action scans your repository to discover:

- **AI Agent Implementations**: LangChain, LlamaIndex, CrewAI, AutoGen agents
- **MCP Server Definitions**: Model Context Protocol server implementations
- **Agent Endpoints**: HTTP endpoints exposing agent functionality
- **Tool Registrations**: Custom tools and functions for agents
- **LLM Integrations**: OpenAI, Anthropic, Google, and other provider integrations
- **Framework Configurations**: Agent framework setup and configurations

## Results

### GitHub Workflow Summary

1. A summary of all extracted agent components is available in the GitHub workflow run summary
2. The summary includes a list of new agent components added in the present commit
3. Changes to existing components are highlighted for review

### Akto Dashboard

1. The agentic collection specified by `COLLECTION_NAME` can be viewed in the Akto dashboard under **Agentic Discovery > Collections**
2. All extracted components include direct links to source code locations in GitHub
3. Components are automatically categorized by type (Agent, MCP Server, Tool, etc.)

## Use Cases

- **Continuous Discovery**: Automatically detect new agent components on every commit
- **PR Security Checks**: Review agent security before merging code
- **Inventory Management**: Keep agentic inventory synchronized with codebase
- **Compliance**: Track all AI agent implementations for compliance requirements
- **Shadow Agent Detection**: Identify undocumented agent components

## Troubleshooting

If the action fails:
- Verify AKTO_API_KEY has write permissions
- Check that AKTO_DASHBOARD_URL is accessible from GitHub runners
- Ensure the collection exists in Akto before running
- Review action logs for specific error messages
- Verify repository structure matches supported frameworks
