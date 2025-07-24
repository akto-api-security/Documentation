---
description: >-
  Learn how to send API traffic data from Burp suite to Akto from your
  environment.
---

# Connect Akto with Burp suite

## Introduction

[Akto](https://www.akto.io/) needs your staging, production or other environment's traffic to Discover APIs and analyze for AP misconfiguration. It does so by connecting to one of your [traffic sources](broken-reference). If you don't have access to staging or production environment, you can create API inventory using Burp's traffic.

{% hint style="info" %}
Note that traffic from Burp Suite won't be automated like the native cloud connectors.
{% endhint %}

## Pre-requisites for Akto Burp connection

1. Make sure you have Burp Suite Community edition or professional installed on your system.
2. You should have an active Akto account which is accessible from your machine.

## Configuring Burp extension in Akto Dashboard

In the demonstration below, we have first bridged the connection between our Akto account and the Burp Suite account before we can start populating the API traffic in our API inventory. This integration begins by downloading the executable **`“Jar file”`** provided in the Akto account. Later on, this file is uploaded to the Burp Suite account to initiate the installation of the Akto extension.

Once the extension was successfully installed in the Burp Suite account, we navigated back to Akto to copy the **`AKTO ID`** & **`AKTO TOKEN`** and paste the values in the relevant fields provided under the Akto extension tab in Burp Suite.

{% embed url="https://demo.arcade.software/pLLHW37gsty3JRikqQA6?embed=" %}

{% embed url="https://www.youtube.com/watch?v=_pHMrvcdiJk" %}
Akto Burp connection Demo
{% endembed %}

### What's next?

Head to [API Discovery](../../api-inventory-1/concepts/api-collection.md) to learn more. Once you start seeing inventory, you can run API Security tests on your APIs. See [Akto's test library](https://www.akto.io/test-library) to select tests you want to run on your APIs.

## Frequently Asked Questions (FAQs)

#### 1. How can I send data related to only a particular domain - example.com to Akto via Burp?

Step 1: In Burp Suite, open `Target` tab, click on `Scope settings`

<figure><img src="../../.gitbook/assets/Scope settings page.png" alt="Scope settings in burp"><figcaption><p>Scope settings in burp</p></figcaption></figure>

Step 2: Inside the `Scope settings` popup, click on `Add` button inside the `Target scope` section and add the prefix of the url i.e. https://example.com.

<figure><img src="../../.gitbook/assets/Target scope.png" alt="Add target scope"><figcaption><p>Add target scope</p></figcaption></figure>

<figure><img src="../../.gitbook/assets/Add url to scope.png" alt="Add prefix"><figcaption><p>Add prefix</p></figcaption></figure>

<figure><img src="../../.gitbook/assets/Url added to scope.png" alt="Add scope"><figcaption><p>Add scope</p></figcaption></figure>

Step 3: Now scroll down to `Out-of-scope request handling` section and select the `Drop all out of scope requests` checkbox. Note: this option will not allow the proxy browser to access any other urls and hence data related to no other urls will be sent to Akto.

<figure><img src="../../.gitbook/assets/Click drop all out-of-scope checkbox.png" alt="Drop all out of scope requests"><figcaption><p>Drop all out of scope requests</p></figcaption></figure>

#### 2. What should I do if my API key has expired or is invalid?

If your API key has expired or is invalid, you will see a dialog box with the error message "`Invalid API key`" To resolve this issue:

Step 1: Open the Akto dashboard.

Step 2: Navigate to `Settings > Integrations > Burp`.

Step 3: Generate a new token and copy it.

Step 4: Paste the new token into the "Options" tab of Burp under AKTO\_TOKEN.

#### 3. Does the Akto Burp plugin processes all the network calls passing through the proxy?

Akto processes only API traffic. Network calls like getting media files are excluded.

#### 4. How to pause sending data to Akto?

In Burp Suite, go to `Akto tab> Options`. Disable the setting `Send data to Akto automatically`.

#### 5. I want to re-export the same data in a different collection. How can I do this in Burp using the Akto plugin?

To re-export the same data into a different collection using the Akto Burp extension, follow these steps:

Step 1: Open Burp Suite and navigate to the Akto tab.

Step 2: In the Akto tab in Burp Suite, locate the "Options" tab.

Step 3: Inside the "Options" tab, you can change the collection name to your desired new name.

Step 4: Once you've updated the collection name, the changes are automatically saved.

Step 5: Re-export the data using the updated collection name, and it will be saved as a separate collection with the new name, allowing you to organize and manage your data effectively in Burp.

#### 6. Can I import ZAP traffic into Akto?

Yes, you can import ZAP (Zed Attack Proxy) traffic into Akto using the Akto plugin. Here's how:

Step 1: Open the `Akto tab` in your Burp Suite in your chosen environment.

Step 2: Navigate to the `Options tab` within the Akto tab in Burp Suite.

Step 3: In the `Options` tab, you'll find a feature that allows you to import ZAP traffic.

Step 4: Follow the provided instructions to import ZAP traffic data into Akto.

By utilizing this feature in the Akto plugin, you can seamlessly import ZAP traffic alongside other data sources, enabling comprehensive monitoring and analysis within the Akto platform.

## Troubleshooting Guide

If you encounter connectivity issues with the Akto server, follow these steps:

**1. If you see a dialog box with the error message "Connection to localhost failed: Connection refused," it means that the Akto server is not reachable from your Burp instance.**

To check and ensure reachability to the Akto server, follow these steps:

Step 1: Open a Web Browser: Launch a web browser on the same machine where Burp is installed.

Step 2: Enter Akto Server URL: In your web browser's address bar, enter the same URL or IP address that you previously configured in the "AKTO\_IP" setting within the Burp plugin. This URL corresponds to the location where Akto's services are hosted. Attempt to Access Akto: Press Enter or click "Go" to navigate to the Akto server's URL.

Step 3: Observe Response: Pay attention to the response from the Akto server. If the server is reachable and responsive, you should see a page or message indicating successful access. If you encounter any errors or the page doesn't load, it suggests a connectivity issue.

**2. I can't see all my APIs in the Burp collection. What should I check?**

If you cannot see data in the Burp collection, ensure the following: The traffic in your Burp API Collection has a 2xx status code because Akto ignores non-2xx API traffic data. Check the response codes for the requests you are monitoring.

**3. Why are rows highlighted in black within the Akto Burp plugin's table view, and how can I resolve this issue?**

If you notice rows being highlighted in black within the Akto Burp plugin's table view, it signifies an issue with data presentation. This issue is commonly encountered when there is a conflict with another plugin called LoggerPlusPlus. To resolve this issue, follow these steps:

Step 1: Remove LoggerPlusPlus Plugin:

The black highlighting issue is often caused by conflicts with the LoggerPlusPlus plugin. To resolve this, you should remove the LoggerPlusPlus plugin from your Burp installation for Akto extension to work.

Step 2: Refresh the Table:

After removing the LoggerPlusPlus plugin, refresh the table view within the Akto Burp plugin. You may need to close and reopen the Akto Burp plugin or take any necessary steps specified in the plugin's interface to update the view.

**4. Akto extension unable to send data after I reinstalled it in burp for a different akto account**

1. Load the Akto extension in burp suite and open `Akto` tab, click on `Options` and then click on `Reset All Settings`.
2. Now click on `Extensions` and reload the akto extension by unchecking and then checking the checkbox. Note: This should load the new settings for the akto extension.

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
