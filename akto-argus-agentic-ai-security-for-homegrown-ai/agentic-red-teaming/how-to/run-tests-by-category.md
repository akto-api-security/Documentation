---
description: Run security probes by category for comprehensive vulnerability evaluation.
---

# Run Scan by Category

Akto's probing module allows you to conduct specialized security probes on agentic systems. You can select individual probes or organize and run probes by category, allowing targeted evaluation of specific security domains.

## Available Probe Categories

**Prompt Injection**: Probes for direct and indirect prompt injection vulnerabilities across agent workflows.

**LLM Security**: Validates model-specific security controls including jailbreak attempts and output manipulation.

**MCP Security**: Probes Model Context Protocol implementations for tool authorization and resource access vulnerabilities.

**Agent Identity**: Evaluates agent impersonation and role escalation vulnerabilities.

**Sensitive Information Disclosure**: Detects exposure of credentials, PII, internal system details, and training data.

**Supply Chain**: Identifies vulnerabilities in agent dependencies and third-party integrations.

**Excessive Agency**: Validates tool permissions and autonomous action boundaries.

**Data Poisoning**: Probes for manipulation of agent memory and context windows.

## Running Probes by Category

1. Navigate to **Agentic Discovery > Collections**
2. Select the collection containing agent components
3. Click **Run Scan**
4. Select one or more probe categories
5. Choose specific probes within the category or select all
6. Click **Run Scan** to execute

## Reviewing Category Probe Results

After running category-based probes, navigate to **AI Red Teaming > Results** to view findings. Results are organized by severity and category, allowing quick identification of vulnerabilities within specific security domains.
