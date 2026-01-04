# Generic CI/CD

Akto integrates in your CI/CD pipeline using docker as well.

To run add the following docker command to your CI/CD pipeline

```bash
docker run \
-e AKTO_DASHBOARD_URL='https://app.akto.io' \
-e AKTO_API_KEY='<AKTO_API_KEY>' \
-e AKTO_TEST_ID='<AKTO_TEST_ID>' \
-e GITHUB_SERVER_URL="<GIT_SERVER_URL>" \
-e GITHUB_REPOSITORY="<GIT_REPOSITORY>" \
-e GITHUB_REF_NAME="<GIT_BRANCH>" \
-e GITHUB_REF="<PULL_REQUEST_ID>" \
-e GITHUB_SHA="<PULL_REQUEST_SHA>" \
-e WAIT_TIME_FOR_RESULT=0 \
-e CICD_PLATFORM="<CICD_PLATFORM>" \
aktosecurity/akto-testing-scan:latest
```

In case you face an issue with the spaces in the command...

```bash
docker run -e AKTO_DASHBOARD_URL='https://app.akto.io' -e AKTO_API_KEY='<AKTO_API_KEY>' -e AKTO_TEST_ID='<AKTO_TEST_ID>' -e GITHUB_SERVER_URL="<GIT_SERVER_URL>" -e GITHUB_REPOSITORY="<GIT_REPOSITORY>" -e GITHUB_REF_NAME="<GIT_BRANCH>" -e GITHUB_REF="<PULL_REQUEST_ID>" -e GITHUB_SHA="<PULL_REQUEST_SHA>" -e WAIT_TIME_FOR_RESULT=0 -e CICD_PLATFORM="<CICD_PLATFORM>" aktosecurity/akto-testing-scan:latest
```

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
