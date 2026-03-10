---
hidden: true
---

# Run Bulk Scanning

## Overview

Bulk Testing for Agentic Collections allows enterprise security and platform teams to execute security tests across multiple APIs generated or discovered through agentic workflows. Bulk execution helps evaluate the security posture of an entire agentic API set without running tests for each endpoint individually.

Akto executes the selected tests against all endpoints in the Agentic Collection and records results in the testing results view.

## Access Bulk Testing from Agentic Collections

Bulk Testing is available inside the API Collections view.

**Steps**

{% stepper %}
{% step %}
Navigate to **Agentic Discovery** in the Akto Argus dashboard.
{% endstep %}

{% step %}
Open **Agentic Collections**
{% endstep %}

{% step %}
Select the collection containing the component you want to test.
{% endstep %}

{% step %}
Click **Run Tests** from the bulk actions menu.

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (147).png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}
{% endstepper %}

Akto opens the **Bulk Test configuration panel**.

## Configure Scan Parameters for Bulk Execution

The **Configure Scan** panel allows enterprise security teams to define test categories, execution behavior, and runtime limits for the bulk scan.

You can configure the following parameters:

* **Test Categories and Tests**\
  Select MCP security categories and individual tests that should run across the selected APIs.
* **Run Type**\
  Choose whether the scan runs **once** or on a **scheduled date and time**.
* **Scan Runtime**\
  Define the maximum duration allowed for the scan execution.
* **Scan Role**\
  Select the test role used for authentication or access control during test execution.
* **Max Concurrent Requests**\
  Control how many test requests Akto sends simultaneously.
* **Max Agent Tokens**\
  Define the token limit used during agent-driven test execution.

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (148).png" alt="" width="563"><figcaption></figcaption></figure></div>

Optional integrations allow alert delivery through **Slack**, **Microsoft Teams**, or automatic ticket creation after scan completion.

## Execute Bulk Scan

After configuration:

1. Review selected **test categories and parameters**.
2. Click **Run once now**.

## Review Bulk Scan Results

Akto aggregates results from all tested endpoints and displays findings in the **testing results view**.

Enterprise security teams can:

* Identify vulnerabilities across multiple agentic APIs.
* Investigate results for individual endpoints.
* Prioritise remediation based on severity.

Bulk Testing helps security teams evaluate security coverage across large agent-generated API inventories efficiently.
