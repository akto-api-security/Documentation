# Schema Conformance

Detects agent requests that deviate from the expected schema defined for MCP endpoints or tool interfaces. This includes missing required fields, incorrect data types, unexpected properties, or malformed prompts. Schema violations may indicate probing activity, tool abuse attempts, or misconfigured agent clients attempting to exploit your autonomous systems.

For example, an agent request missing required properties triggers a **Medium severity** alert. These violations are flagged in real-time by Akto Guardrails, enabling quick triage and response, including blocking IPs, restricting tool access, or creating issue tickets directly from the dashboard.