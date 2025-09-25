---
description: Explore the sensitive data and its parameters.
---

# Sensitive Data

Akto comes with over 100+ built-in data types and some of them belong to the sensitive data types category, for example, Email, Phone Number, JWT, Bearer token, etc. Akto allows you to identify which sensitive data an API is sharing. This is particularly useful in managing and securing your APIs

## Examples of Sensitive Data

* Email 📧
* Phone Number ☎️
* Credit Card number 💳
* IP Address 🔢
* SSN 🆔
* URL 🌐
* PAN Card 💵
* JWT, Bearer token 🔑

## Detect Sensitive Data

In the demonstration below, let's identify all the endpoints of the **"Juice\_shop\_demo"** collection that share sensitive data.

Go to **API Discovery> API Collection**. Select any API Collection and click on the **Sensitive** tab to populate all the sensitive endpoints within that collection. You can also filter the sensitive endpoints based on specific or multiple sensitive params like Email.

{% embed url="https://demo.arcade.software/pPBmsI7APjiKlXElCukg?embed=" %}
Detect sensitive parameters
{% endembed %}

In the above demonstration, we identified 6 endpoints that share sensitive data like **Email** and **JWT** tokens.

You can also click on any of the identified sensitive endpoints to view the sensitive parameters it contains. In the demonstration below, we clicked on one of the sensitive **EMAIL** endpoints to view its sensitive parameters in both the **Request** and **Response**.

{% embed url="https://demo.arcade.software/fJSTlSm12iOt67lQk8A2?embed=" %}
Detect Sensitive Params
{% endembed %}

In the above demonstration, we found that the endpoint has sensitive data like **EMAIL ID, Password,** and **Authentication token**.

You can also set the sensitivity of a data type, allowing you to choose specific locations where the data type should be treated as sensitive or not. For more, refer to this [link](https://docs.akto.io/api-inventory/how-to/set-sensitivity-of-a-data-type).
