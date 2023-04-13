# Traffic mirroring module

This module processes all the mirrored traffic. From the mirrored traffic, it assembles tcp packets in a sequence. Once it builds the bidirectional TCP connection stream from the mirrored traffic, it extracts HTTP req-resp pairs from the stream. And each such pair is then pushed to **Kafka**.

- Dockerhub version: aktosecurity/mirror-api-logging:local (Enterprise only)
- Interaction: Traffic mirroring module runs as a separate Docker instance. It reads the traffic coming on port 4789 (AWS Traffic mirroring port) and all ports for GCP. 
- Architecture: For enterprises, Traffic mirroring module docker runs on the same instance as **Runtime analyzer**
