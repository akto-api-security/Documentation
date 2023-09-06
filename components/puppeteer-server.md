# Puppeteer server

This is used to replay a Chrome recording to automate auth token generation.

* Dockerhub version: aktosecurity/akto-puppeteer-replay:latest
* Dockerfile [link](https://github.com/akto-api-security/akto/blob/master/docker-compose.yml#L30)
* Interaction: Puppeteer server runs in a separate docker image.
* Architecture: Puppeteer server runs on the same instance as Dashboard. It is triggered only when the feature is in use and the testing module wants to fetch a new auth token.
