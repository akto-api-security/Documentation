---
description: View data types such as EMAIL, IP_ADDRESS, JWT, SSN, PROMPT_INJECTION and many more for agentic systems.
---

# Data Types

## What is Data Type?

**Data Type** refers to the specific formats or structures used to represent different types of data in agent requests, responses, and MCP communications. Data types help identify sensitive information flowing through your agentic systems. For example:

- **EMAIL**: Email addresses in agent inputs/outputs
- **JWT**: JSON Web Tokens for authentication
- **ADDRESS**: Physical addresses processed by agents
- **IP_ADDRESS**: IP addresses in agent communications
- **PHONE_NUMBER**: Phone numbers handled by agents
- **API_KEY**: API keys for external services
- **PROMPT**: User prompts sent to AI agents
- **LLM_RESPONSE**: Responses from language models
- **TOOL_RESULT**: Results from tool invocations
- **MCP_RESOURCE**: MCP resource identifiers

## Agentic-Specific Data Types

In addition to standard data types, Akto recognizes agentic-specific patterns:

### Agent Communication Patterns

- **PROMPT_INJECTION**: Potential prompt injection attempts
- **SYSTEM_PROMPT**: System prompts and instructions
- **TOOL_INVOCATION**: Tool and function calls
- **AGENT_CONTEXT**: Conversation context and memory
- **EMBEDDINGS**: Vector embeddings for RAG systems

### Sensitive Agent Data

- **CREDENTIALS**: Database passwords, API keys in agent access
- **PII_IN_CONTEXT**: Personal data in agent conversation history
- **PROPRIETARY_DATA**: Business-sensitive information processed by agents
- **MCP_AUTH_TOKEN**: MCP server authentication tokens
- **MODEL_PARAMETERS**: LLM configuration parameters

## Customize Data Type

Akto comes with over 50 built-in data types by default, including specialized types for agentic systems. However, your organization might have unique data patterns specific to your AI agents.

### Custom Agentic Data Types

You might want to create custom data types for:

- **Transaction IDs**: Business-specific identifiers like "TXN_ID_12345"
- **Agent IDs**: Custom agent identification patterns
- **Tool Signatures**: Specific tool invocation patterns
- **Context Keys**: Custom context or memory keys
- **Resource Identifiers**: Internal resource naming conventions

If you have highly sensitive, non-standard data types, you can define the pattern in Akto. Afterward, Akto will inform you about which agent components are handling this data.


## Managing Data Types

### View All Data Types

Navigate to **Agentic Discovery > Data Types** to view all recognized data types, including:
- Built-in types
- Custom types
- Agentic-specific types
- Sensitivity levels

### Create Custom Data Type

For detailed instructions on creating custom data types for your agent systems, refer to: [Create a Custom Data Type](../how-to/create-a-custom-data-type.md)

### Set Sensitivity Levels

Mark data types as:
- **High Sensitivity**: Credentials, PII, financial data
- **Medium Sensitivity**: Business data, context information
- **Low Sensitivity**: Public data, system metadata
