---
description: Create custom tags to organize agent and MCP collections.
---

# Create New Tags

Create custom tags to categorize agent components and MCP endpoints.

## How to Create

1. Go to **Settings > Tags**
2. Click **Create new tags**
3. Enter tag name (e.g., "langchain-agents")
4. Define conditions:
   - **Parameter Name**: Component field to match
   - **Condition**: Matches regex, Starts with, etc.
   - **Value**: Matching pattern
5. Click **Save**

## Examples

**Tag: high-risk-mcp**
- Condition: MCP tool permissions contain "write"
- Value: "write"

**Tag: production-agents**
- Condition: Environment type equals "production"
- Value: "production"

**Tag: openai-powered**
- Condition: LLM provider matches
- Value: "openai"

## Tips

- Use clear, descriptive names
- Create tag hierarchies (e.g., agent-chat, agent-chat-langchain)
- Use regex for flexible matching
- Test conditions before saving
