---
description: >-
  Learn how to deploy Akto in GCP and add traffic to Akto using GCP Packet
  Mirroring
---

# Connect Akto with GCP Packet Mirroring

## Introduction

[Akto](https://www.akto.io/) needs your staging, production or other environment's traffic to Discover APIs and analyze for AP misconfiguration. It does so by connecting to one of your [traffic sources](../../../homegrown-discovery-agents/traffic-data-sources.md). One such source is GCP Packet Mirroring.

<figure><img src="../../../../.gitbook/assets/image (82).png" alt=""><figcaption></figcaption></figure>

Packet Mirroring is a GCP feature that clones the traffic of specified instances in your Virtual Private Cloud (VPC) network and forwards it to Akto. Packet Mirroring captures all traffic and packet data, including payloads and headers. The capture can be configured for both egress and ingress traffic, only ingress traffic, or only egress traffic.

{% hint style="info" %}
[Packet mirroring](https://cloud.google.com/vpc/docs/packet-mirroring) is non intrusive and allows you to send traffic to Akto in a completely out-of-band manner.
{% endhint %}

Packet mirroring is our recommended way to receive data as it is completely non-intrusive. Akto's traffic analyzer analyzes this traffic to create your application's APIs request and response, understand API metadata and find misconfigurations. Akto can work with high traffic scale though you can always configure the amount of traffic you want to send to Akto dashboard.

<figure><img src="../../../../.gitbook/assets/image (56).png" alt=""><figcaption></figcaption></figure>

## Pre-requisites to add data to Akto using Packet Mirroring

Make sure, the GCP account in which the resources will be created has provisioned enough compute to be able to deploy [Akto](https://www.akto.io) and has sufficient permission levels to create resources.

## Steps to deploy Akto in GCP

You can deploy Akto using the `Akto's GCP packet mirroring template`. Here are the steps to deploy:

1. Open GCP Cloud Shell from your GCP Account. You can find the setup script for Akto [here](https://raw.githubusercontent.com/akto-api-security/infra/feature/self_hosting/templates/gcp-mirroring-template.sh). Download it on your shell from the command

{% code overflow="wrap" %}
```
wget https://raw.githubusercontent.com/akto-api-security/infra/feature/self_hosting/templates/gcp-mirroring-template.sh
```
{% endcode %}

2. Change the permissions so that you can execute it `- chmod +x gcp-mirroring-template.sh`
3. This will create a template with name `gcp-mirroring-template.sh`
4. Make sure you are in the project where you want to create resources.
5. Create a `.txt file` with name `inputs.txt` with the following input parameters.

```
project-id
region
network
subnet
zone
```

Here is an example of the txt file below:

```
ankitas-playground 
us-west4 
vpc-1 
vpc-1-usw4 
us-west4-a
```

6. Go to the instances you want to mirror and add network tag 'mirror' to them.
7. Now start creating resources by writing this command `./gcp-mirroring-template.sh create <inputs.txt`

{% hint style="warning" %}
`Troubleshoot: if you get permission denied error, type and enter the command` chmod +x gcp-mirroring-template.sh
{% endhint %}

8. The above command will create the following resources:

* A load balancer
* An auto scaled instance group added to the load balancer which receives mirrored packets
* One instance with mongo
* One instance with Akto dashboard

9. Once all the resources are created, go to VM instances in your google cloud.
10. Click on the `akto-dashboard-instance` and find the IP.
11. Copy and paste this IP in your browser and add port 8080 to it ( http://yourip:8080)
12. You can now signup on Akto dashboard.

### What's next?

You can now go to your API Inventory to see all the API traffic Akto has captured. Head to [API Discovery](../../../../agentic-discovery/concepts/collections/mcp-collection.md) to learn more. Once you start seeing inventory, you can run API Security tests on your APIs. See [Akto's test library](https://www.akto.io/test-library) to select tests you want to run on your APIs.

## Steps to Uninstall and delete Akto resources

In case you are done using Akto and want to uninstall, follow these steps:

1.  Create delete.txt with the following inputs:

    ```
    <your-project-id>
    <region>
    akto
    <zone>
    y
    ```
2. To delete all the resources you created with 'akto' prefix, run the command `./gcp-mirroring-template.sh delete <delete.txt`

## Frequently Asked Questions (FAQs)

**Does the mirroring have any performance impact on my traffic ?**

GCP mirroring is a native functionality offered by Google Cloud which works by cloning network traffic, thus offering no performance impact on your workloads. You can read more on it at [here](https://cloud.google.com/vpc/docs/packet-mirroring).

**I need to monitor a lot of traffic. Can this handle the scale of my network traffic ?**

Akto is built keeping in mind the needs of large enterprises. We use instances in autoscaling groups which deploy instances based on the incoming traffic, to ensure that we log all your traffic. In times of low network traffic, the autoscaling group would automatically, reduce instances to save resources.

## Troubleshooting Guide

**Where can I find the project-id in GCP ?**

Watch this video to see how to find project-id in GCP.

{% embed url="https://www.youtube.com/watch?v=Mv9UT98uoKM" %}
Project Id in GCP
{% endembed %}

**Where can I find region, network and subnet ?**

Watch this video to know how to find region, netwrok and subnet in GCP.

{% embed url="https://www.youtube.com/watch?v=fvDF81fGosY" %}

**Where can I find the region zone ?**

Here's a [list of available zones](https://cloud.google.com/compute/docs/regions-zones#available) in all the regions.

**I cannot access Akto after installing it successfully.**

Check if the Akto IP is accessible by your machine. It may be possible that it is behind your organization’s VPN. If so, enable it and try again.

If accessing Akto IP from a public network, allow HTTP traffic on the akto dashboard instance.

**I cannot see my traffic being mirrored after installing Akto.**

1. Check if mirroring sessions have been created for the desired instances. You can check this at VPC > Packet mirroring
2. Check if the VM ports at which your traffic is being generated is open in the Akto runtime machines. Say, if the traffic is being generated at port 3000 on the VM, open the same port on the akto runtime machine.
3. The Akto runtime processes traffic data every 15-20 minutes, so the traffic logged may not be visible instantly on the akto dashboard.
4. If this doesn’t solve your issue, contact our support at help@akto.io

### Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
