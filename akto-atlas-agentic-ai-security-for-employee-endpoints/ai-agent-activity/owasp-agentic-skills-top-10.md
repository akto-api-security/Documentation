# OWASP Agentic Skills Top 10

## Overview

The OWASP Agentic Skills Top 10 is a community-driven framework that identifies the most critical security risks associated with AI agent skills. Skills are callable capabilities exposed by AI agents — and as their adoption grows, so does their attack surface.

This page maps each OWASP risk to how Akto detects and addresses it across your environment.

***

## AST01 — Malicious Skills

**Severity: Critical**

Rogue skills designed to steal data or execute unauthorized actions. The ClawHavoc campaign (February 2026) identified 1,184 confirmed malicious skills distributed through public registries.

**How Akto Addresses It**

* Endpoint Shield scans every discovered skill file using LLM-based analysis, checking for malicious patterns including credential theft, data exfiltration, prompt injection, and system modification
* MCP tools exposed by MCP servers are evaluated using LLM scoring to identify malicious intent
* Findings are recorded in the audit database and are available for review and reporting

***

## AST02 — Supply Chain Compromise

**Severity: Critical**

Attacks on skill distribution channels — typosquatting, backdoored packages, compromised publishers, or malicious updates introduced before a skill reaches the developer. Example: Claude Code CVE-2025-59536.

**How Akto Addresses It**

* Akto's skill and MCP discovery provides a full inventory of installed components across your environment
* Endpoint Shield continuously tracks which skills and MCP servers are present and active on each endpoint, giving you visibility into what entered your environment and when

***

## AST03 — Over-Privileged Skills

**Severity: High**

Skills request more permissions than their function requires. Research has identified hundreds of skills unnecessarily accessing credentials and sensitive files through overly broad permission declarations.

**How Akto Addresses It**

* Akto detects dangerous permission configurations including unrestricted shell access, permission bypass flags, and wildcard filesystem or network access declared in skill definitions
* Weakened isolation settings that expand a skill's access beyond its intended scope are flagged during analysis
* Tool-call approval policies ensure privileged actions require explicit authorization before execution

***

## AST04 — Insecure Metadata

**Severity: High**

Misleading descriptions, fake authors, capability misrepresentation, or vendor impersonation in skill manifests and configuration files. Attackers use metadata manipulation to disguise malicious skills as trusted tools.

**How Akto Addresses It**

* Akto scores each tool based on how well its name and description match its actual declared behavior
* LLM analysis detects mismatches between a tool's stated purpose and what it actually does, surfacing skills where the metadata has been manipulated to conceal malicious intent

***

## AST05 — Unsafe Deserialization

**Severity: High**

Insecure parsing of YAML or JSON skill definitions that can enable code injection or parser exploitation. Malicious payloads embedded in skill files can be triggered during the parsing process itself.

**How Akto Addresses It**

* LLM-based skill analysis may identify suspicious embedded payloads or malicious instructions inside YAML and Markdown skill files

{% hint style="info" %}
Coverage for this category is partial. Skill content is analyzed at the application layer. Low-level parser exploitation at the deserialization layer is not directly instrumented.
{% endhint %}

***

## AST06 — Weak Isolation

**Severity: High**

Skills execute without sufficient separation from the host environment. Host-mode execution gives a compromised skill direct access to the underlying system. Example: OpenClaw host-mode execution.

**How Akto Addresses It**

* Akto detects isolation weaknesses in skill configurations including disabled sandbox settings, permissions that allow unsandboxed command execution, excluded command restrictions, filesystem and network scope expansion, and weakened nested sandbox modes

***

## AST07 — Update Drift

**Severity: Medium**

Skills drift from their approved versions due to silent updates, patch lag, or failed updates. An attacker who gains access to a registry can push a compromised version of a previously trusted skill without triggering any visible change. Example: ClawJacked CVE-2026-28363.

**How Akto Addresses It**

* Skills are periodically revalidated approximately every 6 hours — newly malicious behavior introduced through an update is identified at the next revalidation cycle
* MCP tool definitions are revalidated continuously as tool list responses are observed, providing ongoing coverage as definitions change

***

## AST08 — Poor Scanning

**Severity: Medium**

Security scanners that rely on pattern matching fail to detect behavioral and semantic threats. Attackers bypass detection through obfuscation, natural-language variation, and splitting malicious directives across multiple fields.

**How Akto Addresses It**

Akto applies multiple detection layers to address the limitations of single-method scanning:

* Static policy rules covering 500+ threat patterns
* Sensitive data and secret detection
* Prompt injection detection
* LLM-based semantic analysis for threats that evade static rules
* Component-level analysis for skills and MCP tools
* Custom guardrails configurable to your environment

***

## AST09 — No Governance

**Severity: Medium**

Organizations lack skill inventories, approval workflows, and audit logging. Without governance controls, security teams have no visibility into which skills are in use, who introduced them, or whether they have been reviewed. Research identified 53,000+ exposed instances with no security monitoring.

**How Akto Addresses It**

* Audit policies enforce tool-call approvals, requiring explicit authorization for sensitive actions
* Approved component lists restrict which skills and MCP servers can be active in your environment
* Review outcomes for each discovered component are tracked and available for audit
* Threat events are forwarded to your SOC for visibility and ongoing monitoring

***

## AST10 — Cross-Platform Reuse

**Severity: Medium**

Malicious skills are ported across ecosystems — Claude Code, Cursor, VS Code, MCP servers — to maximize reach. Metadata loss during conversion weakens the security controls applied to the original skill. Example: ClawHub to skills.sh migrations.
