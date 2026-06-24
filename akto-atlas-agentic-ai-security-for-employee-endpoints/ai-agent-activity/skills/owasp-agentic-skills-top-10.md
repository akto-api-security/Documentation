# OWASP Agentic Skills Top 10

## Overview

The OWASP Agentic Skills Top 10 is a community-driven framework that identifies the most critical security risks associated with AI agent skills. Skills are callable capabilities exposed by AI agents - and as their adoption grows, so does their attack surface.

This page maps each OWASP risk to how Akto detects and addresses it across your environment.

## AST01: Malicious Skills

**Severity: Critical**

Rogue skills designed to steal data or execute unauthorized actions. The ClawHavoc campaign (February 2026) identified 1,184 confirmed malicious skills distributed through public registries.

**How Akto Addresses It**

**Detection**

* AI Endpoint Shield scans every discovered skill file using LLM-based analysis at discovery time and on every subsequent change, checking for malicious patterns including credential theft, data exfiltration, prompt injection, and system modification
* MCP tools exposed by MCP servers are evaluated using LLM scoring to identify malicious intent
* Skills discovered across all sources - workstations, repositories, CI/CD pipelines, MCP servers, local directories, and third-party registries - are all subject to the same analysis regardless of origin

**Risk Scoring & Visibility**

* Each skill is assigned a risk score based on findings, surfaced across the **Skills**, **Users & Devices**, and **Agentic Assets** views
* Findings are recorded in the audit database and available for review, reporting, and SOC forwarding

## AST02: Supply Chain Compromise

**Severity: Critical**

Attacks on skill distribution channels - typosquatting, backdoored packages, compromised publishers, or malicious updates introduced before a skill reaches the developer. Example: Claude Code CVE-2025-59536.

**How Akto Addresses It**

**Inventory & Tracking**

* Akto generates and maintains a full inventory of installed skills and MCP components across your environment, capturing skill source, hosting location, associated agents, and last observed activity
* AI Endpoint Shield continuously tracks which skills and MCP servers are present and active on each endpoint, giving you visibility into what entered your environment and when
* The inventory provides an audit trail that makes it possible to trace exactly when a component appeared and which agents were exposed

**Detection**

* Skills from all sources - including third-party registries and community marketplaces - are subject to full LLM-based analysis regardless of where they originated
* Any skill appearing from an unrecognized publisher or registry is flagged for review and included in the risk scoring pipeline



## AST03: Over-Privileged Skills

**Severity: High**

Skills request more permissions than their function requires. Research has identified hundreds of skills unnecessarily accessing credentials and sensitive files through overly broad permission declarations.

**How Akto Addresses It**

**Detection**

* Akto detects dangerous permission configurations including unrestricted shell access, permission bypass flags, and wildcard filesystem or network access declared in skill definitions
* Weakened isolation settings that expand a skill's access beyond its intended scope are flagged during analysis
* Skills with excessive or dangerous permission declarations receive elevated risk scores, surfaced across the Skills and Agentic Assets views for immediate prioritization

**Enforcement**

* Tool-call approval policies ensure privileged actions require explicit authorization before execution
* Skills identified as over-privileged can be blocked at the device or agent level without affecting other skills in your environment



## AST04: Insecure Metadata

**Severity: High**

Unsafe deserialization of skill configuration files creates opportunities for code injection and parser exploitation. Attackers also weaponize skill manifests through typosquatting and vendor impersonation - such as fake publisher accounts mimicking trusted organizations - delivering malicious payloads via YAML structures inside skill files.

**How Akto Addresses It**

**Detection**

* Akto's LLM-based skill analysis inspects skill configuration files for suspicious payloads and malicious content embedded within YAML and Markdown manifests
* Akto scores each tool based on how well its name and description match its actual declared behavior - a low match score surfaces skills where metadata has been manipulated to conceal malicious intent
* Both skills and MCP tools are evaluated for impersonation signals, flagging components where stated identity cannot be corroborated by declared behavior

## AST05: Untrusted External Instructions

**Severity: High**

Skills that fetch instructions from remote URLs introduce a runtime supply chain risk - the skill file itself may appear safe, but the behavior it loads at runtime can be changed by an attacker at any time after installation. Anthropic's own documentation warns that fetched URLs may contain malicious instructions. A proof-of-concept demonstrated potential takeover of 26,000 agents through this vector.

**How Akto Addresses It**

**Detection**

* Akto's LLM-based skill analysis inspects skill files for instructions that reference or delegate behavior to remote-controlled endpoints
* Skills that pull content from external URLs at runtime are flagged as high-risk regardless of what is currently at those URLs, since an attacker can change that content at any time after installation
* Flagged skills surface in the **Skills** view with elevated risk scores for immediate review and action

