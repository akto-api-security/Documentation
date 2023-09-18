---
description: >-
  Learn how to deploy Akto in GCP and add traffic to Akto using GCP Packet
  Mirroring
---

# Connect Akto with GCP Packet Mirroring

## Pre-requisites to add data to Akto using Packet Mirroring&#x20;

Make sure, the GCP account in which the resources will be created has provisioned enough compute to be able to deploy [Akto](http://akto.io/) and has sufficient permission levels to create resources.

## Steps to deploy Akto in GCP

You can deploy Akto using the GCP packet mirroring template. Here are the steps to deploy:

1. Click on this [link](https://raw.githubusercontent.com/akto-api-security/infra/feature/self\_hosting/templates/gcp-mirroring-template.sh) to see the template.
2. Go to your console in GCP and type these commands

```
wget https://raw.githubusercontent.com/akto-api-security/infra/feature/self_hosting/templates/gcp-mirroring-template.sh
chmod +x gcp-mirroring-template.sh
```

This will create a template with name gcp-mirroring-template.sh

3\. Make sure you are in the project where you want create resources.

4\. Create a txt file with name inputs.txt with the following input parameters.

```
project-id
region
network
subnet
zone
```

Here is an example below:

```
ankitas-playground 
us-west4 
vpc-1 
vpc-1-usw4 
us-west4-a
```

5\. Go to the instances you want to mirror and add network tag 'mirror' to them.

6\. Now start creating resources by writing this command `./gcp-mirroring-template.sh create <inputs.txt`

{% hint style="warning" %}
`Troubleshoot: if you get permission denied error, type and enter the command` chmod +x gcp-mirroring-template.sh
{% endhint %}

7\. The above command will create the following resources:

* [ ] A load balancer
* [ ] An auto scaled instance group added to the load balancer which receives mirrored packets
* [ ] One instance with mongo
* [ ] One instance with Akto dashboard

8\. Once all the resources are created, go to VM instances in your google cloud.

9\. Click on the akto-dashboard-instance and find the IP.

10\. Copy and paste this IP in your browser and add port 8080 to it ( http://yourip:8080)

11\. You can signup on Akto dashboard.

{% hint style="info" %}
To delete all the resources you created with 'akto' prefix, run the command `./gcp-mirroring-template.sh delete <delete.txt`

Before running the above command, make sure you create delete.txt with the following inputs:

```
<your-project-id>
<region>
akto
<zone>
y
```
{% endhint %}

## Frequently Asked Questions (FAQs)

**Does the mirroring have any performance impact on my traffic ?**

GCP mirroring is a native functionality offered by google cloud which works by cloning network traffic, thus offering no performance impact on your workloads. You can read more on it at \[https://cloud.google.com/vpc/docs/packet-mirroring].

**I need to monitor a lot of traffic. Can this handle the scale of my network traffic ?**

Akto is built keeping in mind, the needs of large enterprises. We use instances in autoscaling groups, which deploy instances based on the incoming traffic, to ensure that we log all your traffic. In times of low network traffic, the autoscaling group would automatically, reduce instances to save resources.

## Troubleshooting Guide

**Where can I find the project-id in GCP ?** Link to video: [https://www.notion.so/docs-improvement-28e9861308d74445bf5143defa9f2b33?pvs=4#ebf309e03a87426a91ea657e8594b49d](https://www.notion.so/docs-improvement-28e9861308d74445bf5143defa9f2b33?pvs=4#ebf309e03a87426a91ea657e8594b49d)

**Where can I find region, network and subnet ?**

&#x20;Link to video: [https://www.notion.so/docs-improvement-28e9861308d74445bf5143defa9f2b33?pvs=4#98e93966f11944b297635a9a2b34e0ce](https://www.notion.so/docs-improvement-28e9861308d74445bf5143defa9f2b33?pvs=4#98e93966f11944b297635a9a2b34e0ce)

**Where can I find the region zone ?**

Here's a list of available zones in all the regions. \[https://cloud.google.com/compute/docs/regions-zones#available]

**I cannot access Akto after installing it successfully.**

Check if the akto IP on is accessible by your machine. It may be possible that it is behind your organization’s VPN. If so, enable it and try again. If accessing akto IP from a public network, allow HTTP traffic on the akto dashboard instance.

**I cannot see my traffic being mirrored after installing akto.**

1. Check if mirroring sessions have been created for the desired instances. You can check this at VPC > Packet mirroring
2. Check if the VM ports at which your traffic is being generated is open in the akto runtime machines. Say, if the traffic is being generated at port 3000 on the VM, open the same port on the akto runtime machine.
3. The akto runtime processes traffic data every 15-20 minutes, so the traffic logged may not be visible instantly on the akto dashboard.
4. If this doesn’t solve your issue, contact our support at help@akto.io

