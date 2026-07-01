# Violations

## Overview

The **Violations** page provides a unified view of all policy breaches raised against Non-Human Identities in your organisation. It enables you to monitor violation trends, assess severity distribution, and manage each breach from detection through to resolution from a single interface.

## Key Metrics

Two charts at the top of the page give you an at-a-glance picture of your NHI violation posture.

### Violations Over Time

A line chart showing the total number of violations detected across the selected time window. Use this to spot spikes in new violations and track whether your remediation efforts are reducing the open count over time.

### Violations by Severity

A donut chart breaking down all violations by severity level Critical, High, Medium, and Low. This helps you quickly understand the risk profile of your current violation backlog and prioritise which identities need attention first.

## Violations Table

The table lists every violation raised across all NHIs.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/image (202).png" alt="" width="563"><figcaption></figcaption></figure></div>

<table><thead><tr><th width="213.80859375">Column</th><th>Description</th></tr></thead><tbody><tr><td>Violation</td><td>A plain-language description of the specific breach</td></tr><tr><td>Identity</td><td>The NHI the violation is attached to</td></tr><tr><td>Agentic Asset</td><td>The agentic tool associated with the identity at the time of the breach</td></tr><tr><td>Severity</td><td>The risk level <code>Critical</code>, <code>High</code>, <code>Medium</code>, or <code>Low</code></td></tr><tr><td>Policy</td><td>The policy rule that was breached</td></tr><tr><td>Discovered</td><td>When Akto first raised this violation</td></tr></tbody></table>

### Filters

Use the filter tabs at the top of the table to narrow the view:

* **All** every violation regardless of status.
* **Open** violations that have not yet been resolved.
* **Fixed** violations that have been marked as fixed.

Use the **time filter** at the top-right of the page to scope the violation list and charts to a specific time window.

{% hint style="info" %}
**Search and Sort**

Use the search and filter icons at the top-right of the table to filter violations by identity, agentic asset, severity, or policy. Use the sort icon to re-order by any column.
{% endhint %}

## Take Bulk Action

You can act on multiple violations at once without opening each one individually.

{% stepper %}
{% step %}
Select violations using the checkbox at the start of each row. A selection count appears above the table (e.g. `2 selected`).
{% endstep %}

{% step %}
A bulk action bar appears at the bottom of the table with the following options:

* **Mark as Fixed** resolves the selected violations and moves them to the Fixed tab.
* **Open Jira Ticket** creates a Jira ticket for each selected violation to support internal tracking and remediation workflows.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/image (203).png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}
{% endstepper %}

## Violation Details

Clicking any row opens the **Violation Details** panel. The panel header shows the violation name, its severity badge, the identity it is attached to, and when it was last seen. An **Action** button in the top-right corner lets you act on the violation without leaving the panel.

### Actions

Expanding the **Action** dropdown gives you three options:

* **Open Jira Ticket** creates a Jira issue for this violation to track remediation in your existing workflow.
* **Mark as Fixed** resolves the violation and moves it to the Fixed tab. Use this once the underlying credential issue has been remediated.
* **Update Policy** navigates directly to the policy that triggered this violation so you can adjust its rules if needed.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/image (204).png" alt="" width="563"><figcaption></figcaption></figure></div>

### Violation Detail Tabs

The panel is organised into three tabs.

{% tabs %}
{% tab title="Overview" %}
The **Overview** tab provides the full context needed to understand and prioritise the violation.

*   **Description**

    A plain-language explanation of what was detected for example, which credential has which permission level on which service, and why that is a risk.
*   **Policy Triggered**

    The name of the NHI policy whose rule was breached, linked directly to the policy configuration.
* **Affected Resources**\
  The downstream services exposed by this violation (e.g. GitHub Repos, GitHub Actions, AWS S3).
* **Discovered**\
  The timestamp when Akto first raised this violation.
* **Why This Triggered**\
  An explanation of the specific condition that caused the policy rule to fire for example, why the credential's scope violates the policy's intent.
* **Blast Radius**\
  A bulleted list of the potential consequences if the credential were compromised or misused, scoped to the actual permissions it holds.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/image (205).png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endtab %}

{% tab title="Remediation" %}
The **Remediation** tab provides step-by-step guidance for resolving the violation, tailored to the specific policy rule that was breached.

**Steps to Resolve**

A numbered list of concrete actions to take for example:

1. Replace the credential with a scoped token that has only the permissions the agent actually requires.
2. Limit permissions to the minimum required for the agent task.
3. Enable audit log streaming on the affected service and review recent API activity.
4. Revoke or downgrade any admin-level scopes from the credential.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/image (206).png" alt="" width="563"><figcaption></figcaption></figure></div>

After completing the steps, use **Mark as Fixed** from the Action menu to close the violation.
{% endtab %}

{% tab title="Timeline" %}
The **Timeline** tab shows a chronological record of events related to this violation from the initial credential creation through to policy breach detection and any subsequent activity.

Each entry shows a short description of the event and the date it occurred. Use the timeline to understand the full history of the identity's lifecycle and establish whether the issue is a misconfiguration or an active threat.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/image (207).png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endtab %}
{% endtabs %}

## What Next

After resolving a violation, review the [Create NHI Policies](policies.md) page to tighten the policy rules that triggered it, or check the [Identities](identities.md) view to disable a credential that has been decommissioned.
