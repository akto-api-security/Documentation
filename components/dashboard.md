# Dashboard

All the user interactions and Akto API calls happen via Dashboard component. This component has a UI part to it as well. 

Dockerhub version: aktosecurity/akto-api-security-dashboard:local
Dockerfile [link](https://github.com/akto-api-security/akto/blob/master/docker-compose.yml#L15)
Interaction: Dashboard runs in a separate docker image. It serves UI and also traffic processing. It uses **Runtime analyzer** as a library in HarAction.java & PostmanAction.java to import traffic from BurpSuite, Postman import and upload HAR functionality. It only interacts with **Mongo**.
Architecture: For enterprises, Dashboard docker runs on a separate instance in a private subnet as part of an AutoScalingGroup. This AutoScalingGroup is behind a public facing ALB. 
