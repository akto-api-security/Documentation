---
description: Learn how to send API traffic data from Postman to Akto.
---

# Connect Akto with Postman

## Introduction

[Akto](https://www.akto.io/) needs your staging, production or other environment's traffic to Discover APIs and analyze for AP misconfiguration. It does so by connecting to one of your [traffic sources](../traffic-data-sources.md). If you don't have access to staging or production environment, you can create API inventory using Postman collection.

{% hint style="info" %}
Note that traffic from Postman won't be automated like the native cloud connectors.
{% endhint %}

## What is Akto postman connector?

Akto gives you ability to add API data through Postman integration. If you have a Postman API collection, follow the steps below to add API data to Akto:

## Pre-requisites

Before integrating Akto with Postman, ensure the following setup requirements are met.

#### 1. You Have an Active Akto Account

You must have an active Akto account. If you do not have one, [sign up on the Akto platform.](https://app.akto.io)

#### 2. You Have Access to Postman

You must have access to Postman in one of the following ways:

* A Postman account (API key access required to fetch collections).
* Postman Desktop App (export the collection file and upload it to Akto).

#### 3. Your API URLs Are Reachable

If your Postman collection does not contain saved response examples:

* Akto will replay the APIs to fetch responses.
* You must ensure the URLs in your collection are reachable from your machine or environment.

If endpoints are not reachable, API replay will fail.

#### 4. Your Collection Is Prepared

Before syncing or uploading:

* You have organised your Postman collections.
* You have included the APIs you want Akto to discover.
* Each request contains complete details (headers, body, query parameters).

#### 5.You Whitelist Akto IPs

You must ensure Akto’s IP addresses are whitelisted in:

* Your WAF (Web Application Firewall) rules
* Your rate limiting rules
* Any IP-based access control lists

## Collection Requirements

To ensure smooth import and accurate API discovery, your collection must meet the following requirements:

### 1. If You Add API Successful Examples (Recommended)

If you add an **API Successful Example** for each API then Akto imports APIs directly using the request and response pairs.

An API Successful Example must include:

* The complete request
* A successful response (e.g., 200, 201)
* Request headers
* Request body (if applicable)

<details>

<summary>How to Add a Successful Example</summary>

Here are the following steps on how you can a successful response example :

#### Steps

1. Open the request in **Postman**.
2. Click **Send** to execute the request.
3. In the response panel, click **Save Response**.
4. Select **Save as Example**.
5. Save the example (ensure status code and response body are correct).

Repeat this for each API where you want to provide a successful response example.

For detailed instructions, refer to the [official Postman documentation](https://learning.postman.com/docs/design-apis/mock-apis/tutorials/mock-with-examples#save-a-response-as-an-example).

</details>

### 2. If You Do NOT Add API Successful Examples (Replay Mode)

If API Successful Examples are not present:

* Akto will replay the APIs defined in your Postman collection.
* Akto captures live request-response pairs.
* These captured pairs populate the API Inventory.

In this case, the following are required for replay to succeed:

{% tabs %}
{% tab title="Authorization (For Authenticated APIs)" %}
* The `Authorization` header must be present.
* The token must be valid and active.
* The format must follow standard conventions (e.g., Bearer token)
{% endtab %}

{% tab title="Host Header" %}
* The `Host` header must be present in each request.
* This ensures proper service identification and routing.
{% endtab %}
{% endtabs %}

{% hint style="warning" %}
## Common Import Errors

You may see the following errors on the Akto dashboard:

* **Unresolved variables**
* **No response found**
* **Unknown auth mechanism**

To prevent these:

* Define all variables in the collection file.
* Add at least one successful response example per API.
* Ensure the Host header is present in each request.
* Ensure Authorisation headers are correctly configured for authenticated APIs.
{% endhint %}

### Variables Definition References

If your requests use variables (e.g., `{{baseUrl}}`, `{{authToken}}`):

* All variables must be defined in the collection.
* Variables must resolve successfully during import.

Refer to [#variables-in-postman-collection-file](postman.md#variables-in-postman-collection-file "mention") for reference.

{% hint style="success" %}
## Recommendation

To avoid replay dependency and configuration complexity:

* Add an API Successful Example for each API.
* Ensure variables are properly defined.

If API Successful Examples are present, replay-related configuration is not required.
{% endhint %}

## Integrating Postman

In the demonstration below, we have first bridged the connection between our Akto account and Postman account before we can start populating the API traffic in our API inventory. This integration involves entering the **`Postman API key`** in the relevant field while also selecting the **`Postman workspace`** we wish to import.

{% embed url="https://demo.arcade.software/VJ0dXwP5l3dqjUMulHWX?embed=" %}

After connecting your Postman Account to Akto, you will be provided with the following two options to import the API Traffic data from Postman:

* Using Postman API Key
* Using Postman Collection File

### 1. Using Postman API Key

In the demonstration below, we have generated our **`Postman API key`** and pasted the value in the configuration setup to fetch and select the Postman workspace (containing API traffic) to import to Akto.

{% embed url="https://demo.arcade.software/ElYfx4hSzNHRmcaJgIZq?embed=" %}
Import using Postman API key
{% endembed %}

### 2. Using Postman Collection File

In the demonstration below, we have imported the API traffic data to our Akto account from one of our workspaces in Postman. By simply exporting the API collection from our Postman workspace, we have uploaded the same **`JSON file`** to Akto and populated the API traffic in the inventory.

{% embed url="https://demo.arcade.software/88Gx1Vbyaboau35nLD5y?embed=" %}
Import Postman collection file
{% endembed %}

## Variables in Postman Collection File

Akto supports Postman **collection-level variables** in your exported collection JSON file. Variables help you parameterise parts of your API requests (such as URLs, headers, auth values, and request bodies) using the `{{variableName}}` syntax. Akto will replace these variables with the values defined in the collection before resolving requests during import or replay.

{% hint style="success" %}
## Why Proper Variable Definition Matters

If any variable used in the collection is not defined:

* Akto may show **unresolved variables** errors on the dashboard.
* API requests that depend on those variables may break or fail during replay.
* Replay may substitute undefined variables as blank, leading to incorrect URLs or headers.
{% endhint %}

#### How Variables Work

* Variables should be defined in the `variable` array at the root of the Postman collection JSON.
* Each variable must have a `key` and a `value`.
* Variables can be used in URLs, headers, body data, and authentication fields.

Example of a collection variables block:

```json
"variable": [
  {
    "key": "baseUrl",
    "value": "https://api.example.com"
  },
  {
    "key": "apiKey",
    "value": "my-secret-key"
  }
]
```

You can then use these variables in your API request definitions like:

```json
{{baseUrl}}/api/v1/users
```

{% hint style="info" %}
## Note

Before exporting your collection for Akto:

* Ensure all variable references (`{{…}}`) in your collection are defined in the `variable` section.
* If you are using environment variables in Postman, copy those values into the collection’s variable array before export.
{% endhint %}

When Akto imports your collection, it will substitute these values automatically.

For more details on how variables work in Postman and how to define them across scopes, see the [official Postman documentation](https://learning.postman.com/docs/sending-requests/variables/variables).

## What's next?

Once you start seeing inventory, you can run API Security tests on your APIs. See [Akto's test library](https://www.akto.io/test-library) to select tests you want to run on your APIs.

## Frequently Asked Questions (FAQs)

**1. How can I find my Postman API key for integration with Akto?**

To find your Postman API key:

Open Postman. Click on your Profile in the top-right corner. From the drop-down menu, select Settings and then API Keys. Generate a new API key or copy an existing one.

**2. What security measures are in place to protect my Postman API key and collections when using the Akto integration?**

Akto takes data security seriously. Your Postman API key is securely stored, and Akto uses encryption and other security practices to protect your data during the integration process. It's important to keep your API key confidential and not share it with unauthorized parties.

**3. What is the benefit of syncing Postman workspaces with Akto?**

Syncing Postman workspaces with Akto allows you to leverage Akto's features for API testing, monitoring, and analytics on your Postman collections. It provides a centralized platform for managing and analyzing your API-related activities.

**4. Are there any limitations on the size of Postman collections that can be uploaded to Akto?**

While there may not be a specific file size limitation for uploading Postman collections to Akto, it's important to consider the practicality and performance of working with very large collections. Extremely large collections may take longer to upload and process, so it's advisable to break them into smaller, manageable parts if necessary.

**5. What happens if I tick the "Allow Akto to replay API requests if responses are not found" checkbox in Akto?**

If this checkbox is ticked, Akto will attempt to replay APIs to generate responses when they are missing in the Postman collection. However, if the APIs are inaccessible or return non-2xx response codes, they may fail to be imported to Akto.

**6. Is there a difference in using the Akto integration with the Postman Desktop App (installed locally) compared to the Postman SaaS App?**

Yes, there is a difference in how the two versions of Postman integrate with Akto:

Postman Desktop (Installed Locally): Users of the Postman desktop app, installed locally on their machines, have the option to upload collections manually to Akto. They export their Postman collections as files and then manually upload these files to Akto. Desktop users do not have access to API keys for integration.

Postman SaaS (Online): Users of the Postman SaaS version have more versatile integration options. They can choose to use API keys for seamless integration. This involves generating an API key from their Postman SaaS account and providing it during the Akto integration setup. Alternatively, they can manually download the Postman collection and upload it to Akto.

## Troubleshooting Guide

**1. After following the steps, I see new collections in Akto, but they have fewer endpoints than the original Postman file. What could be the issue?**

Akto processes APIs within the Postman collection based on whether they have saved responses or return 2xx status codes. Here's a detailed explanation:

Saved Responses: Akto primarily looks for saved responses within your Postman collection. To ensure comprehensive coverage, it's a best practice to hit all APIs from within Postman itself and save the responses. When Akto detects saved responses, it includes these in the Akto collection.

Handling Missing Responses: If Akto does not find saved responses for certain APIs, it attempts to send requests to those APIs one-by-one (substituting variables if any). However, it's important to note that only APIs returning a 2xx status code (indicating a successful response) during this process get processed and included in the Akto collection.

In summary, Akto relies on saved responses and successful API responses (2xx status codes) to populate the Akto collection. Ensuring that all APIs have saved responses in Postman is recommended for complete integration with Akto.

**2. I enabled the "Allow replay" checkbox, but I still don't see any APIs in Akto. What could be the issue?**

To resolve this issue, please consider the following steps:

Ensure that the server is accessible from your Akto instance. If the server is not reachable, Akto won't be able to replay the API requests and generate responses. Check your network settings and firewall configurations if needed.

Verify that the Postman collection includes valid authentication tokens or credentials if required. A successful API request depends on having the appropriate authentication in place. If the API requests in the collection lack valid credentials, they may not succeed, even with the "Allow replay" option enabled.

**3. What happens if the upload of my Postman collection to Akto fails?**

If the upload of your Postman collection to Akto fails:

1. Ensure that the collection file is in the correct format (Collection v2.1).
2. The file isn't bigger than 25mb

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `support@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
