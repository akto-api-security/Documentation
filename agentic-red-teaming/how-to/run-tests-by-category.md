---
description: Run security tests by category for comprehensive vulnerability evaluation.
---

# Run Tests by Category

Akto's testing module allows you to conduct specialized security tests on agentic systems. You can select individual tests or organize and run tests by category, allowing targeted evaluation of specific security domains.

## Available Test Categories

**Prompt Injection**: Tests for direct and indirect prompt injection vulnerabilities across agent workflows.

**LLM Security**: Validates model-specific security controls including jailbreak attempts and output manipulation.

**MCP Security**: Tests Model Context Protocol implementations for tool authorization and resource access vulnerabilities.

**Agent Identity**: Evaluates agent impersonation and role escalation vulnerabilities.

**Sensitive Information Disclosure**: Detects exposure of credentials, PII, internal system details, and training data.

**Supply Chain**: Identifies vulnerabilities in agent dependencies and third-party integrations.

**Excessive Agency**: Validates tool permissions and autonomous action boundaries.

**Data Poisoning**: Tests for manipulation of agent memory and context windows.

## Running Tests by Category

1. Navigate to **Agentic Discovery > Collections**
2. Select the collection containing agent components
3. Click **Run Test**
4. Select one or more test categories
5. Choose specific tests within the category or select all
6. Click **Run Test** to execute

## Reviewing Category Test Results

After running category-based tests, navigate to **Agentic Red Teaming > Results** to view findings. Results are organized by severity and category, allowing quick identification of vulnerabilities within specific security domains.
