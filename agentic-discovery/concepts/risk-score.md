# Risk Score

## What is Risk score?

Risk score is calculated based on the amount of sensitive information the API shares and its current status regarding security issues. Akto automatically assigns a risk score to each API and API collection you have.

Using the risk score provided by Akto, you can prioritize which API endpoints require additional security measures. Endpoints with higher risk scores may necessitate stricter security controls, such as stronger authentication, rate limiting, or increased monitoring.

### How We Calculate Risk?

Your API's risk score is the sum of these four factors (capped at 5):

#### 1. Security Issue Severity

Based on the highest severity issue found:

* High severity issues: 2 points
* Medium severity issues: 1 point
* Low severity issues: 0.5 points
* No issues: 0 points

#### 2. Recent Discovery

Time-based scoring:

* Discovered in the last 30 days: +1 point
* Older discoveries: 0 points

#### 3. Sensitive Data Exposure

Response data analysis:

* Contains sensitive data: +1 point
* No sensitive data: 0 points

#### 4. Public Accessibility

API exposure level:

* Publicly accessible: +1 point
* Internal/private: 0 points

### Example

An API endpoint could score 5 points if it:

* Has a high-severity issue (2 points)
* Was discovered last week (+1 point)
* Contains sensitive data (+1 point)
* Is publicly accessible (+1 point)

## Risk scores on Akto dashboard

In the demonstration below, we have examined the risk score of the API collection-**`juice_shop_demo`** and its underlying endpoints to understand the security implications and potential vulnerabilities. This API collection has a risk score of “3” and its underlying endpoints have risk score values ranging from “0 to 3”.

Go to the **API Discovery > API Collection**. Here you can view the risk score of the API Collections. If you want to view the risk score of a specific endpoint within an API collection, simply select the relevant API Collection.

{% embed url="https://demo.arcade.software/Rp9GYKcmjbqbwj8u0oQB?embed=" %}
View Risk Score
{% endembed %}

In the above demonstration, we found that out of 23 API collections, 2 had the highest risk score value of 3. Whereas, in the **juice\_shop\_demo** collection, we identified only 1 endpoint out of 19 API endpoints having the highest risk score value
