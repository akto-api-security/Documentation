# NHI Governance

**NHI Governance** gives you visibility and control over the Non-Human Identities (NHIs) that your employees' agentic tools create and use. These are the API keys, bearer tokens, and secrets that IDEs, AI coding assistants, and MCP-connected tools accumulate as they access external services on behalf of employees.

## The Problem You Face

Agentic tools generate credentials silently, and those credentials rarely get cleaned up:

* Developers install an AI IDE plugin or MCP server, and it generates API keys or OAuth tokens that persist indefinitely.
* Keys are shared across devices, leaked into source code, or left active long after the tool is uninstalled.
* Security teams have no way to inventory what credentials exist, which ones are expired, or which are being misused until something goes wrong.
* Traditional IAM tools cover human and cloud-infrastructure identities, but the credentials spawned by developer AI tools fall through the gap.

## How NHI Governance Helps

Akto Atlas discovers NHIs as part of its endpoint agent activity collection. Every credential observed in agentic traffic API key, bearer token, service credential is catalogued automatically against the agentic asset it belongs to, the employee who owns it, and the policies that apply to it.

You get a continuous, centralised view of credential hygiene across your AI tooling estate.

## What NHI Governance Covers

* **Identities** a full inventory of discovered NHIs with expiry status, owner, type, and violation counts.
* **Violations** a list of policy breaches tied to specific identities, such as expired credentials still in use, over-privileged keys, or tokens with no expiry date.
* **Policies** the rules that define acceptable NHI behaviour, including expiry windows, allowed scopes, and required rotation cadences.

## Key Concepts

| Term | Meaning |
| ---- | ------- |
| Non-Human Identity (NHI) | A credential (API key, bearer token, secret) used by an agentic tool rather than a human user directly |
| Agentic Asset | The AI tool or MCP server that holds or uses the NHI (e.g. Claude CLI, Cursor, Windsurf) |
| Owner | The employee whose endpoint the credential was discovered on |
| Expiry Status | Whether the credential is active, nearing expiry, expired, or disabled |
| Violation | A breach of an NHI policy rule attached to an identity |

## What You Can Do

* Audit every AI-tool credential in your organisation from a single dashboard.
* Identify expired or soon-to-expire identities before they cause incidents.
* Enforce rotation and expiry policies without relying on manual processes.
* Investigate violations and track remediation against specific identities.

## Learn More

* [Identities](identities.md) inventory and expiry tracking for discovered NHIs
* [Violations](violations.md) policy breaches tied to specific identities
* [Create NHI Policies](policies.md) rules that govern acceptable NHI behaviour
