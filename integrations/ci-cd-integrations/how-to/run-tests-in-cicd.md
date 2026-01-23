# Run tests in CI/CD

## Introduction

You can trigger Akto's API Security tests in your CI/CD pipelines too. Generate your **Akto token** and send API requests to Akto dashboard to start running tests.

### Generate Akto token

<figure><img src="../../../.gitbook/assets/cicd-1.png" alt="Go to integerations tab under settings"><figcaption></figcaption></figure>

* Go to `My account > Settings > Integrations`
* Select `CI/CD Integeration` under `Automation category`

<figure><img src="../../../.gitbook/assets/cicd-2.png" alt="click on Generate Token"><figcaption></figcaption></figure>

* Click on `Generate token` button to generate a fresh token or copy an existing token.

### Add trigger in your CI/CD tool

* Open the API collection where you want to run the tests.
* By default, the API collection view shows all APIs. You can filter the APIs on which you want to run the tests. For example, to run tests only on `GET` endpoints, we can add a filter to show only `GET` endpoints.

<figure><img src="../../../.gitbook/assets/cicd-3.png" alt="Running tests only on GET endpoints"><figcaption></figcaption></figure>

* Click on the `Run test` button on the top right.
* Select the tests you want to run as part of CI/CD pipeline. Please keep `Select time = Now` and `Run daily` should be unchecked. Feel free to edit the `Name`, `Test run time` and `Max concurrent requests`.

<figure><img src="../../../.gitbook/assets/cicd-4.png" alt="Customise the test as you want to run it your CICD"><figcaption></figcaption></figure>

* Click on `Run once now` (if the button name says anything else, read the previous point 🙄)
* Observe the `Test ID` on the testing page for the test you just created.

<figure><img src="../../../.gitbook/assets/cicd-5.png" alt="Customise the test as you want to run it your CICD"><figcaption></figcaption></figure>

### GitHub Actions

*   You can also use our plugin for Github Actions directly too:

    ```
      - name: Run CI/CD tests
        uses: akto-api-security/run-scan@v1.0.3
        with:
          AKTO_DASHBOARD_URL: ${{vars.AKTO_DASHBOARD_URL}}
          AKTO_API_KEY: ${{vars.AKTO_API_KEY}}
          AKTO_TEST_ID: ${{vars.AKTO_TEST_ID}}
          START_TIME_DELAY: 180 # Delay in seconds after which testing run is started, optional, default is 0 
    ```

### Post deployment hook (works with any CI/CD platform)

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

* If you have hosted Akto in your VPC, please ensure the CI/CD machine can reach Akto's dashboard. You might have to change Security rules on Akto-Load-Balancer accordingly.
