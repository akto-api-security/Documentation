# Severity Levels

Akto classifies agentic security vulnerabilities into four severity levels to help teams prioritize remediation efforts. Each level indicates potential impact on your agentic system security posture.

## Critical Severity

Critical severity issues pose immediate risk and require urgent attention. These vulnerabilities could lead to unauthorized tool execution, system compromise, sensitive data exposure, or complete agent takeover.

Examples include successful prompt injections that bypass all guardrails, unauthorized access to critical tools, or hardcoded credentials in agent responses.

## High Severity

High severity issues indicate significant security risks requiring prompt remediation. While not immediately exploitable, these vulnerabilities can severely impact agent integrity and data security.

Examples include partial prompt injection success, improper output handling, or excessive tool permissions.

## Medium Severity

Medium severity issues represent moderate risks. These vulnerabilities might affect specific agent components or security controls, requiring planned remediation within standard development cycles.

Examples include information disclosure through error messages, supply chain vulnerabilities in dependencies, or inadequate input validation.

## Low Severity

Low severity findings indicate minor security concerns. While not immediate threats, they represent opportunities to strengthen security controls and should be addressed during regular maintenance.

Examples include verbose error messages, deprecated API usage, or minor configuration issues.
