# Issues

### What is an Issue?

Issues are identified security vulnerabilities or potential threats within your agentic infrastructure. They represent areas of concern that may compromise the security, functionality, or compliance of your AI agents, MCP endpoints, and tool integrations. Issues are categorized by severity and type, providing a comprehensive view of your agentic security posture.

### View an Issue

Akto automatically detects and categorizes issues across your agent component inventory, allowing you to view and manage them efficiently. By examining issues, you gain detailed insights into potential security risks and their impact on your autonomous systems.

This includes severity levels, affected agent components, and issue categories showing how vulnerabilities may affect your agentic security. You can identify prompt injection risks, tool permission violations, data leakage through agent interactions, and other agentic-specific security concerns, ensuring they are addressed promptly.

The Issues page provides a list of detected vulnerabilities. Each issue entry typically includes:

* Issue name and description
* Severity level (Critical, High, Medium, Low)
* Affected agent component or MCP endpoint
* Discovery time
* Issue category (e.g., prompt injection, tool abuse, permission escalation)

When you select an issue, you can view more detailed information such as:

* Full description of the agentic vulnerability
* Potential impact on your autonomous systems
* Tags (e.g., OWASP LLM Top 10, agentic-specific threats)
* CWE (Common Weakness Enumeration) references
* List of all affected agent components and MCP endpoints
* External references for remediation guidance

You can take actions on issues such as creating Jira tickets, marking as false positives, or indicating acceptable risks. The Issues page includes filtering options to help sort and manage agentic vulnerabilities effectively.

### Consistent Issue Fingerprint Across Scans

Akto reliably identifies the same issue across multiple security scans of your agent components. This prevents duplicate issues and maintains a clean, concise dashboard tracking agentic vulnerabilities.

### Consistent Issue Status Across Scans

Akto maintains the correct state of each identified issue over time as your agent architecture evolves and scans are re-run. When an issue previously detected in an agent component is not found in the latest scan, Akto automatically resolves the issue.
