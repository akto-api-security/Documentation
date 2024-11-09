---
description: >-
  Akto’s integration with GitHub enterprise and Github.com allows you to
  maintain API security through GitHub pull requests itself.
---

# Setup GitHub Integration for CI/CD

With this integration, you'll be able to

**Check status of Akto CICD tests** directly from GitHub pull requests through quality gates

<figure><img src="../../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

**Check result of Akto CICD tests** directly from comment posted on Github pull request

<figure><img src="../../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../../.gitbook/assets/image (2) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

## Prerequisites

* [A **Github app** with required permissions needs to be installed on your repository as well as integrated in Akto.](create-github-app.md)

## Steps to add Github comments on pull request

* Follow [run test in CICD](../run-tests-in-cicd.md) to trigger CICD tests via GitHub action.
*   Add variable `GITHUB_COMMIT_ID : ${{github.event.pull_request.head.sha}}` in our Github Plugin in order to trigger Akto CICD reporting on Github PR.

    ```
      - name: Run CI/CD tests
        uses: akto-api-security/run-scan@v1.0.12
        with:
          AKTO_DASHBOARD_URL: ${{vars.AKTO_DASHBOARD_URL}}
          GITHUB_COMMIT_ID: ${{github.event.pull_request.head.sha}}
          AKTO_API_KEY: ${{vars.AKTO_API_KEY}}
          AKTO_TEST_ID: ${{vars.AKTO_TEST_ID}}
          START_TIME_DELAY: 180 # Delay in seconds after which testing run is started, optional, default is 0 
    ```
