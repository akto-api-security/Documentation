---
description: >-
  Effortlessly conduct API tests by category for comprehensive evaluation of
  security vulnerabilities and issues.
---

# Run Tests by Category

With Akto's testing module, you can conduct hundreds of tests on your APIs from all of OWASP API's Top 10. You can select individual tests from Akto's test library or organize and run tests by category. This categorization allows you to run specific tests such as **Broken Object Level Authorization (BOLA).** These tests are tailored to evaluate different facets of your API endpoints' security.

In the demonstration below, let's run a test by category on a particular endpoint within an API collection.

For example, we'll be running the **Broken Object Level Authorization (BOLA)** category tests on the **`rest/products/INTEGER/reviews`** endpoint of the **`juice_shop_demo`** collection.

{% embed url="https://app.arcade.software/share/JN1APG6S9URAvX2nI9xj" %}

In the demonstration above, we performed a test on the **`rest/products/INTEGER/reviews`** endpoint from the **`juice_shop_demo`** API. Our focus was on the **Broken Object Level Authorization (BOLA)** category to detect any potential security issues.

Now let's check the results. Akto ran tests on the **`rest/products/INTEGER/reviews`** endpoint, and it seems like there's an issue with this endpoint as it returned unexpected results.

{% embed url="https://app.arcade.software/share/Qc3ooTCl1AmYj9yk6rFD" %}

Akto ran **`BOLA by changing auth token`** tests on the **`rest/products/INTEGER/reviews`** endpoint. The results show high-severity issues when testing **"BOLA changing the auth token"** through a custom test.
