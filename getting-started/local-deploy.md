# Local Deploy

## **Introduction**

This guide will help you get the Akto modules running as Docker containers using `Docker Compose`. This is the easiest way to set up Akto in your **local environment**.

## Prerequisites

You'll need to have Docker installed in order to run the container. Check out [the Docker documentation](https://docs.docker.com/install/) for instructions. To verify installation run `docker info`.

## Step 1: Use Docker Compose

Run the following commands to install Akto. You'll need to have curl and Docker installed in order to run the container..

1. Clone the Akto repo by using this command `git clone https://github.com/akto-api-security/akto.git`
2. Go to the cloned directory `cd akto`
3. Run `docker-compose up -d`

## Step 2: Create your account

Akto should automatically open up in your browser at [http://localhost:9090](http://localhost:9090). Click on the Signup button to get started. If you've already signed up, sign in to the account.

![](<../.gitbook/assets/Screen Shot 2023-01-10 at 3.48.28 PM.png>)

## Step 3: Add API data

On the left nav, go to `Quick Start:`

<figure><img src="../.gitbook/assets/Frame 11 (1).png" alt=""><figcaption></figcaption></figure>

* To add traffic from burp suite, navigate to `Burpsuite` and follow[ integration steps for burp](../traffic-connections/burp-suite.md) to add API data from burp.

<figure><img src="../.gitbook/assets/Screenshot 2023-01-26 at 3.32.50 PM.png" alt=""><figcaption></figcaption></figure>

* To add traffic from postman, navigate to `postman` and follow [integration steps for postman](../traffic-connections/postman.md) to add API data from Postman.

<figure><img src="../.gitbook/assets/Screen Shot 2023-01-10 at 5.12.55 PM.png" alt=""><figcaption></figcaption></figure>

Once API data is added, move to `step 4` below to run test.

{% hint style="warning" %}
Akto needs API traffic to create automated API inventory. Currently for your local setup, Akto can get inventory from Burp or Postman. We recommend using Burp to get API inventory.
{% endhint %}

## Step 4: Run test

Go to `Observe -> Inventory`.

<figure><img src="../.gitbook/assets/Frame 20 (2).png" alt=""><figcaption></figcaption></figure>

Click on any `collection` you want to run test on.

`Select endpoints` you want to run test on.

<figure><img src="../.gitbook/assets/Frame 21 (1).png" alt=""><figcaption></figcaption></figure>

Click on `run test`.

<figure><img src="../.gitbook/assets/Frame 22 (1).png" alt=""><figcaption></figcaption></figure>

`Select tests` to be run.

<figure><img src="../.gitbook/assets/Screen Shot 2023-01-10 at 5.26 1.png" alt=""><figcaption></figcaption></figure>

Select `max test run time` and `max concurrent requests`

Click `Run once now`.

Go to `Testing -> Test results -> Test` to see results of the test you have just run.

<figure><img src="../.gitbook/assets/Frame 23 (1).png" alt=""><figcaption></figcaption></figure>
