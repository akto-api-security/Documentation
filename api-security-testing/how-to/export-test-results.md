---
description: A quick guide to export vulnerability reports from your Akto test results.
---

# Export Vulnerability Report from Test Results

### Steps

1. Navigate to Testing > Results in the left sidebar
2. Select your test run
   * View results showing vulnerabilities, severity levels, and scan details
3. Export the report
   * Click "More actions" in the top-right
   * Select "Export vulnerability report"

<figure><img src="../../.gitbook/assets/image (80).png" alt="" width="563"><figcaption></figcaption></figure>

## Export Report in Markdown

he Export Report flow allows you to extract selected test findings as a Markdown file for downstream use cases such as documentation, reviews, or internal reporting.

#### Steps to Export

{% stepper %}
{% step %}
Log in to **Akto** using an account with access to API Security Testing.
{% endstep %}

{% step %}
Navigate to **API Security Testing** and open the **Results** section.
{% endstep %}

{% step %}
Identify the required test run from the list of completed test runs.
{% endstep %}

{% step %}
Select one or more issues from the test results table by using the issue name or the selection checkbox for multiple issues.
{% endstep %}

{% step %}
Review the bottom action bar that appears after issue selection. Click **Export selected test results as Markdown** to initiate the export.

<figure><img src="../../.gitbook/assets/mdfile.png" alt=""><figcaption></figcaption></figure>
{% endstep %}

{% step %}
Download and store the generated Markdown report for external sharing or internal workflows.
{% endstep %}
{% endstepper %}
