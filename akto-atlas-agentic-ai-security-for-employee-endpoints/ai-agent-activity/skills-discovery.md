# Skills Discovery

## Overview

Skills Discovery helps you understand what actions your AI agents can perform across your environment. Each skill represents a callable capability exposed by an agent and mapped to underlying APIs or system operations.

You can view skills by navigating through the Akto Atlas interface:

* **Akto Atlas → Agentic AI Discovery → Agentic Assets → Skills tab**

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/image (5).png" alt="" width="563"><figcaption></figcaption></figure></div>

The Skills table shows endpoint coverage, sensitive data indicators, and last observed activity for each skill. The visibility into usage patterns helps you make informed enforcement decisions.

{% hint style="info" %}
**Skill Discovery Updates**

Akto continuously identifies skills configured in your agents.

**New skills are discovered every 6 hours.**\
Regular updates keep your inventory aligned with agent configuration changes.
{% endhint %}

## Discovery Sources

Akto discovers skill files across every surface where AI agents are configured and run. Discovery covers:

* **Local developer workstations** — skill files used by IDE-based agents such as Cursor, VS Code, and Claude Code
* **Source code repositories** — skill files committed to GitHub, GitLab, and Bitbucket, including nested directories such as `.claude/skills/`
* **CI/CD pipelines** — skill files present in pipeline configurations and build environments
* **MCP servers and AI agent runtimes** — skills loaded and exposed by locally running or networked MCP servers
* **Local developer skill directories** — skills loaded from developer-managed local paths outside of version control
* **Third-party registries and marketplaces** — skills pulled in from external sources or community registries

## Skill Inventory

Akto generates and maintains a continuous inventory of all skills currently in use across your environment. The inventory captures skill source, hosting location, associated agents, and last observed activity — giving you a complete, up-to-date picture of your skill footprint.

## Malicious Skill Detection

Akto marks a skill as malicious based on static analysis of its content. When a skill is discovered, Akto uses the fetch mechanism to retrieve the full content of the skill file — including `skills.md`, `.claude/skills/`, and equivalent files across IDEs, repositories, CI/CD pipelines, and MCP servers. Akto then inspects that content across three risk dimensions to determine whether the skill is safe, suspicious, or malicious. Analysis runs at discovery time and on every subsequent change detected in the file.

Each skill is evaluated and assigned a risk score, helping you quickly surface high-risk capabilities and take action before they are exploited. Risk scores are visible across the **Skills**, **Users & Devices**, and **Agentic Assets** views.

### Sensitive Data Exposure

Akto scans the fetched skill file content for credentials and sensitive identifiers embedded in skill instructions, examples, or metadata.

**What Akto Detects**

* Hardcoded API keys, tokens, and secrets
* Internal URLs and private endpoints exposed in skill descriptions
* Business logic or environment-specific configuration leaked into skill text
* Whether exposure indicates accidental leakage (e.g., a copy-paste artifact) vs. intentional exfiltration logic (e.g., a skill designed to forward credentials outbound)


### Malicious Instructions & Prompt Injection

Akto analyzes the fetched skill file content for injected or adversarial directives embedded in natural-language instructions, descriptions, and examples.

**What Akto Detects**

* Prompt injection patterns: instructions designed to override system behavior or hijack the agent's context
* Obfuscated or hidden instructions using Unicode tricks, whitespace manipulation, or non-printable characters
* Instructions that conflict with the stated skill purpose (e.g., a "summarize document" skill that also appends environment variables to outbound requests)
* Instruction smuggling embedded in skill descriptions, examples, or templates — where executable directives are disguised as documentation

Akto uses LLM-assisted semantic analysis to evaluate natural-language instructions that evade pattern-based detection.

{% hint style="info" %}
**Runtime Enforcement**

At runtime, if an injected instruction surfaces during execution, the **PromptInjection Guardrail** in Agent Guard enforces blocking. See [Agent Guard → PromptInjection Guardrail](../../agentic-guardrails/concepts/agent-guard.md) for detection logic and configuration.
{% endhint %}


### Embedded Code & Script Risks

Akto inspects execution blocks referenced or embedded in the fetched skill file content — including shell commands, pre-execution hooks, and linked script paths.

**What Akto Detects**

* Reverse shells and data exfiltration logic in associated `/scripts/` directories
* Unsafe system commands embedded in dynamic execution blocks
* Dependency risks: unverified, unpinned, or typosquatted packages referenced by the skill

## Continue with Guardrails

Skills Discovery shows available capabilities. Guardrails control execution.

You can:

* Map skills to guardrail policies
* Enforce restrictions on sensitive actions
* Monitor violations

Refer to:

* [Agentic Guardrails](../../agentic-guardrails/overview/)
* [Guardrail Policies](../../agentic-guardrails/concepts/threat-policy.md)
* [Skill Inspection & Enforcement](./skill-inspection-and-enforcement.md)
