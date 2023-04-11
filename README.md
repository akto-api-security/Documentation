# What is Akto?

[How it works](./#how-it-works) • [Getting-Started](./#how-to-get-started) • [API Inventory](broken-reference/) • [API testing](broken-reference/) • [Add Test](testing/test-library.md) • [Join Discord community](https://discord.com/invite/Wpc6xVME4s) •

Akto is an open source, instant API security platform that takes only 60 secs to get started. Akto is used by security teams to maintain a continuous inventory of APIs, test APIs for vulnerabilities and find runtime issues. Akto offers tests for all OWASP top 10 and HackerOne Top 10 categories including BOLA, authentication, SSRF, XSS, security configurations, etc. Akto's powerful testing engine runs variety of business logic tests by reading traffic data to understand API traffic pattern leading to reduced false positives. Akto can integrate with multiple traffic sources - burpsuite, AWS, postman, GCP, gateways, etc.

Akto enables security and engineering teams to secure their APIs by doing three things:

1. [API inventory](api-inventory/api-inventory/)
2. [Run business logic tests in CI/CD](testing/run-test.md)
3. [Find vulnerabilities in run-time](api-inventory/sensitive-data.md)

{% embed url="https://www.youtube.com/watch?v=nImmFA4cp9c" %}
Akto Demo
{% endembed %}

## How it works?

Step 1: Create inventory

<figure><img src=".gitbook/assets/Screenshot 2023-01-26 at 5.07.03 PM.png" alt=""><figcaption></figcaption></figure>

Step 2: Run tests

<figure><img src=".gitbook/assets/Screenshot 2023-01-26 at 5.08.19 PM (1).png" alt=""><figcaption></figcaption></figure>

## How to get Started?

Start with [local deploy](getting-started/quick-start-with-akto-self-hosted/local-deploy.md). Run this script to create Akto at `~/akto` and run the docker containers.

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/akto-api-security/infra/feature/self_hosting/cf-deploy-akto)"
```

## How to Contribute?

[Contribution guide](github-contribution-guide.md)
