# Overview

Akto Atlas secures the AI agents, MCP servers, and GenAI tools your employees actually use: IDEs, CLIs, browsers, and local dev environments. You get a live inventory of every agentic asset on your employees' devices, governance over the credentials those tools create, and guardrails enforced inline, all without disrupting anyone's workflow.

## The Problem You Face

* You have little to no visibility into which AI agents, IDEs, CLIs, MCP servers, and LLMs your employees actually use.
* You likely have no guardrails in place for endpoint AI usage.
* Agentic tools silently mint API keys and tokens on your employees' behalf that you rarely track or rotate.
* Your inventory of AI agents and MCP connections is probably incomplete or stale.

## How Akto Atlas Helps

Atlas discovers AI activity across your employees' devices, scores your overall exposure, tracks the credentials your agentic tools create, and enforces guardrails, all at the source.

### Why Atlas Is Different

Traditional endpoint tools were not built for AI. With Atlas, you get:

* Coverage native to AI surfaces: CLIs, IDEs, browsers, SaaS AI suites, and locally hosted models.
* Visibility into the real risk: prompts, responses, and tool calls, not just files and processes.
* Flexibility on deployment: a hook, an MDM-managed shield, or your existing EDR, whichever fits.

<div data-with-frame="true"><figure><img src="../.gitbook/assets/image (217).png" alt="" width="563"><figcaption></figcaption></figure></div>

## Core Capabilities

### Discover AI Usage Across Every Employee and Device

40+ connectors let you cover every surface where your employees run AI:

* **Agentic CLIs & IDEs**: Claude Code, Codex, Gemini, Copilot, Kiro, Hermes, Amp, Cursor, VS Code, Antigravity, Neovim, OpenCode, and more.
* **SaaS AI suites**: Claude Suite, ChatGPT Suite, Microsoft Suite (365 Copilot, Copilot Studio).
* **Browser extensions**: Chrome, Firefox, Safari.
* **Locally hosted models**: Ollama, vLLM, SGLang, Docker Model Runner.
* **Platform connectors**: Amazon Q, Glean.
* **Agentic proxies**: Global Proxy (hosted), Gateway (on-prem).
* **Endpoint & MDM integrations**: Microsoft Defender, SentinelOne, CrowdStrike, Intune, NinjaOne, Automox, Jamf, Mosyle.

Every connector feeds one continuously updated inventory, so you always know which agents, MCP servers, LLMs, skills, and plugins are in use, and on which endpoint, employee, and device.

### AI Security Posture

The [**AI Security Posture**](endpoint-security-posture.md) dashboard gives you a single risk view: agentic assets, exploits, sensitive-data events, guardrail score, and alignment against FedRAMP, MITRE ATLAS, CIS Controls, and CMMC.

### Agentic AI Discovery

[**Agentic AI Discovery**](ai-agent-activity/) lets you drill into what's been found: **Agentic Assets** (every agent, MCP server, LLM, skill, and plugin, with risk score and sensitive-data flags), **Components, Traces & Audit Data**, and **Users and Devices**.

### NHI Governance

[**NHI Governance**](nhi-governance/) gives you an inventory of the credentials (API keys, tokens, secrets) your agentic tools create, so you can track expiry, enforce rotation policies, and catch violations before they become incidents.

### Atlas Guardrails

[**Atlas Guardrails**](atlas-guardrails.md) run inside the same connectors to inspect prompts, responses, and tool calls locally, blocking sensitive-data exposure, prompt injection, risky MCP tool calls, shadow AI, and personal-account sign-ins before they ever leave the device.

## Next Step: AI Discovery Connectors

Start by connecting the [**AI Discovery Connectors**](endpoints-discovery-agents/) that match your environment. This inventory is your foundation for AI Security Posture, NHI Governance, and Atlas Guardrails.
