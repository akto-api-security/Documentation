# Run Probes in CI/CD

## Introduction

You can trigger Akto's AI Red Teaming in your CI/CD pipelines too. Generate your **Akto token** and send API requests to Akto dashboard to start running scans.

### Generate Akto token

*   Go to `My account > Settings > Integrations`

    <div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (5) (1).png" alt="" width="563"><figcaption></figcaption></figure></div>
* Select `CI/CD Integeration`
*   Click on `Generate token` button to generate a fresh token or copy an existing token.

    <figure><img src="../../../.gitbook/assets/image (7).png" alt="" width="563"><figcaption></figcaption></figure>

### Add trigger in your CI/CD tool

* Open the Agentic Collection where you want to run the scans.
* By default, the Agentic Collection view shows all Agentic components. You can filter the agent component on which you want to run the scans. For example, to run scans only on `GET` endpoints, we can add a filter to show only `GET` endpoints.
* Click on the `Run scan` button on the top right.
*   Select the scans you want to run as part of CI/CD pipeline. Please keep `Select time = Now` and `Run daily` should be unchecked. Feel free to edit the `Name`, `Scan run time` and `Max concurrent requests` and any other details.

    <figure><img src="../../../.gitbook/assets/image (8).png" alt="" width="375"><figcaption></figcaption></figure>
* Click on `Run once now` (if the button name says anything else, read the previous point 🙄)
*   Observe the `Scan ID` on the red teaming page for the probe you just created. \*

    ```
    <figure><img src="../../../.gitbook/assets/image (9).png" alt=""><figcaption></figcaption></figure>
    ```

### GitHub Actions

*   You can also use our plugin for Github Actions directly too:

    ```
      - name: Run CI/CD scans
        uses: akto-api-security/run-scan@v1.0.3
        with:
          AKTO_DASHBOARD_URL: ${{vars.AKTO_DASHBOARD_URL}}
          AKTO_API_KEY: ${{vars.AKTO_API_KEY}}
          AKTO_TEST_ID: ${{vars.AKTO_SCAN_ID}}
          START_TIME_DELAY: 180 # Delay in seconds after which scanning run is started, optional, default is 0 
    ```

### Post deployment hook (works with any CI/CD platform)

To run add the following docker command to your CI/CD pipeline

```bash
docker run \
-e AKTO_DASHBOARD_URL='https://app.akto.io' \
-e AKTO_API_KEY='<AKTO_API_KEY>' \
-e AKTO_TEST_ID='<AKTO_SCAN_ID>' \
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
docker run -e AKTO_DASHBOARD_URL='https://app.akto.io' -e AKTO_API_KEY='<AKTO_API_KEY>' -e AKTO_TEST_ID='<AKTO_SCAN_ID>' -e GITHUB_SERVER_URL="<GIT_SERVER_URL>" -e GITHUB_REPOSITORY="<GIT_REPOSITORY>" -e GITHUB_REF_NAME="<GIT_BRANCH>" -e GITHUB_REF="<PULL_REQUEST_ID>" -e GITHUB_SHA="<PULL_REQUEST_SHA>" -e WAIT_TIME_FOR_RESULT=0 -e CICD_PLATFORM="<CICD_PLATFORM>" aktosecurity/akto-testing-scan:latest
```

* If you have hosted Akto in your VPC, please ensure the CI/CD machine can reach Akto's dashboard. You might have to change Security rules on Akto-Load-Balancer accordingly.
