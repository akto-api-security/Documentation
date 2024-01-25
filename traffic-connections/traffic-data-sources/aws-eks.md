---
description: >-
  Learn about how to send API traffic data using AWS EKS to Akto from your
  environment.
---

# Connect Akto with AWS EKS

## Introduction

[Akto](https://www.akto.io/) needs your staging, production or other environment's traffic to Discover APIs and analyze for AP misconfiguration. It does so by connecting to one of your [traffic sources](./). One such source is AWS EKS.&#x20;

## Configuring Daemonset

Follow these steps to add daemonset config to your Kubernetes setup -

1\. Go to Quick Start on your Akto dashboard and expand the `Connect traffic data` section.

<figure><img src="https://user-images.githubusercontent.com/91221068/236832212-603647ca-fceb-46fc-baf7-150c2e6b7ec0.png" alt=""><figcaption></figcaption></figure>

2\. Scroll down to `Kubernetes Daemonset` section.

<figure><img src="https://user-images.githubusercontent.com/91221068/236832259-cac91fd0-c6a1-4ab2-ab2b-2b9f3d4244b3.png" alt=""><figcaption></figcaption></figure>



## Creating AWS Policy

1\. Copy the `policy json` and click on the Akto Dashboard role link.&#x20;

<figure><img src="https://user-images.githubusercontent.com/91221068/236832267-1e22802b-caa9-4af6-8cf9-06a8b0cacc5d.png" alt=""><figcaption></figcaption></figure>

2\. `Click` on the `JSON` tab and `paste the policy`

<figure><img src="https://user-images.githubusercontent.com/91221068/236832279-70340e39-3ccb-4118-9ee9-039711c7e22d.png" alt=""><figcaption></figcaption></figure>

3\. Click on `Review policy` button.

<figure><img src="https://user-images.githubusercontent.com/91221068/236832289-afe2931b-c11a-44b8-a946-79cf0e106dfa.png" alt=""><figcaption></figcaption></figure>

4\. Enter _`AktoDashboardPolicy`_ as the policy name and `click` on `Create Policy` button

<figure><img src="https://user-images.githubusercontent.com/91221068/236832299-996d635d-5c0d-43d3-8ee3-eb53f7de952d.png" alt=""><figcaption></figcaption></figure>

7\. Once the policy is created, go back to the `dashboard`.



## Setting up Daemonset stack

1\. You should now see a `Setup daemonset stack` button. `Click` on this button to setup a traffic processing stack.

{% hint style="info" %}
&#x20;This will process your API traffic data and populate APIs on the dashboard. This might take a few minutes to complete.
{% endhint %}

<figure><img src="https://user-images.githubusercontent.com/91221068/236832351-220ee84e-5d34-4a82-8819-a11bdeeefb5b.png" alt=""><figcaption></figcaption></figure>

2\. Once complete, you should now see a daemonset config. `Copy the config` and paste in a `text editor`.

<figure><img src="https://user-images.githubusercontent.com/91221068/236832394-4a3dabc6-60f2-4112-b1cb-127c4a129c6d.png" alt=""><figcaption></figcaption></figure>

3\. Replace `{NAMESPACE}` with your app namespace and `{APP_NAME}` with the name of your app

<figure><img src="https://user-images.githubusercontent.com/91221068/236832427-2506df70-2040-440d-9347-c81152b110d4.png" alt=""><figcaption></figcaption></figure>

4\. Create a file `akto-daemonset-config.yaml` with the above YAML config

<figure><img src="https://user-images.githubusercontent.com/91221068/236832456-67c34a4b-12d8-46f6-902d-16747771036a.png" alt=""><figcaption></figcaption></figure>

5\. Call `kubectl apply -f akto-daemonset-config.yaml -n <NAMESPACE>` on your _kubectl_ terminal

<figure><img src="https://user-images.githubusercontent.com/91221068/236832475-1a20f62c-05e8-4ca7-85c6-c5bc1d4a9946.png" alt=""><figcaption></figcaption></figure>

6\. Run the command `kubectl get daemonsets` in terminal. It should show _akto-k8s_ daemonset.

<figure><img src="https://user-images.githubusercontent.com/91221068/236832493-35b27843-dce9-482a-803a-033999c55aef.png" alt=""><figcaption></figcaption></figure>

7\. Go to `API Inventory` on Akto dashboard to see your new APIs

<figure><img src="https://user-images.githubusercontent.com/91221068/236832509-8e8c84ff-633e-4ffe-b11b-344d02ca6e74.png" alt=""><figcaption></figcaption></figure>

{% hint style="info" %}
Akto is [Open Source](https://www.akto.io/blog/introducing-akto-open-source) and if you find any issues or [traffic connectors](https://www.akto.io/connectors) you don't see in the list, you can create an issue in our open source repo [here](https://github.com/akto-api-security/akto).
{% endhint %}

### What's next?

You can now go to your API Inventory to see all the API traffic Akto has captured. Head to [API Inventory](../../api-inventory/concepts/api-collection.md) to learn more. Once you start seeing inventory, you can run API Security tests on your APIs. See [Akto's test library](https://www.akto.io/test-library) to select tests you want to run on your APIs.&#x20;

### Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
