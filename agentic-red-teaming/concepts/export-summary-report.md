# Export Summary Report

## Overview

The Summary Report provides a high-level snapshot of agentic security scans. It's ideal for executives, compliance teams, and managers who need quick insights into security posture without diving into raw technical data.

The report highlights vulnerability counts, severity distribution, affected categories, and scan configuration details.

## How to Access

1. Navigate to **Agentic Red Teaming > Results**
2. Select a test run
3. Click **More actions** and choose **Export summary report**

## Report Contents

**Header Summary**

- **Vulnerable Components Found**: Number of agent components with security issues
- **Vulnerable Issues**: Total vulnerability count
- **Scan Duration**: Test execution time
- **Test Description**: Overview of tested categories (prompt injection, tool permissions, etc.)

**Issues by Severity**

Visual breakdown showing vulnerabilities across severity levels:
- Critical
- High
- Medium
- Low

This helps prioritize remediation efforts.

**Top Categories by Issues**

Breakdown of issues by vulnerability categories such as:
- Prompt Injection
- Sensitive Information Disclosure
- MCP Security
- LLM Security
- Supply Chain

**Test Configuration Details**

- Test type (one-time, scheduled, CI/CD)
- Unique hosts tested
- Max concurrent requests
- Start and completion timestamps
