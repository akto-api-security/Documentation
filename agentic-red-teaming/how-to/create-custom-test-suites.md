# Create Custom Test Suites

Custom Test Suites allow you to create tailored sets of security tests that align with your agentic system's unique requirements and risk profile. This provides granular control over security testing beyond the default pre-built test collections.

## How to Set Up

1. Navigate to **Agentic Red Teaming > Scan Suite** in the Akto dashboard
2. Click to create a new suite or edit an existing one
3. Select required tests by category or individual items
4. Name your test suite (e.g., "Agent Cascading Failures Suite")
5. Save and use in testing workflows

## Key Features

**Flexible Test Selection**: Choose from specialized test categories including:
- Prompt Injection
- LLM Security
- MCP Security
- Agent Identity Impersonation
- Sensitive Information Disclosure
- Supply Chain vulnerabilities
- Excessive Agency
- Data Poisoning

**Category-Level and Individual Test Selection**: Select entire categories or drill down to specific tests (e.g., specific prompt injection techniques or MCP authentication bypasses).

**Efficient Management**: Search and filter tests to quickly assemble the suite that suits your needs.

**Reusable Configurations**: Save custom test suites for repeated use across different environments or CI/CD pipeline stages.

## Benefits

**Precision Testing**: Focus on vulnerabilities most relevant to your agentic system's functionality.

**Reduced Noise**: Avoid unnecessary test results by excluding irrelevant categories.

**Compliance Alignment**: Customize suites to align with OWASP Top 10 for LLMs and other compliance requirements.
