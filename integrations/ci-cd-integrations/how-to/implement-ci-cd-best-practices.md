# Implement CI/CD Best Practices

## Overview

Enterprise CI/CD pipelines require predictable execution time, controlled enforcement logic, and minimal developer disruption. The following practices help you integrate Akto into CI/CD workflows in a controlled and scalable manner.

## Best Practices

### 1. Set an Upper Time Limit to Prevent Pipeline Delays ⌛

{% hint style="info" %}
## **Usecase**&#x20;

Your CI/CD pipeline has strict execution time constraints, and security testing should not delay releases beyond an acceptable window.
{% endhint %}

Akto allows you to define a maximum wait time for test execution. When the configured limit is reached, Akto stops the testing module immediately.

You can configure the limit using:

```bash
WAIT_TIME_FOR_RESULT=300
```

The example above sets a 5-minute maximum wait time.

A defined time boundary ensures predictable CI/CD duration and prevents extended scans from blocking downstream stages.

### 2. Enable Non-Blocking Mode to Avoid Release Friction 🚦

{% hint style="info" %}
## **Usecase**&#x20;

Your team is introducing Akto into CI/CD and wants visibility into security findings without impacting deployment timelines.
{% endhint %}

Non-blocking mode allows Akto to run tests asynchronously without blocking the pipeline.

You can enable non-blocking mode by setting:

```bash
WAIT_TIME_FOR_RESULT=0
```

With non-blocking mode:

* The CI/CD pipeline proceeds immediately.
* Akto executes tests in the background.
* Reports are delivered through Slack, Email, or the Akto Dashboard.

Non-blocking mode helps platform teams build confidence in security testing before enabling enforcement.

### 3. Configure Block Level Based on Risk Tolerance 🚫

{% hint style="info" %}
## **Usecase**&#x20;

Your organisation wants to block Pull Requests only when high-risk vulnerabilities are introduced.
{% endhint %}

Akto allows severity-based blocking using the `BLOCK_LEVEL` configuration.

```bash
BLOCK_LEVEL=HIGH
```

With `BLOCK_LEVEL=HIGH`:

* Pull Requests are blocked for High or Critical severity tests.
* Medium and Low severity findings do not block the pipeline.

Severity-based blocking ensures enforcement aligns with enterprise risk thresholds while maintaining development velocity.

### 4. Run Custom Test Suites in CI/CD 🛠️

{% hint style="info" %}
## **Usecase**&#x20;

Your CI/CD pipeline requires fast execution and should focus only on high-impact or low-latency tests.
{% endhint %}

Akto supports selective test execution where you:

* Run only High or Critical severity tests.
* Run only Fast tests.
* Create and use a Custom Test Suite.

Targeted execution reduces runtime while preserving coverage for high-risk vulnerabilities.

You can create a Custom Test Suite by following: [create-custom-test-suites.md](../../../api-security-testing/how-to/create-custom-test-suites.md "mention")

### 5. Schedule Weekly Full Scans for Complete Coverage 🗓️

{% hint style="info" %}
## **Use case**&#x20;

Your CI/CD pipeline runs only high-impact tests, and your team requires periodic full coverage across all security checks.
{% endhint %}

A weekly complete API security scan ensures that Medium and Low severity findings are also identified.

You can configure and manage full API security testing from: [schedule-tests.md](../../../api-security-testing/how-to/schedule-tests.md "mention")

### 6. Configure Automated Authentication Token Generation 👨‍💻

{% hint style="info" %}
## **Use case**&#x20;

Your APIs require authentication, and manually rotating tokens in CI/CD causes test failures or operational overhead.
{% endhint %}

Akto supports automated authentication token generation for each test run.

Automated authentication ensures:

* Fresh tokens for every execution.
* No manual updates when tokens expire.
* Stable and repeatable CI/CD test runs.

You can configure automated authentication by following: [#automated-auth-token-generation](../../../api-security-testing/how-to/create-a-test-role.md#automated-auth-token-generation "mention")
