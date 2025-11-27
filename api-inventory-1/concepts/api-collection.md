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

You can also delete an API collection. This is useful when you need to delete old or unused collections, for testing, development, or compliance purposes. For more, refer to this [link](https://docs.akto.io/api-inventory/how-to/delete-an-api-collection).
