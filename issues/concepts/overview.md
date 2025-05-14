---
description: >-
  View and manage security vulnerabilities detected across your APIs and
  services.
---

# Overview

### What is an Issue?

Issues are identified security vulnerabilities or potential threats within your API infrastructure. They represent areas of concern that may compromise the security, functionality, or compliance of your APIs. Issues are categorized by severity and type, providing a comprehensive view of your API's security posture.

### View an Issue

Akto automatically detects and categorizes issues across your API inventory, allowing you to view and manage them efficiently. By examining issues, you gain detailed insights into potential security risks and their impact on your API ecosystem.

This includes details of severity levels, affected endpoints, and issue categories, which show how vulnerabilities may affect your API's security. You can also identify sensitive information exposure, potential attack vectors, and other security concerns, ensuring they are addressed promptly.

<figure><img src="../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

The Issues page provides a list of detected vulnerabilities. Each issue entry typically includes:

* Issue name and description
* Severity level (Critical, High, Medium, Low)
* Affected API endpoint
* Discovery time
* Issue category

When you select an issue, you can view more detailed information such as:

* Full description of the vulnerability
* Potential impact on your system
* Tags (e.g., OWASP Top 10, HackerOne Top 10)
* CWE (Common Weakness Enumeration) references
* List of all affected API endpoints
* External references for further reading and remediation guidance

You can also take actions on issues such as creating Jira tickets, marking as false positives, or indicating acceptable risks. The Issues page includes filtering options to help you sort and manage vulnerabilities effectively.

### Consistent Issue Fingerprint Across Scans

Akto can reliably identify the same issue across multiple scans. This way, your issues are never duplicated and you always have a clean and concise dashboard.

### Consistent Issue Status Across Scan

Akto maintains the correct state of each identified issue over time, as the codebase evolves and scans are re-run. So, say Akto previously found an issue, which was not found in the latest run, then Akto will automatically resolve this issue.

### Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
