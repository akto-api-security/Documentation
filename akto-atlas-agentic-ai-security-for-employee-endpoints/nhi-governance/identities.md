# Identities

The **Identities** view is the central inventory of all Non-Human Identities discovered across your employees' agentic tools. It shows every API key, bearer token, and service credential that Atlas has observed in endpoint traffic, along with who owns it, which agentic asset uses it, its current expiry state, and any policy violations attached to it.

## Summary Cards

At the top of the page, three cards give you an at-a-glance health check of your NHI estate.

| Card | What It Shows |
| ---- | ------------- |
| Total Identities | The total count of distinct NHIs discovered across all endpoints and agentic assets |
| Expired Identities | The number of NHIs whose credentials have passed their expiry date |
| Identities with Violations | The number of NHIs that have at least one active policy violation |

## Identity Graph

Below the summary cards, Akto renders a relationship graph that maps NHIs to the agentic assets that use them. Each node represents either an identity or an agentic asset, and edges show which assets hold which credentials.

Use the graph to:

* Quickly spot identities connected to multiple agentic assets these carry wider blast radius if compromised.
* Identify isolated credentials with no active asset connections, which may indicate orphaned or forgotten keys.
* Navigate to an identity or asset directly by selecting its node.

## Identities Table

The table lists every discovered NHI with the columns below.

| Column | Description |
| ------ | ----------- |
| Identity | The name or identifier of the credential (e.g. `copilot-api-key`, `slack-token`) |
| Agentic Asset | The AI tool or MCP server that holds this credential (e.g. Claude CLI, Cursor, Windsurf) |
| Owner | The employee whose endpoint the credential was discovered on |
| Type | The credential type `API Key` or `Bearer Token` |
| Violations | Count of active policy violations; the red badge shows critical violations, orange shows warnings |
| Expiry Status | Whether the credential is active, has a countdown to expiry, or has already expired |
| Discovered | The date Akto first observed this credential in endpoint traffic |

### Expiry Status Values

| Status | Meaning |
| ------ | ------- |
| Active | The credential is valid and within its allowed window |
| `Xd left` | The credential expires in X days |
| `Expired Xd ago` | The credential expired X days ago but may still be in use |
| No expiry | The credential has no expiry date configured |
| Disabled | The credential has been manually disabled |

## Filters

Use the filter tabs at the top of the table to narrow the view:

* **All** shows every discovered identity regardless of status.
* **Expired** shows only identities whose expiry date has passed.
* **Disabled** shows identities that have been manually disabled.

## Identity Details

Clicking any row in the table opens the **Identity Details** panel. The panel header shows the credential name, its violation badge counts, and key metadata credential type, access level, and when it was last used.

### Actions

The **Action** button in the top-right corner of the panel lets you act on the identity without leaving the detail view.

**Disable Identity**

Selecting **Disable** marks the identity as disabled in Akto. A disabled identity is excluded from active monitoring and will no longer generate new violations. Use this when a credential has been revoked or decommissioned and you want to suppress further alerts without deleting the discovery record.

Disabled identities remain visible in the Identities table and can be filtered using the **Disabled** tab.

The panel has two tabs.

{% tabs %}
{% tab title="Overview" %}
The **Overview** tab shows a graph and an auto-generated description for the selected identity.

### Graph

The graph visualises the full access chain for the credential:

* **Owner** the employee whose endpoint the credential was discovered on.
* **AI Agent** the agentic tool that holds the credential (e.g. Windsurf, Claude CLI, Cursor).
* **Credential node** the identity itself, labelled with its name and type.
* **Downstream services** the external services the credential can reach, with the permission level on each edge (e.g. `READ_WRITE` to GitHub, `READ` to Slack, `ADMIN` to AWS S3).

Use the graph to understand the blast radius of a compromised credential every service reachable via that key is visible at a glance.

### Description

Below the graph, Akto generates a plain-language summary of the identity's current state: which agentic asset uses it, the access level it grants, and how many active violations it has.
{% endtab %}

{% tab title="Violations" %}
The **Violations** tab lists every active policy breach attached to this identity. The tab label shows the total violation count (e.g. `Violations 4`).

| Column | Description |
| ------ | ----------- |
| Violation | A plain-language description of the specific breach (e.g. "Agent credential accessing production S3 with admin privileges") |
| Identity | The credential the violation is attached to |
| Agentic Asset | The agentic tool associated with the identity at the time of the breach |
| Severity | The risk level `Critical`, `High`, `Medium`, or `Low` |
| Policy | The policy rule that was breached (e.g. "Restrict Access to Sensitive Resources", "Rotate API Keys Every 30 Days") |
| Discovered | When Akto first detected this violation |

Violations are paginated. Use the arrow controls at the bottom of the table to page through all entries.

For full details on violation types and remediation steps, see [Violations](violations.md).
{% endtab %}
{% endtabs %}

## What You Can Do

* Export the full identity list to CSV using the download icon at the top right of the table.
