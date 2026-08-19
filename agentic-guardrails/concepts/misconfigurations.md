# Misconfigurations

## Overview

A **misconfiguration** is a setting in an AI coding agent's config file that weakens its permissions, sandbox, or approval checks. Akto scans the agentic config files it finds on endpoints (via [AI Endpoint Shield](../../akto-atlas-agentic-ai-security-for-employee-endpoints/endpoints-discovery-agents/ai-endpoint-shield/README.md)) and flags the ones that do this.

## What Akto looks for

* A setting that skips human approval before the agent runs commands or edits files.
* A setting that disables or weakens the sandbox.
* A setting that turns off monitoring, such as disabling all hooks.
* A setting that gives excessive permissions to the agent, such as allowing it to read or write files outside of its project directory.

## What is normal

* Keeping approval checks on.
* Keeping the sandbox enabled.
* Keeping hooks enabled. 

## Configuration files Akto scans

* **Claude Code**: `settings.json`
* **OpenAI Codex CLI**: `config.toml`
* **GitHub Copilot CLI**: `settings.json`

Each file has its own permission, sandbox, and hook settings, but Akto checks all three the same way: does this setting skip approval, give excessive permissions, weaken the sandbox, or turn off monitoring?

## Example: Claude Code `settings.json`

**Normal**

```json
{
  "permissions": {
    "defaultMode": "default"
  },
  "sandbox": {
    "enabled": true
  },
  "disableAllHooks": false
}
```

Approval is required, the sandbox stays on, and hooks keep running.

**Misconfigured**

```json
{
  "permissions": {
    "defaultMode": "bypassPermissions"
  },
  "sandbox": {
    "enabled": false
  },
  "disableAllHooks": true
}
```

Approval is skipped, the sandbox is off, and all hooks are disabled.

## Where this shows up in Akto

* In the **Misconfigurations** tab of the **ATLAS Guardrails Activity** page, you can see all the misconfigurations Akto has found on your endpoints.
* Use [Create Misconfiguration Policies](../how-to/create-misconfiguration-policies.md) to pin a config field to an expected value so Akto endpoint pins the field automatically.
