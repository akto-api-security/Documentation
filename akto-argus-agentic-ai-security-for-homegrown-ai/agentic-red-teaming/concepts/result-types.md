# Result Types

Akto's AI Red Teaming provides comprehensive insights into the security posture of your AI agents and agentic systems. Results are categorized into different types, each offering specific information about the state of tested components.

## Vulnerable

A security vulnerability has been detected in the agent component. These issues require immediate attention and remediation. Severity levels (Critical, High, Medium, Low) help prioritize vulnerabilities.

## Need Configuration

Probes could not be performed due to missing configuration details. Akto provides options to add required configuration directly, enabling completion of these probes for thorough security assessment.

## Skipped

Probes were not executed, often because the agent component did not satisfy preconditions necessary for probing, such as authentication requirements. The exact reason for skipping is provided in the error message.

## No Vulnerability Found

The security probe completed successfully with no vulnerabilities detected for that particular check.

## Domain Unreachable

The probe couldn't connect to the agent component, possibly due to network issues, incorrect configuration, or the component being offline. This requires investigation into component availability and accessibility.
