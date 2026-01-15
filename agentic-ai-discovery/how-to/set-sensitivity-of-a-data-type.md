---
description: Configure where data types should be treated as sensitive in agentic systems.
---

# Set Sensitivity of a Data Type

Control where data types are flagged as sensitive - in agent inputs, outputs, tool calls, or context.

## Why Set Sensitivity

Example: Flag "TOKEN" as sensitive only in agent responses, not in requests. This reduces noise while ensuring leaked credentials are caught.

## How to Configure

1. Go to **Agentic Discovery > Sensitive Data**
2. Click **"..."** on the data type
3. Select **Edit**
4. Choose sensitivity locations:
   - Agent Inputs (prompts, requests)
   - Agent Outputs (LLM responses)
   - Tool Invocations (MCP calls)
   - Context/Memory (conversation history)
   - All locations

## Agentic-Specific Sensitivity

**Agent Inputs**: User prompts, questions
- Sensitive: PII, credentials, secrets

**Agent Outputs**: LLM-generated responses
- Sensitive: Leaked credentials, PII in responses

**Tool Invocations**: MCP tool calls
- Sensitive: Database queries, file paths, API keys

**Context/Memory**: Agent conversation history
- Sensitive: Accumulated PII, session data

## Example: API Keys

Set API_KEY sensitive in:
- ✅ Agent Outputs (catch leaks)
- ✅ Tool Invocations (monitor access)
- ❌ Agent Inputs (expected to receive keys)
