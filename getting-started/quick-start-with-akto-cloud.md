# Quick start with Akto Cloud

## Introduction

Akto Cloud is the preferred choice when getting started. Akto Cloud is a hosted service with added features for reliability and security. If you're looking for the least friction between trying out Akto and moving into production, follow this guide and `get started for free`.

## Step 1: Create your account

`Navigate` to [https://app.akto.io/](https://app.akto.io/) and signup to get started. If you've already signed up, sign into the account.

![](<../.gitbook/assets/Screen Shot 2023-01-10 at 3.48.28 PM.png>)

## Step 2: Add API data

On the left nav, go to `Quick Start:`

<figure><img src="../.gitbook/assets/Frame 10 (1).png" alt=""><figcaption></figcaption></figure>

Click on `Connect traffic data`

<figure><img src="../.gitbook/assets/Frame 11 (1).png" alt=""><figcaption></figcaption></figure>

* To add traffic from burp suite, navigate to `Burpsuite` and follow [integration steps for burp](broken-reference) to add API data from burp.

<figure><img src="../.gitbook/assets/Screenshot 2023-01-26 at 3.32.50 PM (1).png" alt=""><figcaption></figcaption></figure>

* To add traffic from postman, navigate to `postman` and follow [integration steps for postman](../add-api-data/integrations/postman.md) to add API data from Postman.

<figure><img src="../.gitbook/assets/Screen Shot 2023-01-10 at 5.12.55 PM (1).png" alt=""><figcaption></figcaption></figure>

Once API data is added, move to `step 4` below to run test.

{% hint style="warning" %}
Akto needs API traffic to create automated API inventory. Currently for your local setup, Akto can get inventory from Burp or Postman. We recommend using Burp to get API inventory.
{% endhint %}

## Step 3: Run test

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

