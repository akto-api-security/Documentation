# GitLab

Akto integrates with GitLab to add automated API security testing to your CI/CD pipeline. This integration enables you to:

* Run API security tests during your GitLab pipelines
* View security test results directly in merge requests
* Block merges based on security test results

<figure><img src="../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

### Prerequisites

* GitLab account with maintainer or owner permissions
* GitLab repository with CI/CD enabled
* Docker runner configured in GitLab
* [Akto dashboard access](https://app.akto.io/)
* [Akto API credentials](how-to/get-api-credentials.md) (API key and dashboard URL)
* [Valid test ID from your Akto test](how-to/test-id-from-akto-test.md)

### Steps to Configure GitLab

1. Add GitLab CI Configuration
   1. Create or update `.gitlab-ci.yml` in your repository root:

```yaml
stages:    # List of stages for jobs, and their order of execution
  - build
  - test

build-job:       # This job runs in the build stage, which runs first.
  stage: build
  script:
    - echo "Compiling the code..."
    - echo "Compile complete."

variables:
  AKTO_DASHBOARD_URL: "https://app.akto.io"
  AKTO_API_KEY: "${AKTO_API_KEY}"        # Use GitLab CI/CD variable
  AKTO_TEST_ID: "${AKTO_TEST_ID}"        # Use GitLab CI/CD variable
  WAIT_TIME_FOR_RESULT: "1000"

test_scan:
  stage: test
  image: aktosecurity/akto-testing-scan:latest # Use Docker image to run docker commands
  script:
    - cd /usr/src/app
    - echo $AKTO_DASHBOARD_URL
    - echo $AKTO_API_KEY
    - echo $AKTO_TEST_ID
    - node index.js
```

<figure><img src="../.gitbook/assets/image (74).png" alt=""><figcaption></figcaption></figure>

2. Configure GitLab CI/CD Variables
   1. Go to Settings > CI/CD > Variables
   2. Add these variables:
      * `AKTO_API_KEY` (mark as masked and protected)
      * `AKTO_TEST_ID`

<figure><img src="../.gitbook/assets/image (73).png" alt=""><figcaption></figcaption></figure>

#### 3. Verify Integration

1. Create a merge request
2. Pipeline will automatically run
3. Check "CI/CD > Pipelines" for test results

<figure><img src="../.gitbook/assets/image (75).png" alt=""><figcaption></figcaption></figure>

{% hint style="info" %}
Note: Never commit sensitive credentials like API keys directly in your configuration files. Always use GitLab CI/CD variables for sensitive data.
{% endhint %}
