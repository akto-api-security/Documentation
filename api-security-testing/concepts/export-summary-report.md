# Export Summary Report

### Overview

The **Summary Report** in Akto provides a high-level snapshot of an API security scan. It is ideal for **executives, compliance teams, and managers** who need quick insights into the security posture without diving into raw technical data.

The report highlights the **number of vulnerabilities, their severity distribution, categories affected, and scan configuration details**.

<figure><img src="../../.gitbook/assets/image (132).png" alt=""><figcaption></figcaption></figure>

***

### How to Access

1. Go to **API Security Testing → Results**
2. Select a test run
3. Click **More actions**, and choose **Export summary report**.

***

### What’s Included in the Report

1. **Header Summary**
   * **Vulnerable APIs Found** – Number of APIs identified with security issues.
   * **Vulnerable Issues** – Total vulnerability count.
   * **Scan Duration** – How long the test ran.
   * **Test Description** – Overview of what was tested (e.g., authentication, data validation, access controls).
2. **Issues by Severity**
   * Visual **donut chart** showing vulnerabilities across severity levels:
     * 🔴 Critical
     * 🔶 High
     * 🟡 Medium
     * ⚪ Low
   * Helps prioritize fixes quickly.
3. **Top 5 Categories by Issues**
   * A **bar chart** breaking down issues by vulnerability categories.
   * Example from the screenshot:
     * Excessive Data Exposure (EDE)
     * Broken User Authentication (BUA)
     * Security Misconfiguration (SM)
4. **Test Configuration Details**
   * **Test type** (e.g., one-time, scheduled, CI/CD run).
   * **Unique hosts tested**.
   * **Max concurrent requests** used during the test.
   * **Start & completion time** of the scan.

***

### Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `<!--email_off-->help@akto.io<!--/email_off-->` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
