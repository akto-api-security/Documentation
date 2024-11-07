# What is Akto?

[How it works](./#how-it-works) • [Getting-Started](./#how-to-get-started) • [API Discovery](broken-reference) • [API testing](api-security-testing/concepts/test.md) • [Add Test](test-editor/concepts/test-library.md) • [Join Discord community](https://discord.com/invite/Wpc6xVME4s)&#x20;

Akto is an open source, instant API security platform that takes only 60 secs to get started. Akto is used by security teams to maintain a continuous inventory of APIs, test APIs for vulnerabilities and find runtime issues. Akto offers tests for all OWASP top 10 and HackerOne Top 10 categories including BOLA, authentication, SSRF, XSS, security configurations, etc. Akto's powerful testing engine runs variety of business logic tests by reading traffic data to understand API traffic pattern leading to reduced false positives. Akto can integrate with multiple traffic sources - Burpsuite, AWS, postman, GCP, gateways, etc.

Akto enables security and engineering teams to secure their APIs by doing three things:

1. [API discovery](api-inventory-1/concepts/api-collection.md)
2. [Run business logic tests in CI/CD](api-security-testing/how-to/run-tests-in-cicd.md)
3. [Find vulnerabilities in run-time](api-security-testing/concepts/test.md)

{% embed url="https://www.youtube.com/watch?v=XVpcX78IeFI" %}

## How it works?

Step 1: Create inventory

<figure><img src=".gitbook/assets/image (6).png" alt=""><figcaption></figcaption></figure>

Step 2: Run tests

<figure><img src=".gitbook/assets/image (7).png" alt=""><figcaption></figcaption></figure>

## How to get Started?

Start with [local deploy](getting-started/local-deploy.md). Run this script to create Akto at `~/akto` and run the docker containers.

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/akto-api-security/infra/feature/self_hosting/cf-deploy-akto)"
```

## How to Contribute?

[Contribution guide](github-contribution-guide.md)
