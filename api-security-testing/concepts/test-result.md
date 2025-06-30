# Test Result

API test results provide valuable insights into the security posture of an API. These results are generated through systematic security testing procedures that evaluate various aspects of the API's behavior. You can view all your test results and take action on them in one place.

In the demonstration below, we have viewed the test result of the selected API endpoint, "BOLA by changing auth token".&#x20;

Go to **Testing > Results**. Click on the test that you have chosen from the test categories.

{% @arcade/embed flowId="Qc3ooTCl1AmYj9yk6rFD" url="https://app.arcade.software/share/Qc3ooTCl1AmYj9yk6rFD" %}

In the above demonstration, Akto ran **`BOLA by changing auth token`** tests on the **`rest/products/INTEGER/reviews`** endpoint. The results show high vulnerability when testing **"BOLA changing the auth token"** through a custom test.

### Instant Visibility into Test Outcomes

Akto provides **instant visibility** into test results, enabling you to quickly understand the security impact of each test. You can easily view **HTTP status codes** (e.g., `403 Forbidden`, `200 OK`) alongside **response messages** to assess how the API responded to different test conditions.&#x20;

<figure><img src="../../.gitbook/assets/image (1) (1).png" alt=""><figcaption></figcaption></figure>

### Time Delays for Multi-Step and Async Test Flows

Akto allows you to insert precise **delays between API requests** using the `wait` directive in your test templates. This is particularly valuable when testing **asynchronous operations**, **multi-step flows**, or **delayed backend responses** where subsequent API calls depend on prior processing.

<figure><img src="../../.gitbook/assets/image (118).png" alt=""><figcaption></figcaption></figure>
