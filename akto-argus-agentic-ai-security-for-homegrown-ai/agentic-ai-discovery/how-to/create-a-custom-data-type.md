---
description: Create custom data types for agentic-specific patterns in your organization.
---

# Create a Custom Data Type

Akto comes with 50+ built-in data types. Create custom types for business-specific patterns in your agent systems.

## Common Agentic Custom Data Types

- Transaction IDs (e.g., "TXN_12345")
- Agent IDs or session tokens
- Custom API key formats
- Tool invocation signatures
- Context window identifiers

## How to Create

1. Go to **Agentic Discovery > Sensitive Data**
2. Click **Create Custom Data Type**
3. Enter name (e.g., "AGENT_SESSION_ID")
4. Define key and value conditions
5. Save

## Add Key Conditions

Define how Akto should detect the key:
- **Equals to**: Exact match (e.g., key = "agent_id")
- **Matches regex**: Pattern match (e.g., key matches `agent_.*`)
- **Contains**: Partial match

## Add Value Conditions

Define how Akto should detect the value:
- **Matches regex**: Pattern for value (e.g., `\bagent_[a-z0-9]{16}\b`)
- **Equals to**: Exact value match
- **Length**: Value length constraints

## AktoGPT

Use AktoGPT to generate regex patterns automatically:

1. Click **AktoGPT** button
2. Describe your pattern (e.g., "agent session ID with prefix")
3. Review generated regex
4. Add to Akto

## Example: Agent Session ID

**Key Condition**: Equals to "agent_session"
**Value Condition**: Matches regex `\bagt_[a-f0-9]{32}\b`

This detects patterns like: `agent_session: "agt_a1b2c3d4..."`

## Best Practices

- Test regex patterns before adding
- Document custom data types for your team
- Review detected instances to verify accuracy
- Use AktoGPT for complex patterns
