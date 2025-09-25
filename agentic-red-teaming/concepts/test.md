---
description: A comprehensive suite for validating API security posture.
---

# Test

Akto comes with over 1000+ pre-built tests to find vulnerabilities like Broken Authentication, Broken Object Level Authorization (BOLA), Server Side Request Forgery (SSRF), and the rest of OWASP's Top 10, SANS Top 25 and HackerOne Top 10 in APIs. You can also create custom tests that match your API's unique needs. This way, you can ensure a detailed and targeted security check that perfectly aligns with your API's structure and requirements.

You can also schedule your test to run at times that best fit your workflow, ensuring that your API security is checked regularly without disrupting your normal operations.

For more information on how to schedule the test, please refer to the documentation- [**Schedule Test**](../how-to/schedule-tests.md). You can also [create your custom tests](../../probe-library/concepts/custom-test.md) and [run tests in CI/CD](../../ci-cd/how-to/run-tests-in-cicd.md) for continuous testing.

### Akto's Approach

Utilizing Akto's approach of using real traffic data for API scanning has numerous advantages for API issues:

1\. Enhanced Endpoint Coverage: Even though Swagger files include several endpoints, only a small portion are directly testable. The majority require specific data elements like identifiers for testing. By utilizing real traffic data, we can significantly increase our endpoint coverage.

2\. Expanded Test Scope: Real traffic data allowed us to test for more sophisticated issues such as Business Logic flaws, Broken Authentication, and Broken Authorization, which isn't possible with the Swagger file alone.

3\. Detection of Shadow APIs: Our approach reveals several APIs that aren't documented in the Swagger file, highlighting the presence of Shadow APIs.

### Protocol and Event Stream Support

Akto supports a wide variety of API protocols out-of-the-box, ensuring your tests can be run across modern architectures. This includes **REST, GraphQL, gRPC, JSON-RPC**, and **Event-stream** based APIs. Whether your system uses synchronous request/response APIs or real-time event-driven streams, Akto’s testing engine can effectively scan and validate them for vulnerabilities using real traffic data or simulated inputs.

<figure><img src="../../.gitbook/assets/image (119).png" alt=""><figcaption></figcaption></figure>
