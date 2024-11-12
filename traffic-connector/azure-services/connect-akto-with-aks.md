# Connect Akto with AKS

AKS offers the quickest way to start developing and deploying cloud-native apps in Azure, datacenters, or at the edge, with built-in code-to-cloud pipelines and guardrails.

## Setting up Akto Daemonset pod on your K8s cluster

1. Once complete, you should now see a daemonset config. `Copy the config` and paste in a `text editor`.

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
4. Call `kubectl apply -f akto-daemonset-config.yaml -n <NAMESPACE>` on your _kubectl_ terminal
5. Run the command `kubectl get daemonsets` in terminal. It should show _akto-k8s_ daemonset.
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
