---
description: View meta properties of an API endpoint in Akto.
---

# Meta Properties of API Endpoint

## Authentication Type of Each API

Akto is designed to automatically detect standard authentication methods like JWT and Bearer authorization headers. This helps in identifying and addressing potential security threats. However, not all APIs follow standard practices. Hence, Akto also supports custom authentication methods.

For example, if your API uses a non-standard authentication method, such as sending the auth token under a non-standard header, Akto provides the flexibility to set this up as a custom auth type. This means you can customize Akto to suit the unique requirements of your API. Even if your authentication method doesn't align with standard practices, Akto can still analyze and secure it properly.&#x20;

## Access Type

Akto provides visibility into your APIs, regardless of whether they're accessed from a public network or internally via microservices. This feature enables you to monitor and ensure that internal APIs aren't exposed to the public network, thus enhancing your security measures.

### What is Public API?

Public APIs refer to the specific API endpoints that are exposed to the public domain. These APIs are typically used by the web dashboard or mobile app or directly via client-SDKs.  These are openly available and accessible over the Internet. For example, a public API endpoint for a weather service might give access to weather data such as current weather, forecasts, or past weather details.

As these APIs are open to everyone, developers can use them to make new apps, improve existing ones, or connect different kinds of computer programs without requiring any special permission or authentication.

### Detect Public API

In the demonstration below, let's check out all the public APIs present in the **`juices-ALBTa-ME7JZNNWLKCF`** collection.

Go to the **API Inventory > API Collection**. Select an **API Collection** and check the Access type to **Public**.

{% embed url="https://demo.arcade.software/gw1onqsZpRzx5eCuqwio?embed=" %}
Detect new public API
{% endembed %}

In the above demonstration, we discovered the presence of 53 public APIs in the **`juices-ALBTa-ME7JZNNWLKCF`** collection and viewed the details of one of the endpoint, which is **`js/{param_STRING}`**

You can also set the sensitivity of a data type, allowing you to choose specific locations where the data type should be treated as sensitive or not. For more, refer to this [link](https://docs.akto.io/api-inventory/how-to/set-sensitivity-of-a-data-type).
