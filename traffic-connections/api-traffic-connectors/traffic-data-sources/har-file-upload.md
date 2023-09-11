---
description: Learn how to uplaod API traffic data from HAR file to Akto
---

# Add API traffic to Akto using HAR file upload

## Introduction

[Akto](https://www.akto.io/) needs your staging, production or other environment's traffic to Discover APIs and analyze for AP misconfiguration. It does so by connecting to one of your [traffic sources](./). If you don't have access to staging or production environment, you can create API inventory using HAR file upload.&#x20;

{% hint style="info" %}
Note that traffic from HAR File upload won't be automated like the native cloud connectors.
{% endhint %}

HAR File Upload is `recommended` for Akto [Open source](https://github.com/akto-api-security/akto) or [free tier](https://www.akto.io/pricing) only. For an automated inventory, you will want to use other automated traffic connectors.

#### What is HAR file?

The HTTP Archive format, or HAR, is a `JSON-formatted archive file format` for logging of a web browser's interaction with a site. The common extension for these files is `.har`. You can use this method if you quickly want to try out Akto. Akto can process HAR (Http Archive) files and populate inventory from them.

## Pre-requisites to add HAR file data to Akto

* You should have an active Akto account.
* Make sure you have HAR files generated from Chrome or Firefox available for upload. The maximum file size for upload is 25 MB.

## Steps to capture traffic in a .har file to upload in Akto

1. Go to any website or application that you want to use to Discover APIs or test . Let's use https://juiceshop.akto.io for a demo.
2. Open the developer tools in Chrome and switch to the network tab.
3.  Browse the website or your application to generate traffic, then right-click anywhere in the network and click on `save as har with content.`

    <figure><img src="../../../.gitbook/assets/juiceshop.png" alt=""><figcaption></figcaption></figure>

## Steps to upload HAR file in Akto dashboard

1. Create a new collection in API Inventory screen.
2. Name the collection.
3. Open the newly created API Collection.
4. Click on the **Upload Har file** button on the top right![upload\_icon](https://user-images.githubusercontent.com/91221068/230879293-c4042fe0-5cc2-4072-ac1b-765905255579.png)&#x20;

<figure><img src="https://user-images.githubusercontent.com/91221068/230879325-93d93bf8-715a-4ea0-a8a7-207a554c5f6e.png" alt=""><figcaption><p>Har file upload in Akto</p></figcaption></figure>

5. Select the HAR file from the file browser.&#x20;

<figure><img src="https://user-images.githubusercontent.com/91221068/230879518-4d92d2f3-ab17-40d1-9db7-445087792cc8.png" alt=""><figcaption><p>Select downloaded HAR</p></figcaption></figure>

6. Click on the `Refresh` icon on the top right.&#x20;

<figure><img src="https://user-images.githubusercontent.com/91221068/230879588-261e9813-625b-4855-995c-4c78035a8909.png" alt=""><figcaption><p>Click Refresh</p></figcaption></figure>

7. You should be able to see APIs imported in your collection from the HAR file.&#x20;

<figure><img src="https://user-images.githubusercontent.com/91221068/230879681-9f4c849f-990d-4cec-8786-f216b0529135.png" alt=""><figcaption><p>APIs from HAR file</p></figcaption></figure>

## Frequently Asked Questions (FAQs)

**1. What is the limit on the size of HAR file upload?**

The maximum size you can upload to Akto is 25 mb.

**2. What is a HAR file, and how can I generate one in Chrome or Firefox?**

HAR stands for HTTP Archive, and it is a format used to capture and store network traffic data during a web browser session. To generate a HAR file in Chrome or Firefox:

Steps for Chrome:&#x20;

Step 1: Open Chrome

Step2: Right-click on the page and select "Inspect" to open Developer Tools.&#x20;

Step 3: Go to the "Network" tab. Perform the actions or interactions you want to capture (e.g., load a webpage).&#x20;

Step 4: Right-click on the network activity list and choose "Save as HAR with Content."&#x20;

Steps for Firefox:&#x20;

Step 1: Open Firefox.&#x20;

Step 2: Click on the `menu` icon (three horizontal lines) and select `Web Developer > Network`&#x20;

Step 3: Perform the actions you want to capture.&#x20;

Step 4: Click the `Export` button to save the captured data as a HAR file.
