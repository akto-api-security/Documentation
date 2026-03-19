# GitHub Actions

Akto integrates with GitHub Actions to add automated agentic AI security scanning to your workflows. This integration enables you to:

* Run AI Red Teaming as part of your GitHub workflow
* Automate security scanning on pull requests
* Block merges based on security scan results

<figure><img src="../../../.gitbook/assets/image (65) (1).png" alt=""><figcaption></figcaption></figure>

### Prerequisites

* GitHub repository with Actions enabled
* Akto dashboard access
* [Akto API credentials](/broken/pages/fxxYPwGU1kTuZwMAksYR)
* [Valid test ID from Akto test](/broken/pages/q2Oz4FsKPEq381Pwpaws)
* [GitHub App](/broken/pages/Kn59XMqtMXUTwjhcDM28) installed and configured (required for PR comments)

### Steps to Configure GitHub Actions

#### 1. Create GitHub Actions Workflow

Create `.github/workflows/akto-security.yml` in your repository with the following content:

```yaml
yamlCopyname: Akto Red Teaming
on:
  pull_request:
    branches: [ main, develop ]
  workflow_dispatch:

jobs:
  security-test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Run CI/CD scans
        uses: akto-api-security/run-scan@v1.0.3
        with:
          AKTO_DASHBOARD_URL: ${{vars.AKTO_DASHBOARD_URL}}
          GITHUB_COMMIT_ID: ${{github.event.pull_request.head.sha}}
          AKTO_API_KEY: ${{vars.AKTO_API_KEY}}
          AKTO_TEST_ID: ${{vars.AKTO_TEST_ID}}
          START_TIME_DELAY: 180 # Delay in seconds after which scanning run is started, optional, default is 0
```

#### 2. Configure GitHub Variables

1. Go to Repository Settings > Secrets and Variables > Actions
2. Add the following repository variables:
   * `AKTO_DASHBOARD_URL`: Your Akto dashboard URL
   * `AKTO_API_KEY`: Your Akto API key
   * `AKTO_TEST_ID`: Your Akto test ID
   * `GITHUB_COMMIT_ID`: For a particular PR (if needed)

#### 3. Enable Required Status Checks

1. Navigate to Repository Settings > Branches
2. Add branch protection rule
3. Enable "Require status checks to pass before merging"
4. Add "Akto Red Teaming" as a required check

#### 4. Verify Integration

1. Create a new pull request
2. Check that Akto security scans run automatically
3. View scan results in the GitHub Actions tab

### Viewing Results

1. **Check status of Akto CICD scans** directly from GitHub pull requests through quality gates

<figure><img src="../../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

2. **Check result of Akto CICD scans** directly from comment posted on Github pull request

<figure><img src="../../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../../.gitbook/assets/image (2) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>
