# FAQs on data concerns

### Is Akto secure? Where's my data stored? ✅&#x20;

**We treat security seriously at Akto.**

Yes, your data is secure, and doesn't leave your cloud. With our self hosted deployment, that you can deploy yourself, in your own VPC, on your own VPS. That way, you are fully in control of the Akto instance, and your data never leaves your VPC.

### What sort of data does Akto store?

No data goes out of your VPC. Within your VPC, only metadata concerning your usage is stored, such as:

* Usage metrics of Akto users
* List of endpoint urls
* Key names of request and response only

{% hint style="info" %}
**Your real-time traffic data is NOT stored by Akto. The traffic data is discarded as soon as it is processed in less than an hour.**
{% endhint %}

### What data does Akto read?

Akto reads a duplicated stream of your traffic to analyze APIs. After reading, Akto discards the data immediately after processing. We have set a hard limit of 1 hour for traffic data retention. Again, all this is happening in your VPC and no data goes out.

### What outgoing calls happen from within my Akto setup? 

Akto setup is done is a private subnet which should have internet connectivity (usually via NAT Gateway). We strongly recommend you use a private subnet in Akto setup so that it is NOT reachable from outside your VPC. The outgoing internet-connectivity is required so that we can - 

1. Download setup-related files from GitHub & images from DockerHub
2. Send Slack & email (Sendgrid) alerts for new endpoints and security test failures
3. Use AktoGPT. Read [here](https://docs.akto.io/aktogpt#data-concerns) about data concerns

###
