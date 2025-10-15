# Sensitive Data Scanner

The Sensitive Data Scanner is an AI agent that detects the exposure of personal and sensitive information in your APIs. It continuously monitors API endpoints and payloads to uncover risks related to PII, PHI, authentication tokens, and metadata leaks. This helps organizations maintain privacy compliance and protect customer trust.

<figure><img src="../.gitbook/assets/image (2) (1).png" alt=""><figcaption></figcaption></figure>

***

### Key Capabilities

#### 1. PII and PHI detection

* Identifies personal details such as names, emails, addresses, phone numbers, and medical records
* Flags unencrypted personal information in request and response payloads
* Provides severity levels to prioritize remediation

#### 2. Authentication and token exposure

* Detects weak or exposed authentication tokens
* Highlights insecure handling of credentials across APIs
* Prevents potential unauthorized access risks

#### 3. Metadata and sensitive attributes scanning

* Identifies sensitive user profile fields in API responses
* Flags excessive data exposure through verbose error messages or debug attributes
* Helps reduce attack surface by enforcing data minimization

#### 4. Compliance alignment

* Ensures data handling practices are mapped against GDPR, HIPAA, PCI DSS and other privacy regulations
* Automates sensitive data checks across large API ecosystems
* Provides reports to assist with compliance audits
