---
description: Explore the details of API collection and more.
---

# API Collection

Akto automatically groups similar APIs into meaningful collections based on their subdomain names. However, you can sort and also create your own custom API collection if you want.

For example, if you want all your payment APIs to be part of a separate collection, you can create a new collection named "Payment APIs" and then add all APIs that start with "/payments" to this newly created collection.

You can also [set environment type](../../api-inventory/how-to/set-tags.md) for an API collection as **Staging** or **Production.**

## View API Collection

In the demonstration below, let's check out and view details for the API collection viz.- **New Burp**.

Go to the **API Discovery > API Collection** and click on any **API Collection** to view its Endpoints (**New Burp** in this case).

{% embed url="https://demo.arcade.software/O0Ye3U1iQE7ZAagqYpAw?embed=" %}
View an API collection
{% endembed %}

In the above demonstration, you can see all 32 endpoints in the collection. Click on any endpoint to view more details about it.

## Sort API Collection

In the demonstration below, we have sorted the API collections using two parameters viz.- **"More”** and **“Endpoints"**. Using these two parameters together makes it easy to access API collections having more endpoints

Go to **API Discovery > API Collection**. Click on the **Sort** icon to sort the API Collections.

{% embed url="https://demo.arcade.software/7kVYpBGCOmijEIZoQ0Qu?embed=" %}
Sort an API collection
{% endembed %}

In the above demonstration, we have sorted the API collection according to the **"More”** and **“Endpoints"** parameters. All the API collections are now ordered by the number of endpoints they contain.

## Search or Filter Collection

The following table describes all available search and filter options for API inventory records.

<table><thead><tr><th width="187.46875">Filter Name</th><th width="178.08203125">Available Values</th><th>Description</th></tr></thead><tbody><tr><td><strong>Risk Score</strong></td><td><code>0</code>, <code>1</code>, <code>2</code></td><td>Filters APIs based on calculated security risk. A higher value indicates higher risk.</td></tr><tr><td><strong>Access Type</strong></td><td><code>Public</code>, <code>Private</code></td><td>Filters APIs based on network exposure. Public APIs are internet-accessible, while private APIs are internally restricted.</td></tr><tr><td><strong>Authentication Type</strong></td><td><code>Basic</code>, <code>Bearer</code></td><td>Filters APIs based on the authentication mechanism used by the endpoint.</td></tr><tr><td><strong>HTTP Method</strong></td><td><code>GET</code>, <code>POST</code>, <code>PUT</code>, <code>DELETE</code></td><td>Filters APIs by supported HTTP operations, helping distinguish read and write behaviors.</td></tr><tr><td><strong>Response Code</strong></td><td><code>200</code>, <code>201</code>, <code>204</code></td><td>Filters APIs based on observed successful HTTP response codes.</td></tr><tr><td><strong>Last Tested</strong></td><td>Timestamp range</td><td>Filters APIs based on the most recent security test execution time.</td></tr><tr><td><strong>Last Seen</strong></td><td>Timestamp range</td><td>Filters APIs based on the most recent traffic observation time.</td></tr><tr><td><strong>Discovered Timestamp</strong></td><td>Timestamp range</td><td>Filters APIs based on when Akto first discovered the endpoint.</td></tr></tbody></table>

<figure><img src="../../.gitbook/assets/Feb 9 Screenshot from CloudConvert.webp" alt="" width="563"><figcaption></figcaption></figure>

{% hint style="info" %}
#### Include and Exclude Filtering Behaviour

Each filter supports **include** and **exclude** modes.

* Include mode restricts results to matching APIs.&#x20;
*   Exclude mode removes matching APIs from the result set.&#x20;

    <figure><img src="../../.gitbook/assets/image (175).png" alt="" width="333"><figcaption></figcaption></figure>

The approach helps you precisely scope API discovery without modifying underlying API inventories.
{% endhint %}

You can also delete an API collection. This is useful when you need to delete old or unused collections, for testing, development, or compliance purposes. For more, refer to this [link](https://docs.akto.io/api-inventory/how-to/delete-an-api-collection).
