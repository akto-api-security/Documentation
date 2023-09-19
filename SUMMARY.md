# Table of contents

* [Github Open Source Repo](https://github.com/akto-api-security/community-edition)
* [What is Akto?](README.md)
* [AktoGPT](aktogpt.md)

## Getting Started

* [Akto Cloud](getting-started/quick-start-with-akto-cloud.md)
* [Akto Self Hosted](getting-started/quick-start-with-akto-self-hosted.md)
* [AWS deploy](getting-started/aws-deploy.md)
* [AWS multi-VPC deploy](getting-started/aws-multi-vpc-deploy.md)
* [Custom subdomain on Akto on AWS](getting-started/aws-ssl.md)
* [GCP Deploy](getting-started/gcp-deploy.md)
* [Local Deploy](getting-started/local-deploy.md)
* [Azure Deploy](getting-started/azure-deploy.md)
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
  * [Connect Akto with Docker](traffic-connections/traffic-data-sources/docker.md)
  * [Connect Akto with TCP Agent](traffic-connections/traffic-data-sources/tcp-agent.md)
  * [Connect Akto with eBPF](traffic-connections/traffic-data-sources/ebpf.md)
  * [Add API traffic to Akto using HAR file upload](traffic-connections/traffic-data-sources/har-file-upload.md)
  * [Connect Akto with GCP Packet Mirroring](traffic-connections/traffic-data-sources/google-cloud-gcp.md)
  * [Connect Akto with Burp suite](traffic-connections/traffic-data-sources/burp-suite.md)
  * [Connect Akto with Postman](traffic-connections/traffic-data-sources/postman.md)
  * [Akto SDK](traffic-connections/traffic-data-sources/akto-sdk.md)

## API Inventory

* [API Collections](api-inventory/api-collections.md)
* [API inventory](api-inventory/api-inventory/README.md)
  * [Undocumented endpoints](api-inventory/api-inventory/handeling-shadow-apis.md)
  * [Unauthenticated APIs](api-inventory/api-inventory/unauthenticated-apis.md)
* [API changes](api-inventory/detecting-changes-in-apis/README.md)
  * [Webhook alerts](api-inventory/detecting-changes-in-apis/webhook-alerts.md)
* [Auth types](api-inventory/auth-types.md)
* [Sensitive data](api-inventory/sensitive-data.md)
* [API documentation](api-inventory/api-documentation.md)
* [Data types](api-inventory/data-types.md)

## Test Editor

* [Overview](test-editor/overview.md)
* [Test Library](test-editor/test-library.md)
* [Test YAML Syntax (One pager)](test-editor/test-yaml-syntax-one-pager.md)
* [Test YAML Syntax (Detailed)](test-editor/test-yaml-syntax-detailed/README.md)
  * [ID](test-editor/test-yaml-syntax-detailed/id.md)
  * [Info](test-editor/test-yaml-syntax-detailed/info.md)
  * [API Selection Filters](test-editor/test-yaml-syntax-detailed/api-selection-filters.md)
  * [Execute](test-editor/test-yaml-syntax-detailed/execute.md)
  * [Auth](test-editor/test-yaml-syntax-detailed/auth.md)
  * [Validation](test-editor/test-yaml-syntax-detailed/validation.md)
* [Editing built in test](test-editor/editing-built-in-test.md)
* [Writing Custom Tests](test-editor/writing-custom-tests.md)

## TESTING

* [Run tests in CICD](testing/run-tests-in-cicd.md)
* [Run test](testing/run-test.md)
* [Create user config](testing/create-user-config.md)
* [Test results](testing/test-results.md)
* [Test library](testing/test-library.md)

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
