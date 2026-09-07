---
description: Conduct role-based security probing for agentic systems.
---

# Conduct Role-Based Scanning

Akto enables role-based scanning for agentic systems, aligning with Role-Based Access Control (RBAC) principles. Running a scan as a specific [Scan Role](../concepts/test-role.md) verifies that role can only reach the agent components and tools it's authorized for, catching privilege escalation issues before attackers do.

This is especially useful in environments where agent roles are diverse and complex, reducing the risk of unauthorized access and data breaches.

## Prerequisite

You need at least one Scan Role defined before you can run a role-based scan. See [Create a Scan Role](create-a-test-role.md).

## Running a Role-Based Scan

Follow the general scan flow in [Run Scan](run-test.md). When you reach **Configure the scan execution parameters**, use **Select Scan Role** to choose the role the scan should run as, for example one of the [common Scan Roles](../concepts/test-role.md) like `TEST_USER`, `MEMBER`, or `ATTACKER_TOKEN_ALL`, or any custom Scan Role you've created.

## Reviewing Role-Based Scan Results

Navigate to **AI Red Teaming > Results** to view findings.

* If no vulnerabilities are found in the vulnerable section, access control for that role is properly configured, the role cannot reach unauthorized components or tools.
* To check for **privilege escalation**, run the same scan twice, once as a lower-privilege role and once as a higher-privilege role, then compare results. If the lower-privilege role reaches components or tools it shouldn't, that's a privilege escalation issue to fix.
