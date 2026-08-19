# Misconfigurations

## Overview

A **misconfiguration** is a setting inside an AI coding agent's own config file that weakens its permission model, its sandbox, or its human-approval flow — or that exposes credentials and sensitive paths the agent doesn't need to do its job. Akto continuously scans the agentic config files it discovers on endpoints (via [AI Endpoint Shield](../../akto-atlas-agentic-ai-security-for-employee-endpoints/endpoints-discovery-agents/ai-endpoint-shield/README.md)) and flags the ones that do.

{% hint style="info" %}
Akto judges the **value**, not the field. A config that simply mentions a credential path, a URL, or an allowlist entry is not a finding by itself — a field is only flagged when what it's actually set to measurably increases what the agent can do without a human checking it.
{% endhint %}

## What generally counts as risky

Akto looks for the same handful of patterns across every agent's config, regardless of format:

* **Skips human approval** before the agent runs commands or edits files — an auto-approve, "bypass permissions", or "never ask" mode.
* **Disables or weakens the sandbox**, or lets the agent read/write outside its own workspace — credential and identity paths like `.ssh`, `.aws`, `.gnupg`, `.kube`, `.npmrc`, `.netrc`, or unrestricted network egress (wildcard domains, raw IPs).
* **Turns off monitoring or validation entirely** — for example, disabling all hooks — as opposed to a config that simply has no hooks configured.
* **An allowlist entry scoped to a destructive or exfiltration-capable command** (`rm`, `sudo`, `curl`, `wget`, `chmod`, `dd`, `eval`), or a bare wildcard that grants an entire tool with no scoping at all.

## What is normal — and never flagged

* Ordinary, command-scoped developer allowlists (`git`, `npm`, `go`, `make`, `docker`, …) with wildcarded arguments.
* Bare grants for read-only or inert tools (a file reader, a search tool, an MCP tool name).
* Well-known developer domains (`npmjs.com`, `pypi.org`, `github.com`, `docker.com`, …).
* Credential-manager or credential-helper fields that store secrets safely.
* Any field whose configured value keeps a protection **on**, or keeps access **restricted** — a stricter-than-default setting is never a misconfiguration.

## Supported configuration files

Akto currently scans the config files of three coding agents. Each has its own in-scope fields, since the same setting can mean something different depending on the tool:

<table><thead><tr><th width="220">Agent</th><th width="180">Config file</th><th>Fields Akto looks at</th></tr></thead><tbody>
<tr><td><strong>Claude Code</strong></td><td><code>settings.json</code></td><td><code>permissions.*</code> (default mode, allow/ask/deny, additional directories), <code>sandbox.*</code>, <code>disableAllHooks</code></td></tr>
<tr><td><strong>OpenAI Codex CLI</strong></td><td><code>config.toml</code></td><td><code>approval_policy</code>, <code>sandbox_mode</code>, <code>sandbox_workspace_write.*</code>, <code>permissions.&#x3C;name>.filesystem.*</code> / <code>.network.*</code>, <code>features.network_proxy.*</code></td></tr>
<tr><td><strong>GitHub Copilot CLI</strong></td><td><code>settings.json</code></td><td><code>permissions.disableBypassPermissionsMode</code>, and any suspicious (wildcard, raw IP, plaintext <code>http://</code>) URL/plugin/marketplace entry</td></tr>
</tbody></table>

Cosmetic or purely administrative fields — theme, logging verbosity, model name, UI preferences — are always out of scope, no matter which tool.

## Example: Claude Code `settings.json`

The config below mixes normal fields with the kind of values Akto flags as misconfigured.

```json
{
  "permissions": {
    "defaultMode": "bypassPermissions",
    "allow": [
      "Bash(git *)",
      "Bash(npm run *)",
      "Bash(rm -rf *)",
      "Read",
      "Write"
    ],
    "additionalDirectories": ["~/.ssh", "~/.aws"]
  },
  "sandbox": {
    "enabled": true,
    "network": {
      "allowedDomains": ["registry.npmjs.org"]
    }
  },
  "disableAllHooks": true
}
```

<table><thead><tr><th width="260">Field</th><th width="110">Status</th><th>Why</th></tr></thead><tbody>
<tr><td><code>permissions.defaultMode: "bypassPermissions"</code></td><td>Misconfigured</td><td>Every action runs without asking a human first.</td></tr>
<tr><td><code>allow: ["Bash(git *)", "Bash(npm run *)"]</code></td><td>Normal</td><td>Ordinary dev commands, scoped with wildcarded arguments.</td></tr>
<tr><td><code>allow: ["Bash(rm -rf *)"]</code></td><td>Misconfigured</td><td>A destructive command granted with no path scoping.</td></tr>
<tr><td><code>allow: ["Read"]</code></td><td>Normal</td><td>Read-only, inert tool — safe as a bare grant.</td></tr>
<tr><td><code>allow: ["Write"]</code></td><td>Misconfigured</td><td>A state-changing tool granted with no path scoping.</td></tr>
<tr><td><code>additionalDirectories: ["~/.ssh", "~/.aws"]</code></td><td>Misconfigured</td><td>Extends the agent's reach into credential directories it doesn't need.</td></tr>
<tr><td><code>sandbox.enabled: true</code></td><td>Normal</td><td>The sandbox stays on — a protection kept on is never a finding.</td></tr>
<tr><td><code>sandbox.network.allowedDomains: ["registry.npmjs.org"]</code></td><td>Normal</td><td>Scoped to a single, well-known package registry.</td></tr>
<tr><td><code>disableAllHooks: true</code></td><td>Misconfigured</td><td>Turns off every hook-based monitoring and validation check at once.</td></tr>
</tbody></table>

## Where this shows up in Akto

* On the **Agentic Assets** pages, an asset with at least one misconfigured config carries a **Misconfigured** tag. Hovering it shows how many of that asset's devices are affected.
* Drilling into an asset's own device/endpoint list surfaces the same **Misconfigured** tag on the specific device, and on the underlying config entry itself.
* Use [Create Misconfiguration Policies](../how-to/create-misconfiguration-policies.md) to pin a config field to an expected value and have Akto auto-revert drift, instead of only detecting it after the fact.
