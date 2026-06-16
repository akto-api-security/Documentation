# Run Test

Running security tests in Akto involves assessing specific parts of your API endpoints to assess their security posture. With Akto, you have the flexibility to run the tests instantly or schedule a single test run for a later time. This feature is particularly useful for planning future testing sessions or implementing regular tests. The Akto testing module contains 1000+ templates that you can use just out of the box.

## Prerequisites

To run tests in Akto, you must have at least one [**test role**](create-a-test-role.md) configured in your account. Without a test role, no tests can be executed — the testing engine uses test roles to define the identity (and its associated auth credentials) under which API requests are replayed during a scan.

{% hint style="info" %}
Authenticated scans deliver the best results. We strongly encourage you to set an auth token before running tests:

* **Authenticated scan (recommended):** Create an auth token and [configure it as a hard-coded auth token](create-a-test-role.md#1-hard-coded-auth-token) in your test role.
* **Unauthenticated scan:** Still create a hard-coded auth in your test role, but use a dummy header — for example, `x-dummy-auth: true`.
{% endhint %}

## Running a Test
In the demonstration below, let's run tests on <mark style="color:red;">`/rest/products/search`</mark> endpoint within **demo\_collection**.

{% @arcade/embed url="https://app.arcade.software/share/uH7TcfV5by6oJ1L4SAvG" flowId="uH7TcfV5by6oJ1L4SAvG" %}

In the demonstration above, we performed tests on the <mark style="color:red;">`/rest/products/search`</mark> endpoint from the **demo\_collection** API.

### Smart Automated Testing

Check **Smart Automated Testing** in the test configuration panel to have Akto's AI agent execute the tests. See [Smart Automated Testing](../concepts/smart-automated-testing.md) for details.

### Add/modify/delete headers/params

Easily add, modify, or remove headers like “x-forwarded-for” or “x-no-alarm” directly from the test configuration, without editing YAML files.

<figure><img src=”../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png” alt=””><figcaption></figcaption></figure>
