---
description: Efficiently browse, filter, and organize agent components and MCP endpoints using Explore Mode.
---

# Explore Mode

Explore Mode allows users to efficiently browse and filter agent components and MCP endpoints from their existing inventory, and create collections based on the filtered results. It's a powerful tool for discovering and organizing your agentic systems.

## Key Features

### Filtering Agent Components

Explore Mode provides several filtering options to help users narrow down their agent and MCP endpoint search:

- **Collection**: Select from available agent or MCP collections
- **Component Type**: Filter by Agent, MCP Server, Tool, Resource
- **Endpoint**: Search for particular component endpoints
- **Method**: Filter by HTTP method (GET, POST, etc.) or protocol type
- **Path matches regex**: Use regular expressions to filter component paths
- **Host name matches regex**: Filter by host names using regex
- **Framework**: Filter by detected framework (LangChain, LlamaIndex, CrewAI, etc.)
- **LLM Provider**: Filter by AI provider (OpenAI, Anthropic, Google, etc.)

### Viewing Results

After applying filters, the interface displays:

1. **Summary**: e.g., "Listing 45 agent components out of total 191 components"
2. **Results Table** with the following information:
   - Component type (Agent, MCP Server, Tool, etc.)
   - Component path/endpoint
   - Risk score
   - Hostname
   - Access Type (Private, Public, Third-party)
   - Auth type (JWT, unauthenticated, custom headers)
   - Sensitive params
   - Framework detected
   - Source location
   - Last seen date

## Use Cases

### Discovering Shadow Agents

Filter for components with:
- No documentation
- High risk scores
- Recent discovery dates
- No standard authentication

### Finding High-Risk MCP Servers

Filter for MCP components with:
- Public access type
- Sensitive data handling
- Write permissions
- No authentication

### Organizing by Framework

Create collections for specific agent frameworks:
- All LangChain agents
- All LlamaIndex query engines
- All CrewAI multi-agent systems

### Compliance Auditing

Filter for components that:
- Handle PII or regulated data
- Are publicly accessible
- Lack proper authentication
- Have elevated risk scores

## Creating Collections from Explore Mode

Once you've filtered your results, you can:

1. Click **Create Collection** from filtered results
2. Name your collection descriptively
3. The collection is created with all filtered components
4. Use this collection for targeted security testing

Explore Mode streamlines the process of discovering and organizing agent components within your inventory, enabling more efficient agentic system management and security workflows.
