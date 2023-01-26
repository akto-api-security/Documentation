---
description: You've got questions, we've got answers.
---

# FAQs

### What does Akto do? 📝&#x20;

Akto enables security and engineering teams to secure all of their APIs from sensitive data leak by continuously learning business logic of all APIs at run time.

### What is Akto's approach to API security? 🔆&#x20;

We help teams with complete API security by continuously learning business logic of all APIs. Our approach has 4 pillars to API security:

* ****[**Observe**](broken-reference) **:** Build your API inventory with sensitive parameters and observe API changes in real time ensuring 100% visibility of all APIs
* **Find :** Conduct security testing of your APIs based on application logic, automated in CI/CD
* **Fix :** Fix your APIs with one click vulnerability fixes in CI/CD
* **Protect** : Protect your APIs by detecting and blocking malicious users exploiting application logic vulnerabilities, using AI based behaviour analysis

![](<../.gitbook/assets/Screen Shot 2021-11-25 at 1.48.18 PM.png>)

{% hint style="success" %}
****[**Observe**](broken-reference) **is the building block of Akto.**

We learn the business logic of APIs in this part to create API Inventory, build tests, suggest fixes and detect threats.
{% endhint %}

### How to start using Akto? 🎬

Akto can be self hosted in 5 mins. You can start using Akto using self hosted deployment methods:

* [AWS deploy:](../getting-started/quick-start-with-akto-self-hosted/local-deploy.md) You can deploy Akto in one click using our cloudformation template.
* [Kubernetes deploy](broken-reference): Coming Soon

### How much time does it take to start using Akto? ⏳&#x20;

User can start using Akto in ✌**2 minutes** (YES!) You deploy it via AWS or Kubernetes on any machine. The whole process takes around ✌2 minutes.

### I don't want the data to leave my VPN. Does Akto support on-premise deployment? 🛡

YES, we do offer on-premise deployment. Regardless of the method you choose to [deploy](broken-reference), we **DO NOT** save or send any of your traffic data.

### Is Akto secure? Where's my data stored? ✅&#x20;

**We treat security seriously at Akto.**

Yes, your data is secure, and doesn't leave your cloud. With our self hosted deployment, that you can deploy yourself, in your own VPC, on your own VPS. That way, you are fully in control of the Akto instance, and your data never leaves your VPC.

We are also in the process of getting SOC 2 and ISO compliance.

### What sort of data does Akto store? 🔢

Only metadata concerning your usage, such as:

* Usage metrics of Akto users
* List of endpoint urls
* Request and response templates of endpoints

{% hint style="info" %}
**Your real-time traffic data is NOT stored by Akto**
{% endhint %}

### What all infrastructure does Akto support? 📦&#x20;

Akto supports all infrastructure including AWS, GCP and Azure. You can deploy in any machine using our local deploy method.

### I have micro services architecture. Does Akto support it? 🌐

YES. Akto supports all architectures - monolith, services, micro services, api gateway and service mesh.

### Who is the user of Akto? 👫

Akto's users are:

* **Security teams** who want to ensure complete security of their APIs
* **Engineering leaders and developers** who are concerned about data leak from their APIs

### I am a developer, can I use Akto? 👨🏽‍💻

YES. Akto is a developer friendly API security platform. If you are a developer, you can use Akto to do the following:

* Get notified when the APIs you deployed are leaking any sensitive data
* Fix with one click any vulnerability that exploits business logic of your APIs in CI/CD itself
* Know the vulnerabilities of your APIs, their business impact and fixes through our API audit tool

### At what stage of our app should I use Akto? 🤔

As soon as your application has more than 10 API endpoints, it will become hard for you to manually monitor sensitive data leak and do manual API security testing. You should start using Akto to build an API security culture early on in the engineering teams and avoid tech debt later.
