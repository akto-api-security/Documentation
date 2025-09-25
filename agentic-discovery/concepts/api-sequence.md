# API Sequence

### Overview

API sequences are chains of API calls that represent user or system workflows. Identifying these sequences is critical for:

* Detecting logic-based vulnerabilities
* Improving testing coverage
* Understanding API usage patterns

Akto automatically detects API sequences based on traffic patterns and presents them with visual flow charts and associated statistics.

<figure><img src="../../.gitbook/assets/image (131).png" alt=""><figcaption></figcaption></figure>

***

### 📊 API Sequence&#x20;

The **API Sequences Overview** section gives a snapshot of the identified sequences:

* **Total Sequences:** Number of detected unique API workflows
* **Total Transitions:** Number of API call transitions between steps
* **Avg Probability:** Likelihood of these sequences occurring in real traffic (based on behavioral analysis)

Example from your screenshot:

* **10 Total Sequences**
* **196 Total Transitions**
* **67.1% Avg Probability**

***

### 🧠 How Sequences Are Formed

Akto analyzes live traffic to group API endpoints into sequences by:

1. **Temporal Proximity** – Requests made in close succession.
2. **Entity Linkage** – Requests sharing IDs (like `orderId`, `userId`, `sessionId`).
3. **User Flow Logic** – Common patterns like `login → fetch profile → create order`.

Each node in the sequence represents an endpoint (e.g., `POST /api/users/login`), and edges indicate transitions.

***

### Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
