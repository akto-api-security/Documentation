---
description: Identify and track sensitive data flowing through agent components and MCP endpoints.
---

# Sensitive Data

Akto comes with over 100+ built-in data types, many of which belong to the sensitive data category. Examples include Email, Phone Number, JWT tokens, Bearer tokens, API keys, and credentials. Akto allows you to identify which sensitive data your agent components and MCP endpoints are processing, transmitting, or storing. This is particularly useful in managing and securing your agentic systems.

## What is Sensitive Data in Agentic Systems?

Sensitive data in agentic systems includes traditional sensitive information plus agentic-specific patterns:

### Traditional Sensitive Data

- **Email** 📧 - Email addresses in agent inputs/outputs
- **Phone Number** ☎️ - Phone numbers processed by agents
- **Credit Card Number** 💳 - Payment information in agent context
- **IP Address** 🔢 - Network information in agent logs
- **SSN** 🆔 - Social Security Numbers
- **URL** 🌐 - URLs and endpoints accessed by agents
- **PAN Card** 💵 - Payment card numbers
- **JWT, Bearer Token** 🔑 - Authentication credentials

### Agentic-Specific Sensitive Data

- **API Keys** - LLM provider keys, external service credentials
- **System Prompts** - Instructions that control agent behavior
- **User Prompts** - Potentially sensitive user queries
- **Agent Context** - Conversation history containing PII
- **Tool Credentials** - Database passwords, service account keys
- **MCP Auth Tokens** - MCP server authentication tokens
- **Embeddings** - Vector representations of sensitive content
- **Model Parameters** - LLM configuration that might leak information

## Why Sensitive Data Matters for Agents

### Privacy Risks

**Context Window Leakage**: Sensitive data can persist in agent conversation history and be accidentally included in subsequent responses or logging.

**Prompt Injection**: Attackers may try to extract sensitive data from agent context through carefully crafted prompts.

**Tool Access**: Agents with access to sensitive databases or APIs can inadvertently expose data through responses.

**Third-Party LLMs**: Data sent to external LLM providers (OpenAI, Anthropic) leaves your infrastructure.

### Compliance Requirements

- **GDPR**: Track personal data processed by AI agents
- **HIPAA**: Monitor health information in healthcare agents
- **PCI-DSS**: Ensure payment data isn't leaked through agents
- **SOC 2**: Audit sensitive data handling in agentic workflows

## Detect Sensitive Data

Akto automatically scans agent components and MCP endpoints to identify sensitive data in:
- **Agent Inputs**: User prompts and queries
- **Agent Outputs**: LLM responses and generated content
- **Tool Invocations**: Data passed to MCP tools
- **Context/Memory**: Conversation history and agent state
- **Embeddings**: Vector database content
- **API Responses**: Data retrieved by agents from external sources

### How to View Sensitive Components

1. Navigate to **Agentic Discovery > Collections**
2. Select any Agent or MCP Collection
3. Click on the **Sensitive** tab to view all components sharing sensitive data
4. Filter by specific data types (e.g., Email, API_KEY, SSN)

### Example: Finding Sensitive Email Data

When you click on a component flagged for EMAIL data, you can see:
- **Request**: Where the email appears in the agent input
- **Response**: If email data is included in agent output
- **Context**: Whether email persists in conversation history
- **Tool Calls**: If email is passed to MCP tools

You might discover that an agent component:
- Receives EMAIL in user prompts
- Stores EMAIL in conversation context
- Passes EMAIL to a database MCP tool
- Returns EMAIL in generated responses

## Managing Sensitive Data

### Set Data Sensitivity

You can configure where specific data types should be treated as sensitive:
- In agent prompts (always sensitive)
- In agent responses (configurable)
- In tool invocations (highly sensitive)
- In logging and monitoring (should be redacted)

For more information: [Set Sensitivity of a Data Type](../how-to/set-sensitivity-of-a-data-type.md)

### Redact Sensitive Data

Akto can automatically redact sensitive data from:
- Agent logs and monitoring
- Context window snapshots
- Security testing reports
- Exported data

For more information: [Redact Sensitive Data](../how-to/redact-sensitive-data.md)

### Custom Sensitive Data Types

Create custom patterns for your organization:
- Internal user IDs
- Transaction identifiers
- Custom API key formats
- Business-specific sensitive patterns

For more information: [Create a Custom Data Type](../how-to/create-a-custom-data-type.md)

## Sensitive Data in MCP Servers

MCP servers often have access to highly sensitive resources:

**Database MCP**: Direct access to customer databases
- PII, financial records, health information
- Credentials stored in MCP configuration

**Filesystem MCP**: Access to local files
- Configuration files with secrets
- User documents and personal files

**GitHub MCP**: Access to code repositories
- API keys in code
- Customer data in test fixtures
- Internal credentials in config files

**Web MCP**: Can fetch any URL
- Internal admin panels
- Sensitive documents via URLs
- Data exfiltration risk
