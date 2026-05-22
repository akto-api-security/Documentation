---
description: Connect Akto with Microsoft Copilot Studio
---

# Microsoft Copilot Studio

[Microsoft Copilot Studio](https://learn.microsoft.com/en-us/microsoft-copilot-studio/fundamentals-what-is-copilot-studio) is a low-code platform for building and deploying conversational AI agents and copilots. Akto integrates with Copilot Studio in three ways — pick the one that matches your use case, or combine them.

<table><thead><tr><th width="240">Integration</th><th>Description</th></tr></thead><tbody><tr><td><a href="connect-akto-async.md">Connect to Akto (Async Mode)</a></td><td>Poll conversation transcripts from Microsoft Dataverse on a recurring schedule. No agent changes required. Detection-only — Akto observes traffic after the conversation has ended.</td></tr><tr><td><a href="connect-akto-sync.md">Connect to Akto (Block Mode)</a></td><td>Inline request and response guardrails added directly inside the Copilot Studio agent topics. Blocks malicious prompts and scans AI responses in real time.</td></tr><tr><td><a href="proxy-mcp-via-akto.md">Proxy MCP Server via Akto</a></td><td>Route MCP server tool calls made by the agent through Akto's <code>agent-proxy</code> for inspection and policy enforcement on every MCP request and response.</td></tr></tbody></table>

## Which option to choose

* **Async Mode** — fastest to set up, zero agent changes, good for visibility and red-team analysis. Detect-only; cannot block.
* **Block Mode** — required if you want to **block** prompt-injection, PII leaks, or policy violations before the model or user sees them. Requires editing each agent's topics.
* **Proxy MCP Server via Akto** — required if your agent calls external **MCP servers** as tools and you want every MCP request and response to flow through Akto.

All three can run side-by-side on the same agent.
