---
description: View meta properties of an API endpoint in Akto.
---

# Meta Properties of API Endpoint

## Authentication Type of Each API

Unauthenticated APIs (also known as public APIs or open APIs) do not require authentication or authorization to access their resources. These APIs are usually designed to provide public information or services that do not require user-specific credentials. These APIs are used for sharing publicly available data with a broad audience.&#x20;

Authenticated APIs, on the other hand, are meant for registered users only. Users typically will have to sign in successfully to get an authentication token. This token serves as the identity of the user to the application.&#x20;

## Access Type

You can easily detect Public APIs in any of your API collections in Akto by selecting the access type as public. This will allow you to view all the endpoints that grant access to external services and functionalities. Once you are aware of the public APIs in your collection, you can understand where your data is going, start monitoring the discovered APIs, and run security tests on top of them.

### What is Public API?

Public APIs refer to the specific API endpoints that are exposed to the public domain. These APIs are typically used by the web dashboard or mobile app or directly via client-SDKs.  These are openly available and accessible over the Internet. For example, a public API endpoint for a weather service might give access to weather data such as current weather, forecasts, or past weather details.

As these APIs are open to everyone, developers can use them to make new apps, improve existing ones, or connect different kinds of computer programs without requiring any special permission or authentication.

### Detect Public API

In the demonstration below, the steps are illustrated to detect public APIs.

Go to the **API Inventory > API Collection**. Select an **API Collection** and check the Access type to **Public**.

{% embed url="https://demo.arcade.software/gw1onqsZpRzx5eCuqwio?embed=" %}
Detect new public API
{% endembed %}
