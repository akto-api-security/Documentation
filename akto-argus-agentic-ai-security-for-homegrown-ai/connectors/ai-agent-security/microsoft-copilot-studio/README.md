---
description: Connect Akto with Microsoft Copilot Studio
---

# Microsoft Copilot Studio

[Microsoft Copilot Studio](https://learn.microsoft.com/en-us/microsoft-copilot-studio/fundamentals-what-is-copilot-studio) is a low-code platform for building and deploying conversational AI agents and copilots. Akto integrates with Copilot Studio in two modes — pick the one that matches your use case.

<table><thead><tr><th width="240">Integration mode</th><th>Description</th></tr></thead><tbody><tr><td><a href="connect-akto-async.md">Connect to Akto (Async)</a></td><td>Poll conversation transcripts from Microsoft Dataverse on a recurring schedule. No agent changes required. Detection-only — Akto observes traffic after the conversation has ended.</td></tr><tr><td><a href="connect-akto-sync.md">Connect to Akto (Sync)</a></td><td>Inline request and response guardrails added directly inside the Copilot Studio agent topics. Blocks malicious prompts and scans AI responses in real time.</td></tr></tbody></table>

## Which mode to choose

* **Async** — fastest to set up, zero agent changes, good for visibility and red-team analysis. Detect-only; cannot block.
* **Sync** — required if you want to **block** prompt-injection, PII leaks, or policy violations before the model or user sees them. Requires editing each agent's topics.

Both modes can run side-by-side on the same agent.
