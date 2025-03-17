---
description: Learn how to uplaod API traffic data from HAR file to Akto
---

# Add API traffic to Akto using HAR file upload

## Introduction

[Akto](https://www.akto.io/) needs your staging, production or other environment's traffic to Discover APIs and analyze for API misconfiguration. It does so by connecting to one of your [traffic sources](../traffic-data-sources.md). If you don't have access to staging or production environment, you can create API inventory using HAR file upload.

{% hint style="info" %}
Note that traffic from HAR File upload won't be automated like the native cloud connectors.
{% endhint %}

HAR File Upload is `recommended` for Akto [Open source](https://github.com/akto-api-security/akto) or [free tier](https://www.akto.io/pricing) only. For an automated inventory, you will want to use other automated traffic connectors.

#### What is HAR file?

The HTTP Archive format, or HAR, is a `JSON-formatted archive file format` for logging of a web browser's interaction with a site. The common extension for these files is `.har`. You can use this method if you quickly want to try out Akto. Akto can process HAR (Http Archive) files and populate inventory from them.

## Pre-requisites to add HAR file data to Akto

* You should have an active [Akto](https://app.akto.io/) account.
* Make sure you have HAR files generated from Chrome or Firefox available for upload. The maximum file size for upload is 25 MB.

## Steps to capture traffic in a HAR File

Launch your Chrome browser and navigate to the web page for which you want to capture the traffic. For demonstration purposes, we will capture the traffic from [https://juiceshop.akto.io](https://juiceshop.akto.io)

{% @arcade/embed flowId="0rereawiRT0wuVKtM9wS" url="https://app.arcade.software/share/0rereawiRT0wuVKtM9wS" %}

## Steps to upload HAR file in Akto dashboard

Add the generated HAR file to your API collection by following the steps demonstrated below.

{% @arcade/embed flowId="tErOE27G2Zw8UI8DLqlD" url="https://app.arcade.software/share/tErOE27G2Zw8UI8DLqlD" %}

### What's next?

Head to [API Discovery](../../api-inventory-1/concepts/api-collection.md) to learn more. Once you start seeing inventory, you can run API Security tests on your APIs. See [Akto's test library](https://www.akto.io/test-library) to select tests you want to run on your APIs.

## Frequently Asked Questions (FAQs)

**1. What is the limit on the size of HAR file upload?**

The maximum size you can upload to Akto is 25 mb.

**2. What is a HAR file, and how can I generate one in Chrome or Firefox?**

HAR stands for HTTP Archive, and it is a format used to capture and store network traffic data during a web browser session. To generate a HAR file in Chrome or Firefox:

_Steps for Chrome:_

Step 1: Open Chrome

Step 2: Right-click on the page and select "Inspect" to open Developer Tools.

Step 3: Go to the "Network" tab. Perform the actions or interactions you want to capture (e.g., load a webpage).

Step 4: Right-click on the network activity list and choose "Save as HAR with Content."

_Steps for Firefox:_

Step 1: Open Firefox.

Step 2: Click on the `menu` icon (three horizontal lines) and select `Web Developer > Network`

Step 3: Perform the actions you want to capture.

Step 4: Click the `Export` button to save the captured data as a HAR file.

## Troubleshooting Guide

**I uploaded 100 APIs, but I can only see 85 of them in the dashboard. Where are the missing APIs?**

Akto processes and displays only APIs that have received a 2xx series status code in their HTTP responses. If an API request did not receive a 2xx status code (e.g., 3xx, 4xx, or 5xx), it may not appear in the dashboard.

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
