---
description: Learn how to send API traffic data from OpenAPI spec to Akto.
---

# Connect Akto with OpenAPI

## Introduction

[Akto](https://www.akto.io/) needs your staging, production or other environment's traffic to Discover APIs and analyze for AP misconfiguration. It does so by connecting to one of your [traffic sources](./). If you don't have access to staging or production environment, you can create API inventory using OpenAPI spec.&#x20;

{% hint style="info" %}
Note that traffic from OpenAPI spec won't be automated like the native cloud connectors.
{% endhint %}

OpenAPI connector is `recommended` for Akto [Open source](https://github.com/akto-api-security/akto) or [free tier](https://www.akto.io/pricing) only. For an automated inventory, you should use other automated traffic connectors.

### Pre-requisites for Akto OpenAPI connection

* You must have an `active Akto account`. If you don't have one, sign up for an account on the Akto platform.
  * [Self Hosted signup](https://stairway.akto.io/)
  * [Cloud Signup](https://app.akto.io/)
* Prepare the OpenAPI specification you wish to upload to Akto. Make sure these collections are organized and contain the API requests you want to work with.

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).