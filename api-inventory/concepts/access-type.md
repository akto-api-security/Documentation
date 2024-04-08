---
description: Access types can be public, internal or partner.
---

# Access Type

## Access Type

Akto provides visibility into your APIs, regardless of whether they're accessed from a public network or internally via microservices. This feature enables you to monitor and ensure that internal APIs aren't exposed to the public network, thus enhancing your security measures.

Learn [here](../how-to/configure-access-types.md) how to configure Access Type CIDRs.&#x20;

### Possible Access Types

1. [Public](access-type.md#what-is-public-api)
2. [Internal](access-type.md#what-is-internal-api)
3. [Partner](access-type.md#what-is-partner-api)
4. None

### How it works?

Akto uses `X-Forwarded-For` header to understand the list of IPs through which API call was routed. The evaluation rules are in the following order -&#x20;

1. If any 1 IP is present which is not in `Private` or `Partner` IP list, it is marked as `Public`.&#x20;
2. If any 1 IP in the header is from `Partner` and rest of the IPs are in `Private` list, it is marked as `Partner`
3. If all IPs are in `Private` IPs list, then API is marked as `Private`
4. If header is absent, then we mark it as `None`

### What is Public API?

Public APIs refer to the specific API endpoints that are exposed to the public network. These APIs are typically used by the web dashboard or mobile app or directly via client-SDKs.  These are openly available and accessible over the Internet. For example, a public API endpoint for a weather service might give access to weather data such as current weather, forecasts, or past weather details. Login APIs for Netflix are "public" APIs, because they can be hit from a public domain.&#x20;

### What is Internal API?

Internal APIs refer to the specific API endpoints that are used strictly internal and are NOT exposed to public network. These APIs are typically used by the other microservices and internal tools. For example, a `/api/v1/send-welcome-email` API endpoint to send email notification for new users. This API is used by another microservice (`register.company.io`) to send a welcome message to new users. Many times, specifically `/health` endpoints are **internal** because they are accessed only internally.&#x20;

### What is Partner API?

Partner APIs refer to the specific API endpoints that can be used by IPs outside your VPC, but the access is limited to a small set of IPs. For example, a bank might open some of its APIs to **VISA** and **MasterCard** APIs only. Companies might setup VPC peering or whitelist only the NAT gateway of the Partners.&#x20;



### Detect Access Types

In the demonstration below, let's check out all the public APIs present in the **`juices-ALBTa-ME7JZNNWLKCF`** collection.

Go to the **API Inventory > API Collection**. Select an **API Collection** and check the Access type to **Public**.

{% embed url="https://demo.arcade.software/gw1onqsZpRzx5eCuqwio?embed=" %}
Detect new public API
{% endembed %}

In the above demonstration, we discovered the presence of 53 public APIs in the **`juices-ALBTa-ME7JZNNWLKCF`** collection and viewed the details of one of the endpoint, which is **`js/{param_STRING}`**
