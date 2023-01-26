# Amazon AWS

## Introduction

Traffic Mirroring is an Amazon VPC feature that you can use to copy network traffic from an elastic network interface of type `interface`. You can then send the traffic to Akto in a completely out of band manner.

## Configuring Traffic Mirroring&#x20;

Add your API data using [traffic mirroring](https://docs.aws.amazon.com/vpc/latest/mirroring/what-is-traffic-mirroring.html) functionality of AWS.&#x20;

1. Navigate to the `Quick Start` page on dashboard.

<figure><img src="../../.gitbook/assets/Frame 10 (1).png" alt=""><figcaption></figcaption></figure>

2\. Click `connect traffic data`.

<figure><img src="../../.gitbook/assets/Frame 11 (1).png" alt=""><figcaption></figcaption></figure>

### Creating AWS Policy

1. Follow the steps mentioned here. `Click` on the link mentioned in `Step 1`.

<figure><img src="../../.gitbook/assets/Frame 15 (4).png" alt=""><figcaption></figcaption></figure>

2\. This will take you to the policy page of AWS. Navigate to `JSON` tab.

<figure><img src="../../.gitbook/assets/Frame 16 (5).png" alt=""><figcaption></figcaption></figure>

3\. `Copy the policy` from dashboard and `paste` here.

<figure><img src="../../.gitbook/assets/Frame 17 (12).png" alt=""><figcaption></figcaption></figure>

&#x20;4\. `Click on review policy`.

<figure><img src="../../.gitbook/assets/Frame 18 (2) (1).png" alt=""><figcaption></figcaption></figure>

5\. Name the policy `AktoDashboardPolicy`.

6\. Click `create policy`. Once policy is created, go back to the dashboard.

<figure><img src="../../.gitbook/assets/Frame 19 (4).png" alt=""><figcaption></figcaption></figure>

### Selecting loadbalancers

1. Refresh the dashboard now.
2. You will be able to see loadbalancers now.
3. `Select loadbalancers` under my connections section. Select only those loadbalancers from which you want mirror the traffic to Akto dashboard.&#x20;

<figure><img src="../../.gitbook/assets/Frame 12 (1) (1).png" alt=""><figcaption></figcaption></figure>

4\. Click `Apply` to start traffic mirroring.

<figure><img src="../../.gitbook/assets/Frame 14 (2).png" alt=""><figcaption></figcaption></figure>

5\. `Wait` for a couple of minutes. Mirroring is being setup on the loadbalancers you selected above.

<figure><img src="../../.gitbook/assets/Screen Shot 2023-01-04 at 3.13 1.png" alt=""><figcaption></figcaption></figure>

6\. Once mirroring is complete, head to the `API inventory page` and see all the APIs Akto has discovered.
