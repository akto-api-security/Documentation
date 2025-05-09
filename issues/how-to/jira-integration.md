# Jira Integration

Integrate Akto with Jira to streamline your API security workflow by creating tickets for vulnerabilities directly from Akto.

<figure><img src="../../.gitbook/assets/image (98).png" alt=""><figcaption></figcaption></figure>

### Quick Setup Steps

#### 1. Access Integrations

* Go to **Settings > Integrations**.
* Find and click **"Configure"** next to Jira.

#### 2. Enter Jira Details

* **Base URL:** Your Jira instance URL (e.g., `https://yourcompany.atlassian.net`).
* **Email:** Your Jira account email.
* **API Token:** Your Jira API token (generate in Jira).

#### 3. Add Projects

You can configure **one or multiple Jira projects**. For each project:

* **Project Key:** Enter your Jira project key (e.g., `KAN`, `DP`).
* **Enable Bi-Directional Integration (Optional):**
  * Tick the checkbox to **sync status both ways**: when Akto updates a vulnerability’s status, Jira is updated; and vice versa.
  * **Map statuses**: Define how Jira statuses map to Akto statuses:
    * Akto Status: **Open** → Jira Status: _Select corresponding status_.
    * Akto Status: **Fixed** → Jira Status: _Select corresponding status_.
    * Akto Status: **Ignored** → Jira Status: _Select corresponding status_.

💡 **You can add up to 10 projects per integration.**

#### 4. Save

* Click **"Save"** to finalize.

***

### What Happens When You Enable/Disable Bi-Directional Integration?

<figure><img src="../../.gitbook/assets/image.png" alt=""><figcaption></figcaption></figure>

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

{% hint style="info" %}
This feature assumes that **no separate custom workflows** are created in your Jira app. If there are any, the syncing process **might be affected** and could lead to unexpected behavior. Please review your Jira workflows to ensure compatibility.
{% endhint %}

***

### Important Notes

* ⚠️ **Mandatory fields** set in Jira are not currently supported in this integration. Ensure that all required fields are included and properly configured in Jira to ensure smooth ticket creation.
* You can configure **different bi-directional settings per project** to tailor the sync behavior to each project’s needs.

***

### Benefits

* ✅ Instantly create Jira tickets for API vulnerabilities.
* ✅ Manage multiple Jira projects from a single integration.
* ✅ Enable **bi-directional sync** to ensure full alignment between Akto and Jira.
* ✅ Maintain a centralized view of security issues.
* ✅ Enhance collaboration between security and development teams.

***

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
