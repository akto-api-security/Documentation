# Understanding Role Permissions

Akto uses a role-based access control system to manage user permissions. Each role has a specific set of permissions that determine what actions a user can perform within the platform.

### Role Types

<table><thead><tr><th width="211">Role</th><th width="505">Description</th></tr></thead><tbody><tr><td><strong>Admin</strong></td><td>Full system administrator with complete control over all features. Can manage users, settings, and perform all administrative actions.</td></tr><tr><td><strong>Security Engineer</strong></td><td>Primary role for security testing and analysis. Has full access to testing features and security operations.</td></tr><tr><td><strong>Developer</strong></td><td>Technical role focused on integration and development. Has read access to security features and can manage integration settings.</td></tr><tr><td><strong>Guest</strong></td><td>Basic viewer role with read-only access to most features. Can view but cannot modify security configurations.</td></tr></tbody></table>

### Role Hierarchy

```
Admin
  └── Security Engineer
       └── Developer
            └── Guest
```

### Feature Access & Descriptions

#### Legend

✅ Full Access (Read & write)\
👁️ View Only (Read)

<table><thead><tr><th width="228">Feature</th><th>Admin</th><th width="147">Security Engineer</th><th>Developer</th><th width="76">Guest</th><th>Description</th></tr></thead><tbody><tr><td><strong>Security Operations</strong></td><td></td><td></td><td></td><td></td><td></td></tr><tr><td>API Collections</td><td>✅</td><td>✅</td><td>👁️</td><td>👁️</td><td>Manage and organize API endpoints</td></tr><tr><td>Traffic Filters</td><td>✅</td><td>✅</td><td>👁️</td><td>👁️</td><td>Configure API traffic filtering rules</td></tr><tr><td>Sample Data</td><td>✅</td><td>✅</td><td>👁️</td><td>👁️</td><td>Access to API sample data</td></tr><tr><td>Tags</td><td>✅</td><td>✅</td><td>👁️</td><td>👁️</td><td>Organize resources with tags</td></tr><tr><td><strong>Testing Capabilities</strong></td><td></td><td></td><td></td><td></td><td></td></tr><tr><td>Start Test Run</td><td>✅</td><td>✅</td><td>👁️</td><td>👁️</td><td>Initialize security tests</td></tr><tr><td>Test Results</td><td>✅</td><td>✅</td><td>👁️</td><td>👁️</td><td>View and analyze test outcomes</td></tr><tr><td>Test Editor</td><td>✅</td><td>✅</td><td>👁️</td><td>👁️</td><td>Create/modify test cases</td></tr><tr><td>Issues</td><td>✅</td><td>✅</td><td>👁️</td><td>👁️</td><td>Manage security issues</td></tr><tr><td><strong>Settings</strong></td><td></td><td></td><td></td><td></td><td></td></tr><tr><td>Integrations</td><td>✅</td><td>👁️</td><td>✅</td><td>👁️</td><td>Manage third-party integrations</td></tr><tr><td>Billing</td><td>✅</td><td>👁️</td><td>👁️</td><td>👁️</td><td>Access billing and subscription</td></tr><tr><td>User Management</td><td>✅</td><td>👁️</td><td>👁️</td><td>👁️</td><td>Manage user accounts and roles</td></tr><tr><td><strong>Monitoring &#x26; Analysis</strong></td><td></td><td></td><td></td><td></td><td></td></tr><tr><td>Metrics</td><td>✅</td><td>✅</td><td>👁️</td><td>👁️</td><td>View system performance metrics</td></tr><tr><td>Logs</td><td>✅</td><td>✅</td><td>👁️</td><td>👁️</td><td>Access system logs</td></tr><tr><td>Sensitive Data</td><td>✅</td><td>✅</td><td>👁️</td><td>👁️</td><td>Manage sensitive data detection</td></tr><tr><td><strong>Common Features</strong></td><td></td><td></td><td></td><td></td><td></td></tr><tr><td>Ask GPT</td><td>✅</td><td>✅</td><td>👁️</td><td>👁️</td><td>AI-assisted analysis</td></tr></tbody></table>

### Custom Roles

Organizations can create custom roles to meet specific business needs by combining permissions from different standard roles. To create and manage custom roles, check the [Custom roles documentation](custom-roles.md).
