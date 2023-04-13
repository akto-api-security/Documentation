# Testing module

The Testing module is responsible to do API Security testing. 

- Dockerhub version: aktosecurity/akto-api-testing:local
- Dockerfile [link](https://github.com/akto-api-security/akto/blob/master/docker-compose.yml#L24)
- Interaction: Testing module runs in a separate docker image. It polls **Mongo** for any pending tests. If found, it starts testing the APIs based on the test configuration. It then saves the test reports in **Mongo**. It might sometimes trigger an API call to **Puppeteer server** if the chrome-recording functionality is being used for automatic auth token generation.
- Architecture: Testing module docker runs on the same instance as Dashboard.
