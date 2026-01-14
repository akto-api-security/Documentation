# Jira Integration

Integrate Akto with Jira to streamline your API security workflow by creating tickets for vulnerabilities directly from Akto.

<figure><img src="../../.gitbook/assets/image (98).png" alt="" width="563"><figcaption></figcaption></figure>

### Quick Setup Steps

{% stepper %}
{% step %}
#### Access Integrations

* Go to **Settings > Integrations**.
*   Find and click **"Configure"** next to Jira.

    <figure><img src="../../.gitbook/assets/image (180).png" alt="" width="563"><figcaption></figcaption></figure>
{% endstep %}

{% step %}
#### Enter Jira Details

* **Base URL:** Your Jira instance URL (e.g., `https://yourcompany.atlassian.net`).
* **Email:** Your Jira account email.
*   **API Token:** Your Jira API token (generate in Jira).

    <figure><img src="../../.gitbook/assets/image (179).png" alt="" width="563"><figcaption></figcaption></figure>
{% endstep %}

{% step %}
#### Add Projects

You can configure **one or multiple Jira projects**. For each project:

* **Project Key:** Enter your Jira project key (e.g., `KAN`, `DP`).
*   **Enable Bi-Directional Integration (Optional):**

    * Tick the checkbox to **sync status both ways**: when Akto updates a vulnerability’s status, Jira is updated; and vice versa.
    * **Map statuses**: Define how Jira statuses map to Akto statuses:
      * Akto Status: **Open** → Jira Status: _Select corresponding status_.
      * Akto Status: **Fixed** → Jira Status: _Select corresponding status_.
      * Akto Status: **Ignored** → Jira Status: _Select corresponding status_.

    <figure><img src="../../.gitbook/assets/image (178).png" alt="" width="563"><figcaption></figcaption></figure>

{% hint style="info" %}
💡 **You can add up to 10 projects per integration.**
{% endhint %}
{% endstep %}

{% step %}
### Map Severity

* For each **Akto Severity**, select the corresponding **Jira Priority** from the dropdown.
  * **Critical** → e.g. Blocker (P0) / Critical (P1)
  * **High** → e.g. Critical (P1) / Major (P2)
  * **Medium** → e.g. Major (P2) / Minor (P3)
  *   **Low** → e.g. Minor (P3) / Trivial (P4)

      <figure><img src="../../.gitbook/assets/Screenshot 2026-01-14 at 11.56.33 AM.png" alt="" width="563"><figcaption></figcaption></figure>
* Click **Save Mapping** to apply the configuration.
{% endstep %}

{% step %}
#### Save

* Click **"Save"** to finalise.
{% endstep %}
{% endstepper %}

### What Happens When You Enable/Disable Bi-Directional Integration?

<figure><img src="../../.gitbook/assets/image (3) (1) (1) (1) (1) (1) (1).png" alt="" width="563"><figcaption></figcaption></figure>

#### Enabling Bi-Directional Integration:

* Once enabled for a project, Akto will **start syncing statuses every 1 hour**.
* Any status change that occurs in Jira during that hour will be **detected in the next sync cycle** and updated in Akto according to your configured mapping.
* **Existing issues** will **retain their current status** in Akto unless they are updated in Jira.
* As soon as a status change is detected in Jira (for linked tickets), Akto will **sync the new status to match the mapping you configured**.

#### Disabling Bi-Directional Integration:

* When disabled, Akto will **stop syncing status updates** from Jira for that project.
* **Existing issues** in Akto will remain unchanged and **retain their last synced status** at the time of disabling.
* **Manual status updates** in Akto will no longer reflect back in Jira, and vice versa.
* ✅ **If Bi-Directional Integration is turned ON again**, Akto will **resume syncing all issue statuses that changed after the last successful sync (before turning OFF)**, ensuring no updates are missed.

{% hint style="warning" %}
This feature assumes that **no separate custom workflows** are created in your Jira app. If there are any, the syncing process **might be affected** and could lead to unexpected behavior. Please review your Jira workflows to ensure compatibility.
{% endhint %}

{% hint style="info" %}
### Important Notes

* ⚠️ **Mandatory fields** set in Jira are not currently supported in this integration. Ensure that all required fields are included and properly configured in Jira to ensure smooth ticket creation.
* You can configure **different bi-directional settings per project** to tailor the sync behavior to each project’s needs.
* Always double-check your status mappings before enabling or modifying bi-directional settings.
* The bi-directional sync runs once every hour. Each run only processes issues that were updated after the previous sync.
* A Jira ticket can only move to a new status if that transition is allowed. If it’s not, the status will remain unchanged.
* If an error occurs while updating an issue, it is logged and skipped. That issue will not be retried in the next sync.
* If the sync job doesn’t run for some time (e.g., 6 hours due to a technical issue), the next successful run will pick up all updates made since the last successful sync.
{% endhint %}

### Benefits

* ✅ Instantly create Jira tickets for API vulnerabilities.
* ✅ Manage multiple Jira projects from a single integration.
* ✅ Enable **bi-directional sync** to ensure full alignment between Akto and Jira.
* ✅ Maintain a centralized view of security issues.
* ✅ Enhance collaboration between security and development teams.

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
