# Skipped Test Cases

## Overview

During API Security Testing, Akto evaluates every request against selection and execution criteria before sending test payloads.\
When a request does not meet required conditions, Akto skips execution and records the reason in the test result.

Skipped tests indicate that Akto intentionally avoided execution based on configuration or runtime validation. Skipped tests do not represent failures.

## **Common Test Skip Reasons**

### 1. API Selection Filter Mismatch

#### Message

```json
Request API failed to satisfy api_selection_filters block, skipping execution
```

#### Execution Control Objective

Ensure the test runs only on APIs that match explicitly defined selection criteria.

#### Reason

Each test may define an `api_selection_filters` block.\
Before execution, the system evaluates the API request and response against these filters.

Filters can be applied on:

* URL
* Query parameters
* Headers
* Request body
* Response parameters

AND / OR conditions are supported.

If the API does not satisfy the configured filter conditions, the test is skipped.

If more granular control is required, you can create custom tests in Test Editor with custom API filters: [create-a-custom-test.md](../../test-editor/how-to/create-a-custom-test.md "mention")

### 2. Authentication Check Failure

#### Message

```
Request API failed authentication check, skipping execution
```

#### Execution Control Objective

Ensure authentication-dependent security tests run only on APIs that enforce authentication.

#### Reason

Before executing certain tests, the system verifies whether the API enforces authentication.

To validate this:

1. All authentication headers are removed from the request.
2. The request is replayed.
3. The response status code is evaluated.

* If the API returns a **4xx response**, authentication is enforced.
* If the API returns a **2xx response**, authentication is not enforced.

If authentication is not enforced, the test is skipped.

## How to View Skipped Tests

Regular review of skipped test cases helps you refine filter logic and maintain authentication accuracy across enterprise API environments. You can check skipped test cases directly from the API Security Testing results page.

{% stepper %}
{% step %}
#### Navigate to Test Results

1. Log in to the Akto Dashboard.
2. Open **API Security Testing** from the left navigation panel.
3. Select **Results**.
4. Choose the test execution you want to review.
{% endstep %}

{% step %}
#### Filter by Skipped Test Cases

Scroll to the results table.\
Above the table, select the **Skipped** filter to display only skipped test cases.

The table displays the issue name and associated error message.
{% endstep %}

{% step %}
#### Review the Detailed Error Message

Select a specific skipped test case from the table.\
Open the test result details panel.

Under the **Evidence** section, review the recorded error message explaining why execution was skipped.

The **Evidence** section provides the exact evaluation reason, including filter mismatches or authentication validation outcomes.
{% endstep %}
{% endstepper %}

## Operational Review of Skipped Test Cases

Skipped test cases indicate evaluation constraints rather than security findings.\
Regular review of skipped executions helps you validate filter logic and authentication enforcement across production traffic.

Consistent monitoring of skipped results improves test coverage accuracy and reduces blind spots in enterprise API environments.

### Get Support

If skipped test cases do not align with expected behaviour, you can review [test case configuration](../../test-editor/concepts/overview.md).

For additional assistance, contact the Akto support team at [**support@akto.io**](mailto:support@akto.io).
