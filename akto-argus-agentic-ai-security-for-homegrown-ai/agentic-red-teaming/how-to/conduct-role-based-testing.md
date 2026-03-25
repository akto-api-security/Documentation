---
description: Conduct role-based security probing for agentic systems.
---

# Conduct Role-Based Scanning

Akto enables role-based probing for agentic systems, aligning with Role-Based Access Control (RBAC) principles. This verifies that each role can only access authorized agent components and tools.

This probing approach is essential for maintaining system integrity by reducing risks of unauthorized access and data breaches, especially in environments where agent roles are diverse and complex.

## Conducting Role-Based Scans

When you [run a probe](run-test.md), you can select a probe role to ensure the probe reflects the permissions and access levels associated with that role.

1. Navigate to **Agentic Discovery > Collections**
2. Select the collection containing agent components
3. Click **Run Scan**
4. Select probe categories
5. Choose a **Scan Role** (e.g., Member, Admin, Viewer)
6. Click **Run Scan**

## Reviewing Role-Based Probe Results

Navigate to **AI Red Teaming > Results** to view findings. If no vulnerabilities are found in the vulnerable section, it indicates that access control for that role is properly configured and the role cannot access unauthorized components or tools.
