# Other OSS

As part of Akto installation, you would see some OSS docker images being used. Here is a list of all other such modules - 

1. **Mongo**
   - Dockerhub version: mongo:6.0.1
   - Dockerfile [link](https://github.com/akto-api-security/akto/blob/master/docker-compose.yml#L5)
   - Interaction: Mongo serves as our primary database. All of the Akto modules read and update their state in Mongo
   - Architecture: For enterprises, Mongo docker runs on a completely separate instance in a private subnet
   - Alternatives: AWS DocDB & Mongo Atlas are a few alternatives if you want to use. However, quite a few functionalities are not supported in such cloud databases. Read AWS article [here](https://docs.aws.amazon.com/documentdb/latest/developerguide/functional-differences.html). 
3. **Kafka**
   - Dockerhub version: confluentinc/cp-kafka:6.2.1
   - Used only in enterprise version
   - Interaction: All of the data (HTTP req-resp pairs) get pushed to Kafka.
   - Architecture: It runs alongside Traffic-Mirroring module (producer) and Runtime-analyzer module (consumer). Buffers application's traffic data. 
   - Why community edition doesn't need it: Community edition is meant to run on a single laptop with traffic sources being Postman, BurpSuite proxy, Har files etc. The sizes are small compared to traffic received by production application. They are processed synchronously within the dashboard rather than async buffer queue.
5. **Zookeeper**


