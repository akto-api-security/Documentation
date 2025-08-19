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

### Pre-requisites for Akto Postman connection

* You must have an `active Akto account`. If you don't have one, sign up for an account on the Akto platform.
  * [Cloud Signup](https://app.akto.io/)
* Ensure you have a Postman account or have a Postman desktop app. If you have a Postman account, the integration requires access to your Postman collections through an API key. If you are using Postman desktop app, then you will have to export Postman collection to a file that you can upload to Akto.
* `Connectivity to your URLs:` If samples responses are not saved in your Postman collection, Akto might need to hit those URLs for sample responses. Please ensure the URLs in your Postman collection are reachable from your machine.
* Prepare the Postman collections you wish to sync or upload to Akto. Make sure these collections are organized and contain the API requests you want to work with.

## Integrating Postman

In the demonstration below, we have first bridged the connection between our Akto account and Postman account before we can start populating the API traffic in our API inventory. This integration involves entering the **`Postman API key`** in the relevant field while also selecting the **`Postman workspace`** we wish to import.

{% embed url="https://demo.arcade.software/VJ0dXwP5l3dqjUMulHWX?embed=" %}

After connecting your Postman Account to Akto, you will be provided with the following two options to import the API Traffic data from Postman:

* Using Postman API Key
* Using Postman Collection File

## Using Postman API Key

In the demonstration below, we have generated our **`Postman API key`** and pasted the value in the configuration setup to fetch and select the Postman workspace (containing API traffic) to import to Akto.

{% embed url="https://demo.arcade.software/ElYfx4hSzNHRmcaJgIZq?embed=" %}
Import using Postman API key
{% endembed %}

## Using Postman Collection File

In the demonstration below, we have imported the API traffic data to our Akto account from one of our workspaces in Postman. By simply exporting the API collection from our Postman workspace, we have uploaded the same **`JSON file`** to Akto and populated the API traffic in the inventory.

{% embed url="https://demo.arcade.software/88Gx1Vbyaboau35nLD5y?embed=" %}
Import Postman collection file
{% endembed %}

### What's next?

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
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
