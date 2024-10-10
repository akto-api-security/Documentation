---
description: >-
  Learn how to send API traffic data using AWS traffic mirroring to Akto from
  your environment.
---

# Connect Akto with AWS Traffic Mirroring

## Introduction

[Akto](https://www.akto.io/) needs your staging, production or other environment's traffic to Discover APIs and analyze for AP misconfiguration. It does so by connecting to one of your [traffic sources](./). One such source is AWS Traffic Mirroring.&#x20;

Traffic Mirroring is an Amazon VPC feature that you can use to copy network traffic from an elastic network interface of type `interface`.&#x20;

{% hint style="info" %}
[Traffic mirroring](https://docs.aws.amazon.com/vpc/latest/mirroring/what-is-traffic-mirroring.html) is non intrusive and allows you to send traffic to Akto in a completely out-of-band manner.
{% endhint %}

Traffic mirroring is our recommended way to receive data as it is completely non-intrusive. Akto's traffic analyzer analyzes this traffic to create your application's APIs request and response, understand API metadata and find misconfigurations. Akto can work with high traffic scale though you can always configure the amount of traffic you want to send to Akto dashboard. &#x20;

## Pre-requisites to add data to Akto AWS using Traffic Mirroring

1. You should have installed Akto dashboard in the same VPC as your application server EC2 instances
2. You have permissions to create and assign roles to InstanceProfiles
3. Your application should be receiving unencrypted traffic. SSL, if any, should be terminated before it reaches your application server EC2 instance. Usually, SSL termination happens at API Gateway or Load balancer.
4. Not all AWS Instances support traffic mirroring. If you have any of [these instance types](https://docs.aws.amazon.com/vpc/latest/mirroring/traffic-mirroring-limits.html#traffic-mirroring-limitations), we suggest you go with a different AWS traffic connector.

## Configuring Traffic Mirroring in Akto Dashboard

To start capturing traffic from your staging, production ( or any other environment), you will need to sign-in to your dashboard and follow the steps below.

1. Navigate to the `Quick Start` page on dashboard.

<figure><img src="../../.gitbook/assets/Frame 10 (1).png" alt="Click on Quickstart"><figcaption><p>Click on Quickstart</p></figcaption></figure>

2\. Click `connect traffic data`.

<figure><img src="../../.gitbook/assets/Frame 11 (1).png" alt="Click on connect traffic data"><figcaption><p>Click on connect traffic data</p></figcaption></figure>

### Creating AWS Policy

Below steps create a policy with AWS permissions in your account that allows Akto to capture API traffic from your selected loadbalancers.

1. Grab the policy JSON from your Akto dashboard in the first step as shown in the screenshot.  `Click` on the link mentioned in `Step 1`.&#x20;

<figure><img src="../../.gitbook/assets/Frame 15 (4).png" alt="Click on AWS policy link "><figcaption><p>Click on AWS policy link </p></figcaption></figure>

2\. This will take you to the policy page of AWS. Navigate to `JSON` tab.

<figure><img src="../../.gitbook/assets/Frame 16 (5).png" alt="Policy page of AWS"><figcaption><p>Policy page of AWS</p></figcaption></figure>

3\. `Copy the policy` from dashboard and `paste` here.

<figure><img src="../../.gitbook/assets/Frame 17 (12).png" alt="Copy policy JSON"><figcaption><p>Copy policy JSON</p></figcaption></figure>

&#x20;4\. `Click on review policy`.

<figure><img src="../../.gitbook/assets/Frame 18 (2).png" alt="Paste in AWS"><figcaption><p>Paste in AWS</p></figcaption></figure>

5\. Name the policy `AktoDashboardPolicy`.

6\. Click `create policy`. Once policy is created, go back to the dashboard.

<figure><img src="../../.gitbook/assets/Frame 19 (4).png" alt="Policy created in AWS"><figcaption><p>Policy created in AWS</p></figcaption></figure>

You have now given Akto the permissions to read loadbalancer names from your AWS account.&#x20;

### Selecting loadbalancers to mirror traffic to Akto&#x20;

1. Refresh the dashboard now.
2. You will be able to see a list of all the `loadbalancers`.
3. `Select loadbalancers` under my connections section. Select only those loadbalancers from which you want to mirror the traffic to Akto dashboard.&#x20;

<figure><img src="../../.gitbook/assets/Frame 12 (1) (1).png" alt="Select Loadbalancer in Akto"><figcaption><p>Select Loadbalancer in Akto</p></figcaption></figure>

4\. Click `Apply` to start traffic mirroring.

<figure><img src="../../.gitbook/assets/Frame 14 (2).png" alt="Click apply"><figcaption><p>Click apply</p></figcaption></figure>

5\. `Wait` for a couple of minutes. Mirroring is being setup on the loadbalancers you selected above.

<figure><img src="../../.gitbook/assets/Screen Shot 2023-01-04 at 3.13 1.png" alt="Wait for a few mins"><figcaption><p>Wait for a few mins</p></figcaption></figure>

6\. Once mirroring is complete, head to the `API discovery page` and see all the APIs Akto has discovered.

{% hint style="info" %}
Akto is [Open Source](https://www.akto.io/blog/introducing-akto-open-source) and if you find any issues or [traffic connectors](https://www.akto.io/connectors) you don't see in the list, you can create an issue in our open source repo [here](https://github.com/akto-api-security/akto).
{% endhint %}

### What's next?

You can now go to your API Inventory to see all the API traffic Akto has captured. Head to [API Discovery](../../api-inventory/concepts/api-collection.md) to learn more. Once you start seeing inventory, you can run API Security tests on your APIs. See [Akto's test library](https://www.akto.io/test-library) to select tests you want to run on your APIs.&#x20;

## Frequently Asked Questions (FAQs)

**The mirrored traffic will contain a lot of sensitive data - does it leave my VPC?**

Mirrored data remains strictly within your VPC. You can verify it by looking at VPC > Traffic mirror Targets. The NLB there & its listeners are all within your VPC. Akto doesn't take data out of your VPC at all.

**Does Traffic mirroring have any impact on performance, latency or network bandwidth?**

AWS Traffic mirroring is guaranteed to have 0 impact on performance and latency. It will definitely double your instance bandwidth usage. In case of bandwidth congestion, AWS will always prioritize your production traffic. You can read more about it [here from AWS documentation](https://docs.aws.amazon.com/vpc/latest/mirroring/traffic-mirroring-limits.html#traffic-mirroring-bandwidth).

**My traffic volume is of the order of TBs/hour. How much will traffic mirroring cost me?**

AWS Traffic mirroring is independent of volume of traffic. It is proportional to number of traffic mirroring sessions and not related to volume of data. See [AWS pricing details](https://docs.aws.amazon.com/vpc/latest/mirroring/what-is-traffic-mirroring.html#pricing) here.

**Do I have to install an agent or any service on my application server?**

No. AWS Traffic mirroring is a completely non-intrusive way to collect and analyze server-side traffic. Absolutely no need to install or change any of your network settings at all.

**I already have traffic mirroring setup on my application servers. Can I still use traffic mirroring?**

AWS can't send same mirrored traffic to 2 diff targets. You should delete the existing session or use a diff traffic connector.

## Troubleshooting Guide

**I can't see my Load balancer in the AWS Traffic mirroring section on Akto dashboard**

Most likely, it is not in the same VPC as Akto dashboard. Please ensure your Akto dashboard is setup in the same VPC as your application server.

**When I hit apply, it says "Something went wrong". How can I fix it?**

Akto runs a Cloudformation template behind the scenes to setup the data processing stack and traffic mirroring sessions with your application servers' EC2 instances. This error means the Cloudformation setup failed.

1. Go to AWS > Cloudformation > Search for "mirroring"
2. Click on Akto-mirroring stack and go to Events tab
3. Scroll down to the oldest error event.

**The Cloudformation template failed with "Client.InternalError: Client error on launch.". How should I fix it?**

This is a known AWS common error. Follow the steps [here](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ts-as-instancelaunchfailure.html#ts-as-instancelaunchfailure-12).

**The Cloudformation template failed with "We currently do not have sufficient capacity in the Availability Zone you requested... Launching EC2 instance failed."**

You can reinstall Akto in a diff availability zone or you can go to Template tab and save the cloudformation template in a file. Search for "InstanceType" and replace all the occurrences with a type that is available in your availability zone. You can then go to AWS > Cloudformation > Create stack and use this new template to setup Traffic mirroring.

**I don't see my error on this list here.**

Please send us all details at support@akto.io or reach out via Intercom on your Akto dashboard. We will definitely help you out.

### Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
