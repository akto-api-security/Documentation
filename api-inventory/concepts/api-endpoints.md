---
description: View all API endpoints across all of your services in Akto.
---

# API Endpoints

## What is an API Endpoint?

API endpoints are specific URLs or addresses within an API that serve as access points for different functionalities or resources. They define where and how data or actions can be requested or performed within the API, typically using HTTP methods like GET, POST, PUT, or DELETE.

## View an Endpoint

Akto automatically updates your API inventory whenever new APIs are detected and allows you to view the endpoints. By viewing endpoints, you get a detailed overview of the API's capabilities.

This includes details of **`header & response`** data and **`payloads`**, which shows how data is structured when interacting with the API. You can also identify any sensitive parameters that the endpoint has, such as passwords or personal identification numbers, ensuring that they are handled securely.

In the demonstration below, we are viewing the details of the **`api/quantity/`** endpoint within the **“New Burp”** collection.

Go to the **API Inventory > API Collection.** Select the **"New Burp"** collection, and click on **`api/quantity/`** Endpoint to view its details.

{% embed url="https://demo.arcade.software/boBiQNlJHTbRmmfE6nZR?embed=" %}
View an Endpoint
{% endembed %}

In the above demonstration, we observed that there are 14 request headers and 9 response headers which gives us a deep understanding of the interaction between the client and the server. By viewing the sample values of these headers, we see how data changes during API calls.