## AST06: Weak Isolation

**Severity: High**

Skills execute without sufficient separation from the host environment. Host-mode execution gives a compromised skill direct access to the underlying system. Example: OpenClaw host-mode execution.

**How Akto Addresses It**

**Detection**

* Akto detects isolation weaknesses in skill configurations including disabled sandbox settings, permissions that allow unsandboxed command execution, excluded command restrictions, filesystem and network scope expansion, and weakened nested sandbox modes
* Isolation posture is assessed at discovery time and factored directly into the skill's risk score

**Enforcement**

* Skills with identified isolation weaknesses can be blocked at the device or agent level, preventing execution until the configuration is remediated
* Runtime monitoring enforces filesystem and network access restrictions, providing a defense-in-depth layer even when host-level isolation is not configured

## AST07: Update Drift

**Severity: Medium**

Skills drift from their approved versions due to silent updates, patch lag, or failed updates. An attacker who gains access to a registry can push a compromised version of a previously trusted skill without triggering any visible change. Example: ClawJacked CVE-2026-28363.

**How Akto Addresses It**

**Continuous Revalidation**

* Skills are periodically revalidated approximately every 6 hours - newly malicious behavior introduced through an update is identified at the next revalidation cycle
* MCP tool definitions are revalidated continuously as tool list responses are observed, providing near-real-time coverage as definitions change
* If a skill passes initial analysis but is later modified to include malicious content, the change is caught at revalidation and the skill's risk score is updated accordingly

**Visibility**

* Revalidation findings appear in the same **Skills** and **Agentic Assets** views as initial discovery findings, giving your team a consistent place to track changes in skill risk posture over time.

## AST08: Poor Scanning

**Severity: Medium**

Security scanners that rely on pattern matching fail to detect behavioral and semantic threats. Attackers bypass detection through obfuscation, natural-language variation, and splitting malicious directives across multiple fields.

**How Akto Addresses It**

Akto applies multiple detection layers to address the limitations of single-method scanning:

**Static Analysis**

* Static policy rules covering 500+ threat patterns catch known malicious signatures and configurations
* Sensitive data and secret detection identifies credentials and internal identifiers embedded in skill content
* Prompt injection detection flags adversarial instructions targeting agent behavior

**Semantic Analysis**

* LLM-based semantic analysis evaluates natural-language instructions that evade rule-based detection through obfuscation, variation, or splitting across fields
* Component-level analysis for skills and MCP tools correlates findings across the skill file and its associated metadata

**Custom Coverage**

* Custom guardrails configurable to your environment extend detection coverage to organization-specific threat patterns

## AST09: No Governance

**Severity: Medium**

Organizations lack skill inventories, approval workflows, and audit logging. Without governance controls, security teams have no visibility into which skills are in use, who introduced them, or whether they have been reviewed. Research identified 53,000+ exposed instances with no security monitoring.

**How Akto Addresses It**

**Inventory & Audit**

* Akto generates and maintains a continuous inventory of all skills in use across your environment, capturing skill source, hosting location, associated agents, and last observed activity
* Review outcomes for each discovered component are tracked in the audit database and available for compliance reporting

**Governance Controls**

* Audit policies enforce tool-call approvals, requiring explicit authorization for sensitive actions
* Approved component lists restrict which skills and MCP servers can be active in your environment
* Approval workflows, code review gates, and policy gating govern which skills can be introduced and activated across teams and projects

**SOC Visibility**

* Threat events are forwarded to your SOC for continuous monitoring and response
* Compliance reports covering skill inventory and usage history are available for audit purposes


## AST10: Cross-Platform Reuse

**Severity: Medium**

Malicious skills are ported across ecosystems - Claude Code, Cursor, VS Code, MCP servers - to maximize reach. Metadata loss during conversion weakens the security controls applied to the original skill. Example: ClawHub to skills.sh migrations.

**How Akto Addresses It**

**Cross-Platform Discovery**

* Akto discovers and analyzes skill files across all major platforms and runtimes - Claude Code, Cursor, VS Code, MCP servers, CI/CD pipelines, and third-party registries - from a single deployment
* Every skill is evaluated independently regardless of its origin platform, ensuring that skills ported from another ecosystem are fully re-analyzed upon discovery

**Unified Risk Visibility**

* Risk scores and findings are consistent regardless of the platform a skill was discovered on, preventing coverage gaps that arise when security controls are applied per-platform rather than per-skill
* The unified inventory means that the same skill appearing under different names or formats across platforms is visible and accounted for in one place
