# User Config

With Akto, you can automate the process of generating attacker tokens required for  **Broken Object Level Authorization (BOLA)** . These tokens are required to simulate the actions of malicious actors and help identify BOLA-related vulnerabilities in your API's authorization mechanisms.

In the demonstration below, let’s run a test by selecting an authenticated API endpoint from the  **`juice_shop_demo`** collection.

#### 1. Configure attacker token

In the demonstration below, we have added an **Auth header key** and **Auth header value** to facilitate authentication when making requests to the API.\
Go to the **Testing > User Config**. Enter the **Auth Header Key** and **Auth Header Value**. Click on the **Save Change**.

{% embed url="https://app.arcade.software/share/pingeeeBhQTpRhzO1vA4" %}

In the above demonstration, we have added an Auth token. Now let's check the test results.

You can also automate attacker auth token generation by clicking on the `Automated` button and follow the steps [here](../how-to/create-a-test-role.md#automated-auth-token-generation).&#x20;

#### 2. **Run BOLA tests**

Go to **API Inventory > API Collection**. Select the **API collection** for which you want to run the test and sort authenticated API endpoints based on your requirements. Click on the **Run test** button. Select the **Test Categories (BOLA)**, then click on the **Run Test**.

{% embed url="https://demo.arcade.software/2hQpW31GPsc9JTlY5F18?embed=" %}
Conduct Authenticated Testing
{% endembed %}

In the above demonstration, we have run tests for **Broken Object Level Authorization (BOLA)** by changing the auth token on **`rest/product/review`** endpoint of the **juice\_shop\_demo** collection.

#### 3. Verify results

{% embed url="https://app.arcade.software/share/dsxE1pJ91oF6jpT170JB" %}

In the above demonstration, we will see both the original authentication token of the API and the modified authentication code. The observation from the test indicates that the authentication system could be easily altered or manipulated.\
\
This suggests there might be security issues, such as weak authentication controls, or a risk of unauthorized access, like tampering with or injecting tokens. It's a call for further investigation and fixes to strengthen the system's security.
