# Create Custom Scan Suites

Custom Scan Suites allow you to create tailored sets of security probes that align with your agentic system's unique requirements and risk profile. This provides granular control over security probing beyond the default pre-built probe collections.

## How to Set Up

1. Navigate to **AI Red Teaming > Scan Suite** in the Akto dashboard
2. Click to create a new suite or edit an existing one
3. Select required probes by category or individual items
4. Name your Scan suite (e.g., "Agent Cascading Failures Suite")
5. Save and use in probing workflows

## Key Features

**Flexible Probe Selection**: Choose from specialized probe categories including:
- Prompt Injection
- LLM Security
- MCP Security
- Agent Identity Impersonation
- Sensitive Information Disclosure
- Supply Chain vulnerabilities
- Excessive Agency
- Data Poisoning

**Category-Level and Individual Probe Selection**: Select entire categories or drill down to specific probes (e.g., specific prompt injection techniques or MCP authentication bypasses).

**Efficient Management**: Search and filter probes to quickly assemble the suite that suits your needs.

**Reusable Configurations**: Save custom probe suites for repeated use across different environments or CI/CD pipeline stages.

## Benefits

**Precision Probing**: Focus on vulnerabilities most relevant to your agentic system's functionality.

**Reduced Noise**: Avoid unnecessary Scan results by excluding irrelevant categories.

**Compliance Alignment**: Customize suites to align with OWASP Top 10 for LLMs and other compliance requirements.
