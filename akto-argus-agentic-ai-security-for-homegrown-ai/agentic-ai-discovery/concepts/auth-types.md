# Auth types

Akto automatically detects standard authentication methods like JWT and Bearer authorization headers used by agent components and MCP endpoints. This helps in identifying and addressing potential security threats. Akto also supports custom authentication methods for agentic systems.

For example, if your agent uses a non-standard authentication method, such as sending the auth token under a custom header, Akto provides the flexibility to set this up as a custom auth type. Common authentication patterns for agents include:

- **Bearer tokens**: Standard OAuth/API key authentication
- **JWT tokens**: For stateless agent authentication
- **API keys**: LLM provider keys (OpenAI, Anthropic, etc.)
- **mTLS**: For secure agent-to-agent communication
- **Custom headers**: Non-standard auth implementations

Even if your agent's authentication method doesn't align with standard practices, Akto can analyze and secure it properly.
