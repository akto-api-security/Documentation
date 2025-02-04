# What is Akto?

[Getting-Started](./#getting-started) • [API Discovery](api-inventory-1/concepts/api-endpoints.md) • [API testing](api-security-testing/concepts/test.md) • [Add Test](test-editor/concepts/test-library.md) • [Join Discord community](https://discord.com/invite/Wpc6xVME4s)&#x20;

Akto is an instant API security platform that takes only 60 secs to get started. Akto is used by security teams to maintain a continuous inventory of APIs, test APIs for vulnerabilities and find runtime issues. Akto offers tests for all OWASP top 10 and HackerOne Top 10 categories including BOLA, authentication, SSRF, XSS, security configurations, etc. Akto's powerful testing engine runs variety of business logic tests by reading traffic data to understand API traffic pattern leading to reduced false positives. Akto can integrate with multiple traffic sources - Burpsuite, AWS, postman, GCP, gateways, etc.

Akto enables security and engineering teams to secure their APIs by doing three things:

1. [API discovery](api-inventory-1/concepts/api-collection.md)
2. [Run business logic tests in CI/CD](ci-cd/how-to/run-tests-in-cicd.md)
3. [Find vulnerabilities in run-time](api-security-testing/concepts/test.md)

{% embed url="https://www.youtube.com/watch?v=XVpcX78IeFI" %}

## Getting Started

Get started with Akto Cloud in 5 simple steps:

### 1. Sign Up

* Visit [app.akto.io](https://app.akto.io)
* Create account with your work email

<figure><img src=".gitbook/assets/image (46).png" alt=""><figcaption></figcaption></figure>

### 2. Create API Inventory

* Go to API Collections → Create new collection
* Name your collection
* Connect your [traffic source](broken-reference) (Burp Suite/AWS/Postman) from Quick Start.

<figure><img src=".gitbook/assets/image (6) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

### 3. Set Authentication

* Go to Settings → Authentication
* Create auth type (Bearer/API Key/Basic)

<figure><img src=".gitbook/assets/image (47).png" alt=""><figcaption></figcaption></figure>

### 4. Configure Attacker Token

* Go to User Configuration
* Set ATTACKER\_TOKEN\_ALL

<figure><img src=".gitbook/assets/image (50).png" alt=""><figcaption></figcaption></figure>

### 5. Run Tests

* Select your collection
* Click Run Test
* Choose tests you want to run
* Select Test role
* Click "Run once now"

<figure><img src=".gitbook/assets/image (7) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

## How to Contribute?

[Contribution guide](github-contribution-guide.md)
