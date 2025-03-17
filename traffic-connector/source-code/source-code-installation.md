# Source code installation

This guide walks you through installing and configuring Akto's code analysis module in your on-premises environment. The module enables automatic API discovery through code analysis.

## Resources

Akto's Helm chart repo is on GitHub [here](https://github.com/akto-api-security/helm-charts). You can also find Akto on Helm.sh [here](https://artifacthub.io/packages/helm/akto/akto).

## Prerequisites

Before beginning the installation, ensure you have:

1. A Kubernetes cluster where you have deploy permissions
2. `helm` command installed. Check [here](https://helm.sh/docs/intro/install/)
3. Akto setup already running [Setting up Akto](https://docs.akto.io/getting-started/quick-start-with-akto-self-hosted)

## Installation Steps

Here are the steps to install Akto code analysis module via Helm charts -

1. Generate Github access token
2. Install Akto code analysis module via Helm
3. Connecting to Github
4. View Generated APIs

### Generate Github access token

1. Follow this [guide](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens#creating-a-personal-access-token-classic) to generate Github access token so that the Akto's code analysis module can download the repository
2. Configure token permissions:
   * Select target repositories
   * Grant "Read access to code and metadata" permission

### Generate database abstractor token and url

The code analysis module requires access to Akto's database abstractor:

1. Access the Akto dashboard
2. Navigate to the "Quick Start" tab
3. In the Source Code section:
   * Select Github
   * Click "Connect"
   * Save the `databaseAbstractorToken` from the helm command (to be used in the next step)

### Install Akto code analysis module via Helm

1. Add Akto repo `helm repo add akto https://akto-api-security.github.io/helm-charts`
2.  Install Akto code analysis module via helm. Make sure the below command is executed after replacing the following variables

    * `database_abstractor_url`: If the setup is hybrid then the value is https://cyborg.akto.io else find the akto database abstractor url
    * `database_abstractor_token`: This was generated in the previous step
    * `github_token` generated above
    * `namespace`: where you would like to install Akto code analysis module

    ```bash
    helm install akto-source-code-analyser akto/akto-source-code-analyser  --set source_code_analyser.aktoSourceCodeAnalyser.env.githubAccessToken="<github_token>" --set source_code_analyser.aktoSourceCodeAnalyser.env.databaseAbstractorUrl="<database_abstractor_url>" --set source_code_analyser.aktoSourceCodeAnalyser.env.databaseAbstractorToken="<database_abstractor_token>" --set source_code_analyser.codeAnalysisLspService.env.startJavaLsp="true" --set source_code_analyser.aktoSourceCodeAnalyser.env.runtimeMode="HYBRID" -n <namespace>
    ```
3. Verify if all pods are running: `kubectl get pods -n <namespace`. Expected output: One pod with four running containers

### Connecting to Github

1. Access the Akto dashboard
2. Navigate to the "Quick Start" tab
3. In the Source Code section:
   * Select GitHub
   * Click "Connect"
   * Enter your organization name
   * Select the target repository
   * Save your changes

### View Generated APIs

1. Open the Inventory page in Akto dashboard
2. Look for a new collection named `<organization_name>/<repository_name>`
3. The collection will contain all APIs discovered through code analysis
