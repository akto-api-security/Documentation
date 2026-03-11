---
description: Role-based security probing for agentic systems.
---

# Scan Roles

Scan roles enable role-based probing of agentic systems to validate access controls, tool permissions, and authorization boundaries. By defining scan roles, you can ensure agents enforce correct access controls and prevent unauthorized tool execution or data access.

You can create custom scan roles representing different personas or scenarios, ensuring each role can only perform authorized actions within your agentic system.

## Common Scan Roles

**TEST_USER**: Standard user role for probing typical agent interactions and permissions.

**ATTACKER_TOKEN_ALL**: Simulates an attacker with compromised credentials to validate security boundaries.

**MEMBER**: Regular member role for probing team-level access controls and collaboration features.

For information on creating scan roles, refer to [Create a Scan Role](../how-to/create-a-test-role.md).
