---
description: >-
  Learn about how to send API traffic data using AWS traffic mirroring to Akto
  from your environment.
---

# Connect Akto with AWS Traffic Mirroring

## Introduction

[Akto](https://www.akto.io/) needs your staging, production or other environment's traffic to Discover APIs and analyze for AP misconfiguration. It does so by connecting to one of your [traffic sources](./). One such source is AWS Traffic Mirroring.&#x20;

Traffic Mirroring is an Amazon VPC feature that you can use to copy network traffic from an elastic network interface of type `interface`.&#x20;

{% hint style="info" %}
[Traffic mirroring](https://docs.aws.amazon.com/vpc/latest/mirroring/what-is-traffic-mirroring.html) is non intrusive and allows you to send traffic to Akto in a completely out-of-band manner.
{% endhint %}

Traffic mirroring is our recommended way to receive data as it is completely non-intrusive. Akto's traffic analyzer analyzes this traffic to create your application's APIs request and response, understand API metadata and find misconfigurations. Akto can work with high traffic scale though you can always configure the amount of traffic you want to send to Akto dashboard. &#x20;

## Configuring Traffic Mirroring in Akto Dashboard

To start capturing traffic from your staging, production ( or any other environment), you will need to sign-in to your dashboard and follow the steps below.

1. Navigate to the `Quick Start` page on dashboard.

<figure><img src="../../../.gitbook/assets/Frame 10 (1).png" alt=""><figcaption></figcaption></figure>

2\. Click `connect traffic data`.

<figure><img src="../../../.gitbook/assets/Frame 11 (1).png" alt=""><figcaption></figcaption></figure>

### Creating AWS Policy

Below steps create a policy with AWS permissions in your account that allows Akto to capture API traffic from your selected loadbalancers.

1. Grab the policy JSON from your Akto dashboard in the first step as shown in the screenshot.  `Click` on the link mentioned in `Step 1`.&#x20;

<figure><img src="../../../.gitbook/assets/Frame 15 (4).png" alt=""><figcaption></figcaption></figure>

2\. This will take you to the policy page of AWS. Navigate to `JSON` tab.

<figure><img src="../../../.gitbook/assets/Frame 16 (5).png" alt=""><figcaption></figcaption></figure>

3\. `Copy the policy` from dashboard and `paste` here.

<figure><img src="../../../.gitbook/assets/Frame 17 (12).png" alt=""><figcaption></figcaption></figure>

&#x20;4\. `Click on review policy`.

<figure><img src="../../../.gitbook/assets/Frame 18 (2).png" alt=""><figcaption></figcaption></figure>

5\. Name the policy `AktoDashboardPolicy`.

6\. Click `create policy`. Once policy is created, go back to the dashboard.

<figure><img src="../../../.gitbook/assets/Frame 19 (4).png" alt=""><figcaption></figcaption></figure>

You have now given Akto the permissions to read loadbalancer names from your AWS account.&#x20;

### Selecting loadbalancers to mirror traffic to Akto&#x20;

1. Refresh the dashboard now.
2. You will be able to see a list of all the `loadbalancers`.
3. `Select loadbalancers` under my connections section. Select only those loadbalancers from which you want to mirror the traffic to Akto dashboard.&#x20;

<figure><img src="../../../.gitbook/assets/Frame 12 (1) (1).png" alt=""><figcaption></figcaption></figure>

4\. Click `Apply` to start traffic mirroring.

<figure><img src="../../../.gitbook/assets/Frame 14 (2).png" alt=""><figcaption></figcaption></figure>

5\. `Wait` for a couple of minutes. Mirroring is being setup on the loadbalancers you selected above.

<figure><img src="../../../.gitbook/assets/Screen Shot 2023-01-04 at 3.13 1.png" alt=""><figcaption></figcaption></figure>

6\. Once mirroring is complete, head to the `API inventory page` and see all the APIs Akto has discovered.

{% hint style="info" %}
Akto is [Open Source](https://www.akto.io/blog/introducing-akto-open-source) and if you find any issues or [traffic connectors](https://www.akto.io/connectors) you don't see in the list, you can create an issue in our open source repo [here](https://github.com/akto-api-security/akto).
{% endhint %}

### What's next?

You can now go to your API Inventory to see all the API traffic Akto has captured. Head to [API Inventory](../../../api-inventory/api-inventory/) to learn more. Once you start seeing inventory, you can run API Security tests on your APIs. See [Akto's test library](https://www.akto.io/test-library) to select tests you want to run on your APIs.&#x20;

### Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
