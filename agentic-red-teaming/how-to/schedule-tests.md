---
description: Learn all about scheduled tests.
---

# Schedule Tests

## Choose an API Endpoint for Scheduling Tests

Akto enables you to schedule tests for API endpoints. It ensures consistent and regular verification of API functionality, even in complex and dynamic environments.

By scheduling tests to run at predetermined intervals, you can continuously monitor API performance and detect potential issues before they escalate into critical problems.

In the demonstration below, let’s run a test and schedule it for the **“rest/products/search”** endpoint within the collection name **"demo\_collection."**

Go to **API Discovery >API Collection.** Select the **API Collection** and click on the **Run Test.** Select the **Test Categories** and **Tests** that you want to test. **Select Time** to trigger your test, then click on **Run Test** to schedule the test.

{% @arcade/embed flowId="hK8GaU6w1YYkeRZtrBwr" url="https://app.arcade.software/share/hK8GaU6w1YYkeRZtrBwr" %}

In the above demonstration, we have scheduled tests to run daily at 2 am till its completion for **“GET https://juiceshop.akto.io/rest/products/search”** endpoint within the collection name **"demo\_collection".**

### Results of Scheduled Test

By analyzing the results of scheduled tests, you can identify and address any issues or vulnerabilities, ensuring that the API functions as intended and meets the requirements.

Moreover, these results can inform decisions related to data breaches, and performance optimization.

In the demonstration below, after running the scheduled test named **“test\_for\_one\_endpoint”** for an endpoint, let’s check for the vulnerabilities present in the selected endpoint.

Go to **Testing > Results**. Click on the scheduled test to identify vulnerabilities based on the selected endpoint tests.

{% embed url="https://demo.arcade.software/Xg3bC0JuLKLabOlqrKtY?embed=" %}

In the demonstration above, after running the scheduled test named **“test\_for\_one\_endpoint”**, we checked the endpoint **“GET https://juiceshop.akto.io/redirect”** and found an error named **“Kernel open command injection in Ruby”** present in the endpoint.
