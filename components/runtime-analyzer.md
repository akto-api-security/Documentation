# Runtime analyzer

This module processes all the traffic given to Akto. From the traffic, it finds out endpoints, auth policies, changes in APIs and populates them in the database. It can process API calls upto the speed of 1M calls/min.

* Dockerhub version: aktosecurity/akto-api-security-runtime:latest (Enterprise only)
* Interaction: Runtime analyzer runs as a library in community edition where it gets triggered on Postman import, Burp integration or upload HAR file. In enterprises, it runs as a separate docker image. There, it consumes data from Kafka and saves endpoints along with their metadata in **Mongo**.
* Architecture: For enterprises, Runtime analyzer docker runs on a separate instance in a private subnet as part of an AutoScalingGroup. This AutoScalingGroup is behind a private NLB (not the same as dashboard's ALB).
