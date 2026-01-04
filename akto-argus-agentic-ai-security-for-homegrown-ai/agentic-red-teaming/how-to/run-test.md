# Run Test

Running security tests in Akto involves assessing agent components to evaluate their security posture. You can run tests instantly or schedule them for later, making it useful for planning testing sessions or implementing regular security validation.

## Running Tests on Agent Components

1. Navigate to **Agentic Discovery > Collections**
2. Select the collection containing the agent components you want to test
3. Choose specific agent components or select all components in the collection
4. Click **Run test**
5. Select test categories to run (Prompt Injection, MCP Security, LLM Security, etc.)
6. Configure test parameters if needed
7. Click **Run Test** to start the security scan

## Test Categories

When running tests, you can select from specialized categories:

- **Prompt Injection**: Tests for direct and indirect prompt injection vulnerabilities
- **LLM Security**: Validates model-specific security controls
- **MCP Security**: Tests Model Context Protocol implementations
- **Sensitive Information Disclosure**: Detects credential and PII exposure
- **Excessive Agency**: Validates tool permission boundaries
- **Supply Chain**: Identifies dependency vulnerabilities

and more...

## Modify Test Parameters

You can add, modify, or remove headers and parameters directly from the test configuration without editing YAML files. This allows you to customize tests for specific agent behaviors or authentication requirements.
