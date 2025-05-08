# Traffic mirroring module

<figure><img src="../.gitbook/assets/image (2).png" alt=""><figcaption></figcaption></figure>

This module processes all the mirrored traffic. From the mirrored traffic, it assembles tcp packets in a sequence. Once it builds the bidirectional TCP connection stream from the mirrored traffic, it extracts HTTP req-resp pairs from the stream. And each such pair is then pushed to **Kafka**.

* Dockerhub version: aktosecurity/mirror-api-logging:local (Enterprise only)
* Interaction: Traffic mirroring module runs as a separate Docker instance. It reads the traffic coming on port 4789 (AWS Traffic mirroring port) and all ports for GCP.
* Architecture: For enterprises, Traffic mirroring module docker runs on the same instance as **Runtime analyzer**

***

### What Does It Do?

*   **Mirrored Traffic Capture**:

    The module ingests **mirrored TCP traffic** (network packets) from your infrastructure, typically using cloud-native traffic mirroring solutions like **AWS VPC Traffic Mirroring** or **GCP Packet Mirroring**.
*   **TCP Stream Assembly**:

    It **assembles TCP packets in sequence**, rebuilding full bidirectional TCP streams, which is essential for reconstructing entire HTTP transactions.
*   **Request-Response Extraction**:

    After reconstructing the streams, the module identifies **complete HTTP request-response pairs**—whether REST, GraphQL, SOAP, or WebSocket over HTTP.
*   **Kafka Integration**:

    Each reconstructed request-response pair is **pushed to Kafka**, making the data available for consumption by other Akto components for security testing, sensitive data detection, and API inventory building.

***

### How It Fits Into Akto's Architecture

*   **Traffic Source**:

    The module captures mirrored traffic from multiple servers within your infrastructure.
*   **Packet Processing**:

    It acts as the **first line of processing**, converting raw TCP traffic into structured HTTP data.
*   **Data Pipeline**:

    The processed data is streamed to Kafka, where other modules—like the Runtime Analyzer—pick it up for further inspection and action.

This module plays a **foundational role** in enabling Akto to observe real-world API usage patterns passively and securely.

***

### Why It Matters

* ✅ **Agentless & Non-Intrusive**: Monitors traffic without modifying application code or introducing inline components.
* ✅ **Cloud-Optimized**: Supports both AWS and GCP traffic mirroring, making it versatile for modern cloud environments.

***

### Summary

The Traffic Mirroring Module is critical for capturing **traffic** at the network layer, transforming it into actionable data for security analysis. It works silently in the background, powering Akto’s API discovery and security capabilities.

***

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
