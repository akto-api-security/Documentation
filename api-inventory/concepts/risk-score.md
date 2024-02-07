# Risk Score

Akto automatically assigns a risk score to each API and API collection you have. This score is calculated based on the amount of sensitive information the API shares and its current status regarding security issues.

Using the risk score provided by Akto, you can prioritize which API endpoints require additional security measures. Endpoints with higher risk scores may necessitate stricter security controls, such as stronger authentication, rate limiting, or increased monitoring.

In the demonstration below, we have examined the risk score of the API collection-**`juice_shop_demo`** and its underlying endpoints to understand the security implications and potential vulnerabilities. This API collection has a risk score of “3” and its underlying endpoints have risk score values ranging from “0 to 3”.&#x20;

Go to the **API Inventory>API Collection**. Here you can view the risk score of the API Collections. If you want to view the risk score of a specific endpoint within an API collection, simply select the relevant API Collection.

{% embed url="https://demo.arcade.software/Rp9GYKcmjbqbwj8u0oQB?embed=" %}
View Risk Score
{% endembed %}

In the above demonstration, we found that out of 23 API collections, 2 had the highest risk score value of 3. Whereas, in the **juice\_shop\_demo** collection, we identified only 1 endpoint out of 19 API endpoints having the highest risk score value
