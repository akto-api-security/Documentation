# Metrics

The **Metrics** page in Settings gives you a complete view of Akto’s data processing pipeline. It helps you understand how runtime and Cyborg components are performing, how much data is flowing through the system, and whether anything is falling behind.

Use these charts to verify ingestion health, diagnose issues, and track overall platform performance.

<figure><img src="../.gitbook/assets/image (63).png" alt=""><figcaption></figcaption></figure>

### Runtime

These metrics show how Akto’s runtime processing pipeline is behaving. They help you validate that Akto is receiving and processing API traffic correctly.

* **Records Count:** Total records processed
* **Records Size:** Total data volume
* **Processing Latency:** Time to process each record
* **Kafka Lag:** Delay in consuming messages
* **Consumption Rate:** Records consumed per second
* **Fetch Latency:** Time to fetch from Kafka
* **Bytes Rate:** Bytes consumed per second

### Discovery

Metrics powered by Cyborg that track API discovery and catalog growth.

* **New APIs:** Newly detected APIs
* **Total APIs:** All APIs tracked
* **Catalog Items:** Total items discovered
* **New Items:** Recently added catalog items
* **Payload Size:** Total payload volume

### Cyborg

These metrics show performance and throughput for Akto’s API discovery engine.

* **Call Latency:** Time per Cyborg call
* **Call Count:** Number of Cyborg calls
* **Data Size:** Data processed by Cyborg
