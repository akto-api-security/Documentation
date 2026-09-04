# Understanding Role Permissions

Akto uses a role-based access control system to manage user permissions. Each role has a specific set of permissions that determine what actions a user can perform within the platform.

### Roles Are Assigned Per Product

Akto has four products: **API Security**, **Atlas**, **Argus**, and **DAST**. Roles are assigned per product, so a user's role in one product is independent of their role in another. For example, the same user could hold:

* **Security Engineer** in **Argus**
* **Admin** in **API Security**
* **Guest** in **DAST**
* No access at all in **Atlas**, if that product isn't relevant to their work

### Role Types

<table><thead><tr><th width="211">Role</th><th width="505">Description</th></tr></thead><tbody><tr><td><strong>Admin</strong></td><td>Full system administrator with complete control over all features. Can manage users, settings, and perform all administrative actions.</td></tr><tr><td><strong>Security Engineer</strong></td><td>Primary role for red teaming and analysis. Has full access to scanning features and agentic Inventory.</td></tr><tr><td><strong>Threat Engineer</strong></td><td>Superset of Security Engineer with Threat Protection access added. Can edit and view Threat Protection in addition to everything a Security Engineer can access.</td></tr><tr><td><strong>Threat Viewer</strong></td><td>Superset of Security Engineer with Threat Protection read access added. Can view (but not edit) Threat Protection in addition to everything a Security Engineer can access.</td></tr><tr><td><strong>Developer</strong></td><td>Technical role focused on integration and development. Has view access to security features and can manage integration settings.</td></tr><tr><td><strong>Guest</strong></td><td>Basic viewer role with view-only access to most features. Can view but cannot modify Agentic Inventory.</td></tr></tbody></table>

{% hint style="info" %}
Every role above, including **Threat Engineer** and **Threat Viewer**, is assigned separately within each of the four products: **API Security**, **Atlas**, **Argus**, and **DAST**.
{% endhint %}

### Role Hierarchy

```
Admin
  └── Security Engineer
       ├── Threat Engineer   (Security Engineer + Threat Protection edit)
       ├── Threat Viewer     (Security Engineer + Threat Protection view)
       └── Developer
            └── Guest
```

Threat Engineer and Threat Viewer are built on top of Security Engineer: they carry every permission Security Engineer has, plus Threat Protection access, so despite sitting at the same level in this tree, they have more access than a plain Security Engineer.

### Feature Access & Descriptions

#### Legend

✅ Edit & View\
👁️ View Only

<table><thead><tr><th width="200">Feature</th><th>Admin</th><th width="140">Security Engineer</th><th width="130">Threat Engineer</th><th width="120">Threat Viewer</th><th>Developer</th><th width="76">Guest</th><th>Description</th></tr></thead><tbody><tr><td><strong>Agentic Inventory</strong></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr><tr><td>Agentic Collections</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>👁️</td><td>👁️</td><td>Manage and organize Agentic components</td></tr><tr><td>Traffic Filters</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>👁️</td><td>👁️</td><td>Configure agentic traffic filtering rules</td></tr><tr><td>Sample Data</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>👁️</td><td>👁️</td><td>Access to agentic sample data</td></tr><tr><td>Tags</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>👁️</td><td>👁️</td><td>Organize resources with tags</td></tr><tr><td><strong>Threat Protection</strong></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr><tr><td>Threat Protection</td><td>✅</td><td></td><td>✅</td><td>👁️</td><td></td><td></td><td>Configure and review Threat Protection across API Security, Atlas, Argus, and DAST</td></tr><tr><td><strong>Scanning Capabilities</strong></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr><tr><td>Scan Run</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>👁️</td><td>👁️</td><td>Initialize security scans</td></tr><tr><td>Scan Results</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>👁️</td><td>👁️</td><td>View and analyze scan outcomes</td></tr><tr><td>Probe Editor</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>👁️</td><td>👁️</td><td>Create/modify probe cases</td></tr><tr><td>Issues</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>👁️</td><td>👁️</td><td>Manage security issues</td></tr><tr><td><strong>Settings</strong></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr><tr><td>Integrations</td><td>✅</td><td>👁️</td><td>👁️</td><td>👁️</td><td>✅</td><td>👁️</td><td>Manage third-party integrations</td></tr><tr><td>Billing</td><td>✅</td><td>👁️</td><td>👁️</td><td>👁️</td><td>👁️</td><td>👁️</td><td>Access billing and subscription</td></tr><tr><td>User Management</td><td>✅</td><td>👁️</td><td>👁️</td><td>👁️</td><td>👁️</td><td>👁️</td><td>Manage user accounts and roles</td></tr><tr><td><strong>Monitoring &#x26; Analysis</strong></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr><tr><td>Metrics</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>👁️</td><td>👁️</td><td>View system performance metrics</td></tr><tr><td>Logs</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>👁️</td><td>👁️</td><td>Access system logs</td></tr><tr><td>Sensitive Data</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>👁️</td><td>👁️</td><td>Manage sensitive data detection</td></tr><tr><td><strong>Common Features</strong></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr><tr><td>Ask Akto</td><td>✅</td><td>✅</td><td>✅</td><td>✅</td><td>👁️</td><td>👁️</td><td>AI-assisted analysis</td></tr></tbody></table>

### Custom Roles

Organizations can create custom roles to meet specific business needs by combining permissions from different standard roles. To create and manage custom roles, check the [Custom roles documentation](custom-roles.md).
