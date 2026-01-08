# Threat Issues

## Overview

The **Threat Issues** section presents security findings associated with a specific API endpoint. The view helps you understand active and historical security risks detected by Akto for the selected API.

<figure><img src="../../.gitbook/assets/image (176).png" alt="" width="563"><figcaption></figcaption></figure>

## How Akto Populates Threat Issues

Akto continuously analyzes API traffic and test results to identify security issues. Each detected issue is recorded as a discrete threat entry and linked directly to the API endpoint where the behavior was observed.

## Information Shown for Each Issue

Each row in the Threat Issues table represents a single security issue and includes clearly scoped attributes:

* **Severity**: Risk level assigned by Akto based on exploitability and impact.
* **Issue Name**: Security condition or weakness detected.
* **Category**: Classification of the issue based on Akto’s threat taxonomy.
* **Domains**: Affected security domains, when applicable.
* **Compliance**: Mapped compliance standards, when relevant.
* **Discovered**: Date when Akto first identified the issue.

## Value for Your Security Workflow

The Threat Issues view allows you to:

* Correlate security findings directly with API endpoints.
* Track issue recurrence and discovery timelines.
* Prioritise remediation using severity and category context.
* Validate security posture changes as APIs evolve.

This section is designed to provide focused, API-level security visibility without requiring navigation across multiple testing or reporting views.
