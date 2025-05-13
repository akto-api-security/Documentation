# Runtime analyzer

<figure><img src="../.gitbook/assets/image (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

This module processes all the traffic given to Akto. From the traffic, it finds out endpoints, auth policies, changes in APIs and populates them in the database. It can process API calls upto the speed of 1M calls/min.

* Dockerhub version: aktosecurity/akto-api-security-runtime:latest (Enterprise only)
* Interaction: Runtime analyzer runs as a library in community edition where it gets triggered on Postman import, Burp integration or upload HAR file. In enterprises, it runs as a separate docker image. There, it consumes data from Kafka and saves endpoints along with their metadata in **Database**.
* Architecture: For enterprises, Runtime analyzer docker runs on a separate instance in a private subnet as part of an AutoScalingGroup. This AutoScalingGroup is behind a private NLB (not the same as dashboard's ALB).

***

### What Does It Do?

*   **Auth Policy Detection**:

    Detects **authentication mechanisms** like API keys, JWTs, and OAuth tokens.
*   **Metadata Extraction**:

    Captures request/response headers, payloads, status codes, and flags **sensitive data**.
*   **Change Detection**:

    Identifies **changes in APIs**, such as new parameters or response structure updates.

***

### How It Fits Into Akto’s Architecture

* The Runtime Analyzer **ingests traffic data from Kafka** (typically supplied by the Traffic Mirroring Module or [other sources](../traffic-connector/traffic-data-sources.md).
* It parses and enriches the data to maintain a **real-time view of your APIs**.
* The processed data is made available in the **Akto Dashboard** for API inventory, security testing, and monitoring.

***

### Why It Matters

* ✅ Ensures your **API inventory is always current** based on real traffic.
* ✅ Surfaces **authentication methods and sensitive data** automatically.
* ✅ Enables **real-time change detection** for proactive API monitoring.

***

### Summary

The Runtime Analyzer transforms raw traffic into **structured, actionable API data**, powering Akto’s API discovery, security insights, and change tracking—continuously.

***

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
