# Splunk

Akto supports integration with Splunk SIEM to help you streamline the process of detecting vulnerabilities, monitoring API traffic, and enhancing your web application security. This integration allows Akto to forward alert data directly to your Splunk instance for deeper analysis and correlation.

<figure><img src="../.gitbook/assets/image (108).png" alt=""><figcaption></figcaption></figure>

***

### 🔧 Steps to Integrate Splunk SIEM

#### 1. Navigate to Integrations

* Go to **Settings** → **Integrations** from the Akto dashboard sidebar.
* Click on the **SIEM** tab and select **Splunk SIEM**.

#### 2. Configure Splunk Connection

*   In the **Splunk URL** field, enter the base URL of your Splunk HTTP Event Collector (HEC). Example:

    ```
    https://splunk.yourdomain.com:8088
    ```
* In the **Splunk access token** field, enter your **HEC Token**.

> 🔐 **Note**: Make sure the token has permissions to receive event data.

#### 3. Save the Configuration

* Click the **Save** button to complete the integration.
* Once saved, Akto will start forwarding alert and event data to Splunk.

***

### 📥 What Data Gets Sent

* **API security alerts**: Vulnerabilities, suspicious activity, misconfigurations, etc.
* **Audit logs**: User activity and critical changes.
* **Traffic insights**: HTTP logs tied to security incidents.

***

### ✅ Verifying in Splunk

To verify incoming data:

1. Go to **Search & Reporting** in your Splunk dashboard.
2.  Use a search like:

    ```
    index=your_index_name sourcetype=_json source="Akto"
    ```
3. Look for recent logs from Akto to confirm successful integration.

***

### 🛠 Troubleshooting

* Ensure your Splunk HEC is reachable over the network.
* Confirm the token is valid and has the correct permissions.
* Verify port (default: 8088) is open.
* Use `tcpdump` or `curl` to test connectivity if needed.

***

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
