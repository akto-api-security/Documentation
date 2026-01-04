---
description: Role-based security testing for agentic systems.
---

# Scan Roles

Scan roles enable role-based testing of agentic systems to validate access controls, tool permissions, and authorization boundaries. By defining test roles, you can ensure agents enforce correct access controls and prevent unauthorized tool execution or data access.

You can create custom test roles representing different personas or scenarios, ensuring each role can only perform authorized actions within your agentic system.

## Common Scan Roles

**TEST_USER**: Standard user role for testing typical agent interactions and permissions.

**ATTACKER_TOKEN_ALL**: Simulates an attacker with compromised credentials to validate security boundaries.

**MEMBER**: Regular member role for testing team-level access controls and collaboration features.

For information on creating test roles, refer to [Create a Test Role](../how-to/create-a-test-role.md).
