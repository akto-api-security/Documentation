---
description: Conduct role-based security testing for agentic systems.
---

# Conduct Role-Based Testing

Akto enables role-based testing for agentic systems, aligning with Role-Based Access Control (RBAC) principles. This verifies that each role can only access authorized agent components and tools.

This testing approach is essential for maintaining system integrity by reducing risks of unauthorized access and data breaches, especially in environments where agent roles are diverse and complex.

## Conducting Role-Based Tests

When you [run a test](run-test.md), you can select a test role to ensure the test reflects the permissions and access levels associated with that role.

1. Navigate to **Agentic Discovery > Collections**
2. Select the collection containing agent components
3. Click **Run Test**
4. Select test categories
5. Choose a **Test Role** (e.g., Member, Admin, Viewer)
6. Click **Run Test**

## Reviewing Role-Based Test Results

Navigate to **Agentic Red Teaming > Results** to view findings. If no vulnerabilities are found in the vulnerable section, it indicates that access control for that role is properly configured and the role cannot access unauthorized components or tools.
