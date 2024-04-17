# Table of contents

* [Github Open Source Repo](https://github.com/akto-api-security/community-edition)
* [What is Akto?](README.md)
* [AktoGPT](aktogpt.md)

## Getting Started

* [Akto Cloud](getting-started/quick-start-with-akto-cloud.md)
* [Akto Self Hosted](getting-started/quick-start-with-akto-self-hosted.md)
* [AWS deploy](getting-started/aws-deploy.md)
* [AWS multi-VPC deploy](getting-started/aws-multi-vpc-deploy.md)
* [AWS Cross-Region Cross-VPC deploy](getting-started/aws-cross-region-vpc-deploy.md)
* [Custom subdomain on Akto on AWS](getting-started/aws-ssl.md)
* [GCP Deploy](getting-started/gcp-deploy.md)
* [Local Deploy](getting-started/local-deploy.md)
* [Azure Deploy](getting-started/azure-deploy.md)
* [Helm Deploy](getting-started/helm-deploy.md)
* [Heroku](getting-started/heroku.md)
* [FAQs on data concerns](getting-started/faqs-on-data-concerns.md)

## Traffic Connections

* [API Traffic data connectors](traffic-connections/traffic-data-sources/README.md)
  * [Connect Akto with AWS Traffic Mirroring](traffic-connections/traffic-data-sources/amazon-aws.md)
  * [Connect Akto with AWS EKS](traffic-connections/traffic-data-sources/aws-eks.md)
  * [Connect Akto with AWS Fargate](traffic-connections/traffic-data-sources/aws-fargate.md)
  * [Connect Akto with AWS Beanstalk](traffic-connections/traffic-data-sources/aws-beanstalk.md)
  * [Connect Akto with Kubernetes in AWS](traffic-connections/traffic-data-sources/kubernetes.md)
  * [Connect Akto with AWS API Gateway](traffic-connections/traffic-data-sources/aws-api-gateway.md)
  * [Connect Akto with Kong](traffic-connections/traffic-data-sources/kong.md)
  * [Connect Akto with NGINX](traffic-connections/traffic-data-sources/nginx.md)
  * [Connect Akto with Envoy](traffic-connections/traffic-data-sources/envoy.md)
  * [Connect Akto with Istio](traffic-connections/traffic-data-sources/envoy-1.md)
  * [Connect Akto with Docker](traffic-connections/traffic-data-sources/docker.md)
  * [Connect Akto with TCP Agent](traffic-connections/traffic-data-sources/tcp-agent.md)
  * [Connect Akto with eBPF](traffic-connections/traffic-data-sources/ebpf.md)
  * [Connect Akto with eBPF on mTLS](traffic-connections/traffic-data-sources/ebpf-mtls.md)
  * [Setup Akto traffic processors](traffic-connections/traffic-data-sources/data-processor.md)
  * [Add API traffic to Akto using HAR file upload](traffic-connections/traffic-data-sources/har-file-upload.md)
  * [Connect Akto with GCP Packet Mirroring](traffic-connections/traffic-data-sources/google-cloud-gcp.md)
  * [Connect Akto with Burp suite](traffic-connections/traffic-data-sources/burp-suite.md)
  * [Connect Akto with Postman](traffic-connections/traffic-data-sources/postman.md)
  * [Connect Akto with OpenAPI](traffic-connections/traffic-data-sources/openapi.md)
  * [Akto SDK](traffic-connections/traffic-data-sources/akto-sdk.md)

## API Inventory

* [Concepts](api-inventory/concepts/README.md)
  * [API Endpoints](api-inventory/concepts/api-endpoints.md)
  * [Meta Properties of API Endpoint](api-inventory/concepts/meta-properties-of-api-endpoint.md)
  * [API Collection](api-inventory/concepts/api-collection.md)
  * [Data Types](api-inventory/concepts/data-types.md)
  * [API Changes](api-inventory/concepts/api-changes.md)
  * [Sensitive Data](api-inventory/concepts/sensitive-data.md)
  * [Alerts](api-inventory/concepts/alerts.md)
  * [Shadow APIs](api-inventory/concepts/shadow-apis.md)
  * [Risk Score](api-inventory/concepts/risk-score.md)
  * [Auth types](api-inventory/concepts/auth-types.md)
  * [Access Type](api-inventory/concepts/access-type.md)
* [How-To](api-inventory/how-to/README.md)
  * [Export an API Collection to Postman](api-inventory/how-to/export-an-api-collection-to-postman.md)
  * [Export an API Collection to Burp](api-inventory/how-to/export-an-api-collection-to-burp.md)
  * [Create Swagger File Using Akto](api-inventory/how-to/create-swagger-file-using-akto.md)
  * [Copy API Endpoints Data](api-inventory/how-to/copy-api-endpoints-data.md)
  * [Add an API Collection](api-inventory/how-to/add-an-api-collection.md)
  * [Set environment type](api-inventory/how-to/set-environment-type.md)
  * [Delete an API Collection](api-inventory/how-to/delete-an-api-collection.md)
  * [Create a Custom Data Type](api-inventory/how-to/create-a-custom-data-type.md)
  * [Set Sensitivity of a Data Type](api-inventory/how-to/set-sensitivity-of-a-data-type.md)
  * [De-activate a data type](api-inventory/how-to/de-activate-a-data-type.md)
  * [Add a Custom Auth Type](api-inventory/how-to/add-a-custom-auth-type.md)
  * [Reset an Auth Type](api-inventory/how-to/reset-an-auth-type.md)
  * [Configure Access Types](api-inventory/how-to/configure-access-types.md)
  * [View New API Endpoint](api-inventory/how-to/view-new-api-endpoint.md)
  * [View New Parameters](api-inventory/how-to/view-new-parameters.md)
  * [Configure alerts on API changes](api-inventory/how-to/configure-alerts-on-api-changes.md)
  * [Create a custom collection](api-inventory/how-to/how-to-create-a-custom-collection.md)
  * [Redact sensitive data](api-inventory/how-to/redact-sensitive-data.md)

## Test Editor

* [Concepts](test-editor/concepts/README.md)
  * [Overview](test-editor/concepts/overview.md)
  * [Test YAML](test-editor/concepts/test-yaml.md)
  * [Test Library](test-editor/concepts/test-library.md)
  * [Custom Test](test-editor/concepts/custom-test.md)
  * [Test YAML Syntax (Detailed)](test-editor/concepts/test-yaml-syntax-detailed/README.md)
    * [ID](test-editor/concepts/test-yaml-syntax-detailed/id.md)
    * [Info](test-editor/concepts/test-yaml-syntax-detailed/info.md)
    * [Wordlists](test-editor/concepts/test-yaml-syntax-detailed/wordlists.md)
    * [Auth](test-editor/concepts/test-yaml-syntax-detailed/auth.md)
    * [API Selection Filters](test-editor/concepts/test-yaml-syntax-detailed/api-selection-filters.md)
    * [Execute](test-editor/concepts/test-yaml-syntax-detailed/execute.md)
    * [Validation](test-editor/concepts/test-yaml-syntax-detailed/validation.md)
    * [Contexts](test-editor/concepts/test-yaml-syntax-detailed/contexts.md)
    * [Strategy](test-editor/concepts/test-yaml-syntax-detailed/strategy.md)
    * [Conditional flows](test-editor/concepts/test-yaml-syntax-detailed/conditional-flows.md)
  * [Template YAMLs](test-editor/concepts/template-yamls/README.md)
    * [Local File Inclusion with Akto](test-editor/concepts/template-yamls/local-file-inclusion-with-akto.md)
* [How To](test-editor/how-to/README.md)
  * [Edit Test](test-editor/how-to/edit-test.md)
  * [Create a Custom Test](test-editor/how-to/create-a-custom-test.md)
  * [Deactivate Test](test-editor/how-to/deactivate-test.md)
  * [Play in Test Editor Background](test-editor/how-to/play-in-test-editor-background.md)
  * [Contribute to Test Library](test-editor/how-to/contribute-to-test-library.md)

## API Security Testing

* [Concepts](api-security-testing/concepts/README.md)
  * [Test](api-security-testing/concepts/test.md)
  * [Test Role](api-security-testing/concepts/test-role.md)
  * [User Config](api-security-testing/concepts/user-config.md)
  * [Test Result](api-security-testing/concepts/test-result.md)
* [How To](api-security-testing/how-to/README.md)
  * [Setup GitHub Integration for CI/CD](api-security-testing/how-to/setup-github-integration-for-ci-cd/README.md)
    * [Create GitHub App](api-security-testing/how-to/setup-github-integration-for-ci-cd/create-github-app.md)
  * [Run Test](api-security-testing/how-to/run-test.md)
  * [Run tests in CI/CD](api-security-testing/how-to/run-tests-in-cicd.md)
  * [Run Tests by Category](api-security-testing/how-to/run-tests-by-category.md)
  * [Test Multiple APIs](api-security-testing/how-to/test-multiple-apis.md)
  * [Schedule Tests](api-security-testing/how-to/schedule-tests.md)
  * [Stop Tests](api-security-testing/how-to/stop-tests.md)
  * [Create a Test Role](api-security-testing/how-to/create-a-test-role.md)
  * [Play in Test Editor Playground](api-security-testing/how-to/play-in-test-editor-playground.md)
  * [Conduct Role-Based Testing](api-security-testing/how-to/conduct-role-based-testing.md)
  * [Run tests in CLI using Akto](api-security-testing/how-to/run-tests-in-cli-using-akto.md)
  * [Secure GraphQL APIs using Akto](api-security-testing/how-to/secure-graphql-apis-using-akto.md)

## SSO

* [Azure AD SAML](sso/azureAd-saml.md)
* [Okta OIDC](sso/okta-oidc.md)
* [Github OIDC](sso/github-oidc.md)

***

* [Github contribution guide](github-contribution-guide.md)

## API reference

* [API reference](api-reference/api-reference.md)

## Components

* [Dashboard](components/dashboard.md)
* [Testing module](components/testing-module.md)
* [Traffic mirroring module](components/traffic-mirroring-module.md)
* [Runtime analyzer](components/runtime-analyzer.md)
* [Context analyzer](components/context-analyzer.md)
* [Puppeteer server](components/puppeteer-server.md)
* [Other OSS](components/other-oss.md)
* [robots.txt](components/robots.txt.md)

## Troubleshooting

* [How to get logs](troubleshooting/logs.md)

***

* [Support](support.md)
