# Test Result

API test results provide valuable insights into the security posture of an API. These results are generated through systematic security testing procedures that evaluate various aspects of the API's behavior. You can view all your test results and take action on them in one place.

In the demonstration below, we have viewed the test result of the selected API endpoint, "BOLA by changing auth token".

Go to **Testing > Results**. Click on the test that you have chosen from the test categories.

{% @arcade/embed url="https://app.arcade.software/share/Qc3ooTCl1AmYj9yk6rFD" flowId="Qc3ooTCl1AmYj9yk6rFD" %}

In the above demonstration, Akto ran **`BOLA by changing auth token`** tests on the **`rest/products/INTEGER/reviews`** endpoint. The results show high vulnerability when testing **"BOLA changing the auth token"** through a custom test.

### Instant Visibility into Test Outcomes

Akto provides **instant visibility** into test results, enabling you to quickly understand the security impact of each test. You can easily view **HTTP status codes** (e.g., `403 Forbidden`, `200 OK`) alongside **response messages** to assess how the API responded to different test conditions.

<figure><img src="../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

### Time Delays for Multi-Step and Async Test Flows

Akto allows you to insert precise **delays between API requests** using the `wait` directive in your test templates. This is particularly valuable when testing **asynchronous operations**, **multi-step flows**, or **delayed backend responses** where subsequent API calls depend on prior processing.

<figure><img src="../../.gitbook/assets/image (118).png" alt=""><figcaption></figcaption></figure>

## AI Execution Trace

When a test is run using [Smart Automated Testing](smart-automated-testing.md), the result includes an **AI Execution Trace** under the **Evidence** tab. This trace gives you full visibility into how the AI agent reasoned and acted during the test.

The trace is structured as a sequential log of the agent's execution loop:

| Entry | Description |
|-------|-------------|
| **Thinking** | The agent's initial reasoning about the test — what vulnerability is being tested, what the baseline request establishes, and what response signals would confirm a finding. |
| **Plan (Attempt N)** | The agent's strategy for that specific attempt — what it will change and why. |
| **Action (Attempt N)** | The exact HTTP request sent: method, URL, and key request parameters. |
| **Observation (Attempt N)** | The agent's interpretation of the response — status code, body content, and whether the result is conclusive. |

If the first attempt is inconclusive (e.g., a CAPTCHA error, unexpected redirect, or ambiguous response), the agent adjusts its approach and runs a second attempt, then a third, and so on. Each attempt is independently logged so you can trace exactly how the agent's strategy evolved.

The final entry in the trace is the **vulnerability validation**, where the agent makes its definitive determination based on all observed evidence.
