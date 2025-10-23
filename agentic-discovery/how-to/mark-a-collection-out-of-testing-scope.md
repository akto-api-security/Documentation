---
description: Exclude agent and MCP collections from security testing.
---

# Mark a Collection Out of Testing Scope

Exclude collections from security testing when they shouldn't be tested (sandbox agents, demo agents, third-party MCP servers, etc.).

## How to Mark Out of Scope

1. Go to **Agentic Discovery > Collections**
2. Select the collection(s) to exclude
3. Click **Mark collections as out of testing scope**
4. Confirm

## When to Use

- Sandbox or demo agents
- Third-party MCP servers you don't control
- Deprecated agents being phased out
- Development/test agents not ready for scanning

## Important Notes

- Collections remain visible in inventory
- They won't be included in security tests
- Can be brought back into scope anytime
- Keeps test results focused on critical agents
