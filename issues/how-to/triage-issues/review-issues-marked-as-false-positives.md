# Review Issues Marked as False Positives

### Introduction

You can use Akto to review and manage issues marked as **False Positive** during agentic security testing. This lets you revisit ignored issues in your agent components, check their details, and reopen them if needed.

Here’s what you can do:

* [View all false positive issues](review-issues-marked-as-false-positives.md#view-false-positive-issues)
* [Review issue details](review-issues-marked-as-false-positives.md#review-issue-details)
* [Reopen an issue if necessary](review-issues-marked-as-false-positives.md#reopen-an-issue)

***

### View False Positive Issues

1. Go to **Reports > Issues** in the Akto dashboard.
2. Click the **Ignored** tab to see all issues marked as false positives or acceptable risks.

***

### Review Issue Details

Click on any issue to open its details, including:

* **Overview**: Description, severity, agent component endpoint, authentication, sensitive data, and impact
* **Timeline**: When the issue was detected and when it was marked as a false positive
* **Values**: Request and response data showing the agent component interactions and payloads tested
* **Remediation**: Suggested steps to fix the issue in your agent components (with code examples where applicable)

Use these tabs to verify why an issue was marked as false positive and if it needs action.

***

### Reopen an Issue

If an issue needs further investigation:

1. Open the issue and click the **Triage** dropdown.
2. Select **Reopen** to move the issue back to the Open state.

You can then assign it for remediation or create a Jira ticket for tracking.
