# Triage Issues

### Quick Actions

1. **Jira Ticket**: Create a Jira ticket directly from Akto. (Learn more about Jira integration)
2. **Ignore**: Mark the issue as ignored, with several sub-options:
   * **False Positive**: Issue is incorrectly identified and not a real security concern.
   * **Acceptable Risk**: Acknowledged risk that has been deemed acceptable for business reasons.
   * **No Time to Fix**: Issue recognized but not prioritized for immediate action.

### Detailed Ignore Options

#### False Positive

* Use when: Akto has misidentified normal behavior as a security issue.
* Impact: Helps improve Akto's accuracy and reduces noise in future scans.

#### Acceptable Risk

* Use when: The potential vulnerability is understood but accepted due to business needs or compensating controls.
* Impact: Acknowledges the issue without requiring immediate action, useful for risk management reporting.

#### No Time to Fix

* Use when: The issue is valid but current resources or priorities don't allow for immediate remediation.
* Impact: Keeps the issue in view for future sprints or when resources become available.

### Learn More

For information on integrating Akto with Jira for streamlined issue management, visit our [Jira Integration Guide](../../../integrations/jira.md).
