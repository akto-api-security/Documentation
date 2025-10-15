---
description: View meta properties of an API endpoint in Akto.
---

# Meta Properties of API Endpoint

## Auth Type

Akto is designed to automatically detect standard authentication methods like JWT and Bearer authorization headers. This helps in identifying and addressing potential security threats. However, not all APIs follow standard practices. Hence, Akto also supports custom authentication methods. [Read more here](auth-types.md).

For example, if your API uses a non-standard authentication method, such as sending the auth token under a non-standard header, Akto provides the flexibility to set this up as a custom auth type. This means you can customize Akto to suit the unique requirements of your API. Even if your authentication method doesn't align with standard practices, Akto can still analyze and secure it properly.&#x20;

## Access Type

Akto provides visibility into your APIs, regardless of whether they're accessed from a public network or internally via microservices. This feature enables you to monitor and ensure that internal APIs aren't exposed to the public network, thus enhancing your security measures. [Read more here](access-type.md).

#### Real time updates

For any new API, along with the path and schema, Akto will update meta properties such Auth type, Access Type and Sensitive Data exchanged by that API in real time.&#x20;

These properties are updated in real time for each API call processed by Akto. These meta properties (along with sensitive data exposure) are updated in real time with each API call.&#x20;

For example, say, an API initially was initially marked as "Private". When Akto sees even 1 call for that API coming from Public domain, Akto will mark the Access Type as "Public". \
Similarly if Akto converts an Auth type from "authenticated" to "unauthenticated" when Akto processes a successful call for that API without any auth type. Akto will keep adding more auth types in real time as it processes calls for that same API.&#x20;
