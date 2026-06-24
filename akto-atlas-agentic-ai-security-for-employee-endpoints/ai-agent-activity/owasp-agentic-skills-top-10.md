# OWASP Agentic Skills Top 10

## Overview

The OWASP Agentic Skills Top 10 is a community-driven framework that identifies the most critical security risks associated with AI agent skills. Skills are callable capabilities exposed by AI agents — and as their adoption grows, so does their attack surface.

This page maps each OWASP risk to how Akto detects and addresses it across your environment.

***

## AST01 — Malicious Skills

**Severity: Critical**

Rogue skills designed to steal data or execute unauthorized actions. The ClawHavoc campaign (February 2026) identified 1,184 confirmed malicious skills distributed through public registries.

**How Akto Addresses It**

* AI Endpoint Shield scans every discovered skill file using LLM-based analysis, checking for malicious patterns including credential theft, data exfiltration, prompt injection, and system modification
* MCP tools exposed by MCP servers are evaluated using LLM scoring to identify malicious intent
* Findings are recorded in the audit database and are available for review and reporting

***

## AST02 — Supply Chain Compromise

**Severity: Critical**

Attacks on skill distribution channels — typosquatting, backdoored packages, compromised publishers, or malicious updates introduced before a skill reaches the developer. Example: Claude Code CVE-2025-59536.

**How Akto Addresses It**

* Akto's skill and MCP discovery provides a full inventory of installed components across your environment
* AI Endpoint Shield continuously tracks which skills and MCP servers are present and active on each endpoint, giving you visibility into what entered your environment and when

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

Unsafe deserialization of skill configuration files creates opportunities for code injection and parser exploitation. Attackers also weaponize skill manifests through typosquatting and vendor impersonation — such as fake publisher accounts mimicking trusted organizations — delivering malicious payloads via YAML structures inside skill files.

**How Akto Addresses It**

* Akto's LLM-based skill analysis inspects skill configuration files for suspicious payloads and malicious content embedded within YAML and Markdown manifests
* Akto scores each tool based on how well its name and description match its actual declared behavior, surfacing impersonation and misrepresentation attempts

***

## AST05 — Untrusted External Instructions

**Severity: High**

Skills that fetch instructions from remote URLs introduce a runtime supply chain risk — the skill file itself may appear safe, but the behavior it loads at runtime can be changed by an attacker at any time after installation. Anthropic's own documentation warns that fetched URLs may contain malicious instructions. A proof-of-concept demonstrated potential takeover of 26,000 agents through this vector.

**How Akto Addresses It**

* Akto's LLM-based skill analysis inspects skill files for instructions that reference or delegate behavior to remote-controlled endpoints, flagging skills that pull content from external sources

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

**How Akto Addresses It**

Akto discovers and analyzes skill files across all major platforms and runtimes from a single deployment. Every skill is evaluated independently regardless of its origin, ensuring that skills ported from another ecosystem are fully re-analyzed upon discovery.
