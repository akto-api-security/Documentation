# Context analyzer

This module processes all the traffic given to Akto but from a stats and ML perspective. From the traffic, it finds out API dependencies, flow graph, private resources being shared in APIs etc. All the work done by context-analyzer is used to reduce false positives in test results. The more data is given to context analyzer, the better the test results get.

- Dockerhub version: aktosecurity/akto-api-context-analyzer:latest (Enterprise only)
- Interaction: Context analyzer runs as a separate docker image. There, it consumes data from Kafka and saves context inferred from traffic  in **Mongo**.
- Architecture: For enterprises, Context analyzer docker runs on a separate instance in a private subnet as part of an AutoScalingGroup. It also uses a separate Kafka+Zookeeper docker alongside. It is separate from **Runtime analyzer** because this is data hungry, updates are less frequent and meant for 1hr+ duration
