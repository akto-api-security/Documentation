# Local Deploy

## **Introduction**

This guide will help you get the Akto modules running as Docker containers using `Docker Compose`. This is the easiest way to set up Akto in your **local environment**.

## Prerequisites

You'll need to have Docker installed in order to run the container. Check out [the Docker documentation](https://docs.docker.com/install/) for instructions. To verify installation run `docker info`.

## Step 1: Run install script

### If you have bash installed (Mac and Linux users)

Run this script to create Akto at `~/akto` and run the docker containers.

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/akto-api-security/infra/feature/self_hosting/cf-deploy-akto)"
```

### If you have don't have bash installed (Windows users)

1. Download the [zip file](https://github.com/akto-api-security/infra/archive/refs/heads/feature/self\_hosting.zip)
2. Unzip the zip file. Go inside the unzipped folder and you will see `docker-compose.yml` file. Open the folder in CMD.
3. Make sure Docker desktop is running. Can be validated with `docker info`.
4. Run `docker-compose up -d` in the folder containing `docker-compose.yml` file (If docker-compose is not installed use this [guide](https://docs.docker.com/compose/install/))
5. Wait couple of minutes and open [http://localhost:9090](http://localhost:9090)

## Step 2: Create your account

Akto should automatically open up in your browser at [http://localhost:9090](http://localhost:9090). Click on the Signup button to get started. If you've already signed up, sign in to the account.

![](<../../.gitbook/assets/Screen Shot 2023-01-10 at 3.48.28 PM.png>)

## Step 3: Add API data

On the left nav, go to `Quick Start:`

<figure><img src="../../.gitbook/assets/Frame 11 (1).png" alt=""><figcaption></figcaption></figure>

* To add traffic from burp suite, navigate to `Burpsuite` and follow[ integration steps for burp](../../add-api-data/integrations/burp-suite.md) to add API data from burp.

<figure><img src="../../.gitbook/assets/Screenshot 2023-01-26 at 3.32.50 PM (1).png" alt=""><figcaption></figcaption></figure>

* To add traffic from postman, navigate to `postman` and follow [integration steps for postman](../../add-api-data/integrations/postman.md) to add API data from Postman.

<figure><img src="../../.gitbook/assets/Screen Shot 2023-01-10 at 5.12.55 PM (1).png" alt=""><figcaption></figcaption></figure>

Once API data is added, move to `step 4` below to run test.

{% hint style="warning" %}
Akto needs API traffic to create automated API inventory. Currently for your local setup, Akto can get inventory from Burp or Postman. We recommend using Burp to get API inventory.
{% endhint %}

## Step 4: Run test

Go to `Observe -> Inventory`.

<figure><img src="../../.gitbook/assets/Frame 20 (2).png" alt=""><figcaption></figcaption></figure>

Click on any `collection` you want to run test on.

`Select endpoints` you want to run test on.

<figure><img src="../../.gitbook/assets/Frame 21 (1).png" alt=""><figcaption></figcaption></figure>

Click on `run test`.

<figure><img src="../../.gitbook/assets/Frame 22 (1).png" alt=""><figcaption></figcaption></figure>

`Select tests` to be run.

<figure><img src="../../.gitbook/assets/Screen Shot 2023-01-10 at 5.26 1.png" alt=""><figcaption></figcaption></figure>

Select `max test run time` and `max concurrent requests`

Click `Run once now`.

Go to `Testing -> Test results -> Test` to see results of the test you have just run.

<figure><img src="../../.gitbook/assets/Frame 23 (1).png" alt=""><figcaption></figcaption></figure>
