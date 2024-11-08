---
description: Learn how to send API traffic data from your Kubernetes cluster to Akto.
---

# Connect Akto with Kubernetes in AWS

## Introduction

[Akto](https://www.akto.io/) needs your staging, production or other environment's traffic to Discover APIs and analyze for AP misconfiguration. It does so by connecting to one of your [traffic sources](broken-reference). One such source is your Kubernetes cluster.

`Kubernetes` is an open-source container orchestration system for automating software deployment, scaling, and management.

You can add Akto DaemonSet to your Kubernetes cluster. It is very lightweight and will run 1 per node in your Kubernetes cluster. It will intercept alll the node traffic and send it to Akto traffic analyzer. Akto's traffic analyzer analyzes this traffic to create your application's APIs request and response, understand API metadata and find misconfigurations. Akto can work with high traffic scale though you can always configure the amount of traffic you want to send to Akto dashboard.

## Overview of Akto-Kubernetes setup

<figure><img src="../../.gitbook/assets/Kubernertes daemonset arch.png" alt="Kubernetes deployment for Akto in AWS"><figcaption><p>Kubernetes Deployment</p></figcaption></figure>

This is how your run Akto's traffic collector on your Kubernetes nodes as DaemonSet and send mirrored traffic to Akto.

## Pre-requisites to add data to Akto AWS from Kubernetes cluster

1. You have permissions to create and assign roles to InstanceProfiles
2. You should have installed Akto dashboard in the same VPC as your application server EC2 instances
3. Your application should be receiving unencrypted traffic. SSL, if any, should be terminated before it reaches your application server EC2 instance. Usually, SSL termination happens at API Gateway or Load balancer
4. You should have permissions to add a DaemonSet to your k8s setup

## Configuring Akto traffic processing stack and creating AWS policy

Follow these steps to add DaemonSet config to your Kubernetes setup -

1. Navigate to Quick Start on your Akto dashboard and expand the `Connect traffic data` section.

<figure><img src="https://user-images.githubusercontent.com/91221068/236832212-603647ca-fceb-46fc-baf7-150c2e6b7ec0.png" alt="Navigate to quick start"><figcaption></figcaption></figure>

2. Scroll down to `Kubernetes Daemonset` section.

<figure><img src="https://user-images.githubusercontent.com/91221068/236832259-cac91fd0-c6a1-4ab2-ab2b-2b9f3d4244b3.png" alt="Scroll to Kubernetes"><figcaption><p>Kubernetes DaemonSet</p></figcaption></figure>

3. Copy the `policy json` and click on the Akto Dashboard role link.

<figure><img src="https://user-images.githubusercontent.com/91221068/236832267-1e22802b-caa9-4af6-8cf9-06a8b0cacc5d.png" alt="Copy AWS policy"><figcaption></figcaption></figure>

4. `Click` on the `JSON` tab and `paste the policy`

<figure><img src="https://user-images.githubusercontent.com/91221068/236832279-70340e39-3ccb-4118-9ee9-039711c7e22d.png" alt="paste policy in AWS"><figcaption><p>Paste policy in AWS</p></figcaption></figure>

5. Click on `Review policy` button.

<figure><img src="https://user-images.githubusercontent.com/91221068/236832289-afe2931b-c11a-44b8-a946-79cf0e106dfa.png" alt="Click on review policy"><figcaption><p>Click on review policy</p></figcaption></figure>

6. Enter _`AktoDashboardPolicy`_ as the policy name and `click` on `Create Policy` button

<figure><img src="https://user-images.githubusercontent.com/91221068/236832299-996d635d-5c0d-43d3-8ee3-eb53f7de952d.png" alt="Enter Akto Dashboard policy"><figcaption><p>Enter name of the policy</p></figcaption></figure>

7. Once the policy is created, go back to the `dashboard`.
8. You should now see a `Setup DaemonSet stack` button. `Click` on this button to setup a traffic processing stack.

{% hint style="info" %}
This will process your API traffic data and populate APIs on the dashboard. This might take a few minutes to complete.
{% endhint %}

<figure><img src="https://user-images.githubusercontent.com/91221068/236832351-220ee84e-5d34-4a82-8819-a11bdeeefb5b.png" alt="Setup akto DaemonSet stack"><figcaption><p>Setup DaemonSet stack</p></figcaption></figure>

## Setting up Akto Daemonset pod on your K8s cluster

1. Once complete, you should now see a daemonset config. `Copy the config` and paste in a `text editor`.

<figure><img src="https://user-images.githubusercontent.com/91221068/236832394-4a3dabc6-60f2-4112-b1cb-127c4a129c6d.png" alt="Copy the configuration"><figcaption><p>Copy the configuration</p></figcaption></figure>

You can also copy from here -

```
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: akto-k8s
  namespace: {NAMESPACE}
  labels:
    app: {APP_NAME}
spec:
  selector:
    matchLabels:
      app: {APP_NAME}
  template:
    metadata:
      labels:
        app: {APP_NAME}
    spec:
      hostNetwork: true
      dnsPolicy: ClusterFirstWithHostNet
      containers:
      - name: mirror-api-logging
        image: aktosecurity/mirror-api-logging:k8s_agent
        env: 
          - name: AKTO_TRAFFIC_BATCH_TIME_SECS
            value: "10"
          - name: AKTO_TRAFFIC_BATCH_SIZE
            value: "100"
          - name: AKTO_INFRA_MIRRORING_MODE
            value: "gcp"
          - name: AKTO_KAFKA_BROKER_MAL
            value: "<AKTO_NLB_IP>:9092"
          - name: AKTO_MONGO_CONN
            value: "<AKTO_MONGO_CONN>"
```

2. Replace `{NAMESPACE}` with your app namespace and `{APP_NAME}` with the name of your app. If you have installed on _AWS_ -

* Go to EC2 > Instances > Search for `Akto Mongo Instance` > Copy private IP.
* Replace `AKTO_MONGO_CONN` with `mongodb://10.0.1.3:27017/admini` where 10.0.1.3 is the private ip (example)
* Go to EC2 > Load balancers > Search for `AktoNLB` > Copy its DNS.
* Replace `AKTO_NLB_IP` with the DNS name. eg `AktoNLB-ca5f9567a891b910.elb.ap-south-1.amazonaws.com`

If you have installed on _GCP_, _Kubernetes_ or _OpenShift_ -

* Get Mongo Service's DNS name from Akto cluster
* Replace `AKTO_MONGO_CONN` with `mongodb://mongo.p03.svc.cluster.local:27017/admini` (where mongo.p03.svc.cluster.local is Mongo service)
* Get Runtime Service's DNS name from Akto cluster
* Replace `AKTO_NLB_IP` with the DNS name. eg. `akto-api-security-runtime.p03.svc.cluster.local`

<figure><img src="https://user-images.githubusercontent.com/91221068/236832427-2506df70-2040-440d-9347-c81152b110d4.png" alt="Replace namespace in text editor"><figcaption><p>Replace namespace in text editor</p></figcaption></figure>

3. Create a file `akto-daemonset-config.yaml` with the above YAML config

<figure><img src="https://user-images.githubusercontent.com/91221068/236832456-67c34a4b-12d8-46f6-902d-16747771036a.png" alt="Create Akto daemonset config yaml"><figcaption><p>Create Akto daemonset config yaml</p></figcaption></figure>

4. Call `kubectl apply -f akto-daemonset-config.yaml -n <NAMESPACE>` on your _kubectl_ terminal

<figure><img src="https://user-images.githubusercontent.com/91221068/236832475-1a20f62c-05e8-4ca7-85c6-c5bc1d4a9946.png" alt="call yaml"><figcaption><p>call yaml</p></figcaption></figure>

5. Run the command `kubectl get daemonsets` in terminal. It should show _akto-k8s_ daemonset.

<figure><img src="https://user-images.githubusercontent.com/91221068/236832493-35b27843-dce9-482a-803a-033999c55aef.png" alt="Run the command"><figcaption><p>Run the command</p></figcaption></figure>

6. Go to `API Discovery` on Akto dashboard to see your new APIs

<figure><img src="https://user-images.githubusercontent.com/91221068/236832509-8e8c84ff-633e-4ffe-b11b-344d02ca6e74.png" alt="Check API Discovery"><figcaption><p>Check API Discovery</p></figcaption></figure>

## Frequently Asked Questions (FAQs)

**The traffic will contain a lot of sensitive data - does it leave my VPC?**

Data remains strictly within your VPC. Akto doesn't take data out of your VPC at all.

**Does adding DaemonSet have any impact on performance or latency?**

Zero impact on latency. The DaemonSet doesn't sit like a proxy. It simply intercepts traffic - very similar to tcpdump. It is very lightweight. We have benchmarked it against traffic as high as 20M API requests/min. It consumes very low resources (CPU & RAM).

## Troubleshooting Guide

**When I hit apply, it says "Something went wrong". How can I fix it?**

Akto runs a Cloudformation template behind the scenes to setup the data processing stack and traffic mirroring sessions with your application servers' EC2 instances. This error means the Cloudformation setup failed.

1. Go to AWS > Cloudformation > Search for "mirroring"
2. Click on Akto-mirroring stack and go to Events tab
3. Scroll down to the oldest error event.

**The Cloudformation template failed with "Client.InternalError: Client error on launch.". How should I fix it?**

This is a known AWS common error. Follow the steps [here](https://docs.aws.amazon.com/autoscaling/ec2/userguide/ts-as-instancelaunchfailure.html#ts-as-instancelaunchfailure-12).

**The Cloudformation template failed with "We currently do not have sufficient capacity in the Availability Zone you requested... Launching EC2 instance failed."**

You can reinstall Akto in a diff availability zone or you can go to Template tab and save the cloudformation template in a file. Search for "InstanceType" and replace all the occurrences with a type that is available in your availability zone. You can then go to AWS > Cloudformation > Create stack and use this new template to setup Traffic mirroring.

**I am seeing kafka related errors in the daemonset logs**

If you get an error like "unable to reach host" or "unable to push data to kafka", then do the following steps:

1. Grab the ip of the akto-runtime instance by running "kubectl get service -n {NAMESPACE}"
2. Use helm upgrade to update the value of `kafkaAdvertisedListeners` key to `LISTENER_DOCKER_EXTERNAL_LOCALHOST://localhost:29092,LISTENER_DOCKER_EXTERNAL_DIFFHOST://{IP_FROM_STEP_1}:9092`
3. Put the same ip against the `AKTO_KAFKA_BROKER_MAL` as `{IP_FROM_STEP_1:9092}` in the daemonset config and reapply the daemonset config.

**I don't see my error on this list here.**

Please send us all details at support@akto.io or reach out via Intercom on your Akto dashboard. We will definitely help you out.

### Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
