# AI Discovery Connectors

Connect Atlas to every surface where your employees run AI: CLIs, IDEs, browsers, SaaS AI suites, and the EDR/MDM tooling you already deploy through. Every connector feeds the same [Agentic AI Discovery](../ai-agent-activity/) inventory, so it doesn't matter which mix you pick: you get one view of everything discovered.

## Endpoint-Wide Discovery and Protection

* [AI Endpoint Shield](ai-endpoint-shield/) - the background agent you deploy fleet-wide: discovers local MCP servers, installs your CLI and IDE hooks, and bundles the System Proxy.
* [Browser Extensions](browser-extensions/) - discovery and inline guardrails for AI usage inside Chrome, Firefox, and Safari.
* [Akto System Proxy](akto-system-proxy.md) - installed automatically with AI Endpoint Shield, it covers standalone desktop AI apps that don't expose hooks (Claude Desktop, GitHub Copilot, ChatGPT desktop).

## Agentic CLI Hooks

Zero-install hooks for CLI-based coding agents:

* [Claude CLI Hooks](claude-cli-hooks.md)
* [Codex CLI Hooks](codex-cli-hooks.md)
* [Gemini CLI Hooks](gemini-cli-hooks.md)
* [Kiro CLI Hooks](kiro-cli-hooks.md)
* [Copilot Hooks](copilot-cli-hooks.md) - covers GitHub Copilot in VS Code and the CLI
* [Snowflake Cortex Code CLI Hooks](snowflake-cortex-cli-hooks.md)
* [Hermes Hooks](hermes-hooks.md)
* [Amp Hooks](amp-hooks.md)
* [OpenCode Hooks](opencode-hooks.md)

## Agentic IDEs and Desktop Apps

* [Cursor Hooks](cursor-hooks.md)
* [Neovim Hooks](neovim-hooks.md)
* [Claude Cowork Connector](claude-cowork-connector.md)

## SaaS and Compliance Connectors

* [Anthropic Connector](anthropic-connector.md) - pulls compliance activity from Claude.ai, Claude Console, and the Claude API via Anthropic's Compliance API.
* [Claude Inference Hooks](claude-inference-hooks.md) - use Atlas as the security server behind Anthropic's Inference Hooks, to allow or deny Claude prompts inline before inference runs.
* [OpenAI Connector](openai-connector.md) - pulls audit log and org activity data from ChatGPT and OpenAI via the OpenAI Admin API.
* [GitHub Copilot Enterprise](github-copilot-enterprise.md) - agent discovery, centralized guardrails, and enterprise-wide policy enforcement for Copilot.
* [Copilot Studio](../connectors/ai-agent-security/microsoft-copilot-studio.md), [Copilot Studio (Multi Environment)](../connectors/ai-agent-security/microsoft-copilot-studio-multi-environment.md), and [Copilot Studio (Threat Detection)](../connectors/ai-agent-security/microsoft-copilot-studio-threat-detection.md) - secure agents built in Microsoft Copilot Studio, across single or multiple Power Platform environments.

## Locally Hosted Models

Atlas discovers models served by local model runners on employee devices, including Ollama, vLLM, SGLang, and Docker Model Runner.

## Endpoint Management (EDR) Integrations

Detect AI coding tools already running on managed endpoints through the EDR you deploy:

* [Deploy via SentinelOne](deploy-via-sentinelone.md)
* [Deploy via CrowdStrike](deploy-via-crowdstrike.md)
* [Deploy via Microsoft Defender Endpoint](deploy-via-microsoft-defender/)

For MDM-based rollout (Intune, NinjaOne, Automox, Jamf, Mosyle), see the deployment options on the [AI Endpoint Shield](ai-endpoint-shield/) page.
