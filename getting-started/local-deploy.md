# Local Deploy

## **Introduction**

This guide will help you get the Akto modules running as Docker containers using `Docker Compose`. This is the easiest way to set up Akto in your **local environment**.

## Prerequisites

You'll need to have Docker installed in order to run the container. Check out [the Docker documentation](https://docs.docker.com/install/) for instructions. To verify installation run `docker info`.

## Step 1: Use Docker Compose

Run the following commands to install Akto. You'll need to have curl and Docker installed in order to run the container..

1. Clone the Akto repo by using this command

```
git clone https://github.com/akto-api-security/akto.git
```

2. Go to the cloned directory

```
cd akto
```

3. Run&#x20;

```
docker-compose up -d
```

## Step 2: Create your account

Akto should automatically open up in your browser at [http://localhost:9090](http://localhost:9090). Click on the Signup button to get started. If you've already signed up, sign in to the account.

<figure><img src="../.gitbook/assets/image (22) (1).png" alt=""><figcaption></figcaption></figure>

## Step 3: Add API data

To analyze and secure your APIs, Akto needs to access your API traffic. You can add this using any of our supported traffic connectors.

1. In the dashboard, look for the `Quick start`

<figure><img src="../.gitbook/assets/image (24) (1).png" alt=""><figcaption></figcaption></figure>

2. Choose your preferred traffic connector from the available options
3. Follow the specific instructions for your chosen connector to start feeding API traffic into Akto

<figure><img src="../.gitbook/assets/image (25) (1).png" alt=""><figcaption></figcaption></figure>

For a full list of supported traffic connectors and detailed integration instructions, visit our [Traffic Data Sources](https://docs.akto.io/traffic-connections/traffic-data-sources) page.

## Step 4: Run test

Once you've added your API traffic, you can start running security tests:

1. In the dashboard, click on the "Run Test" button and a modal will pop up, allowing you to select the Tests categories and type of tests you want to test on your collection.
2. Once you select the above, click the "Run once now" button in the modal.

<figure><img src="../.gitbook/assets/image (26) (1).png" alt=""><figcaption></figcaption></figure>

2. You'll be re-directed to the  Test Results page – you can view all the test results, including any potential vulnerabilities or issues detected in your APIs

<figure><img src="../.gitbook/assets/image (19) (1).png" alt=""><figcaption></figcaption></figure>

### Need Help?

Our support team is ready to assist you in maximizing your API security with Akto Cloud.

[Contact Support](mailto:support@akto.io)
