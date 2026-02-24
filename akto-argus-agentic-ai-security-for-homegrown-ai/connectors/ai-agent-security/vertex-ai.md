---
description: Connect Akto with Google BigQuery for Vertex AI Custom Deployed Model Logs
---

# Vertex AI

## Overview

Akto can automatically fetch Vertex AI Custom Deployed Model prediction logs from BigQuery and analyze them for security issues. This integration allows you to monitor your AI models deployed on Vertex AI by ingesting prediction logs into Akto.

{% hint style="warning" %}
This method only works for **custom models** deployed on Vertex AI. It does not support default provided models (e.g. Gemini) in the Vertex platform.
{% endhint %}

## Prerequisites

* A Google Cloud Platform (GCP) project with Vertex AI enabled.
* A BigQuery dataset and table where prediction logs are stored.
* Appropriate IAM permissions to read from BigQuery.
* Enable the following Google Cloud APIs: **Vertex AI API**, **BigQuery API**, and **Cloud Logging API**.

## Steps to Connect

{% stepper %}
{% step %}
### **Enable BigQuery Logging**

First, configure your Vertex AI Custom Deployed Model endpoint to log predictions to BigQuery.

#### Via Console

1. Go to **Vertex AI → Endpoints** in GCP Console.
2. Select your deployed model endpoint.
3. Click **Edit**.
4. Under **Logging**, enable **Request/Response logging**.
5. Select **BigQuery** as the destination.
6. Choose or create a dataset (e.g., `vertex_ai_logs`).
7. Save.

#### Via gcloud CLI

```bash
gcloud ai endpoints update ENDPOINT_ID \
  --region=REGION \
  --request-response-logging-config=bigquery-destination=projects/PROJECT_ID/datasets/DATASET_NAME/tables/TABLE_NAME
```
{% endstep %}

{% step %}
### **Create IAM Service Account**

Create a dedicated Service Account for Akto (e.g., `akto-bq-reader`). This account will need permissions to read from your BigQuery dataset and execute query jobs.

#### **1. Create Service Account**

Via Console:

1. Go to **IAM & Admin → Service Accounts**.
2. Click **+ CREATE SERVICE ACCOUNT**.
3. Name: `akto-bq-reader`.
4. Description: `Service account for Akto to read BigQuery logs`.
5. Click **CREATE AND CONTINUE**.

Via gcloud:

```bash
gcloud iam service-accounts create akto-bq-reader \
    --display-name="Akto BigQuery Reader"
```

#### **2. Grant BigQuery Permissions**

You must grant two key roles:

* `BigQuery Job User` (`roles/bigquery.jobUser`): Allows running query jobs.
* `BigQuery Data Viewer` (`roles/bigquery.dataViewer`): Allows reading table data.

Via Console (on the Service Account creation page):

1. Under **Select a role**, search for `BigQuery Job User`.
2. Click **ADD ANOTHER ROLE**.
3. Search for `BigQuery Data Viewer`.
4. Click **CONTINUE** and **DONE**.

Via gcloud:

```bash
# Grant Job User role (permits running queries in the project)
gcloud projects add-iam-policy-binding YOUR_PROJECT_ID \
    --member="serviceAccount:akto-bq-reader@YOUR_PROJECT_ID.iam.gserviceaccount.com" \
    --role="roles/bigquery.jobUser"

# Grant Data Viewer role (permits reading dataset contents)
gcloud projects add-iam-policy-binding YOUR_PROJECT_ID \
    --member="serviceAccount:akto-bq-reader@YOUR_PROJECT_ID.iam.gserviceaccount.com" \
    --role="roles/bigquery.dataViewer"
```
{% endstep %}

{% step %}
### **Configure Authentication**

Choose an authentication method based on your deployment. Akto supports **Application Default Credentials (ADC)** and **Service Account Key Files**.

#### Option A: Use Application Default Credentials (Recommended for GKE/Cloud Run)

If Akto is running on GCP (GKE, Cloud Run, Compute Engine), you can use ADC. This is more secure as it avoids managing long-lived keys.

1.  **GKE (Workload Identity)**: Bind the GCP Service Account created in the previous step to the Kubernetes Service Account used by Akto.

    ```bash
    # Link K8s SA to GCP SA
    gcloud iam service-accounts add-iam-policy-binding \
      akto-bq-reader@PROJECT_ID.iam.gserviceaccount.com \
      --role="roles/iam.workloadIdentityUser" \
      --member="serviceAccount:PROJECT_ID.svc.id.goog[akto/akto-sa]"

    # Annotate K8s SA
    kubectl annotate serviceaccount akto-sa -n akto \
      iam.gke.io/gcp-service-account=akto-bq-reader@PROJECT_ID.iam.gserviceaccount.com
    ```
2. **No Configuration Needed**: When configuring the job in Akto, leave the `JSON Authentication File Path` field empty. Akto acts as the service account automatically.

#### Option B: Use a Service Account Key File (External Deployment)

If Akto is running outside of GCP (e.g., On-Prem, AWS, Local Docker), use a Service Account Key.

1. **Create Key**:
   * Go to **IAM & Admin → Service Accounts**.
   * Select `akto-bq-reader`.
   * Go to the **Keys** tab -> **ADD KEY** -> **Create new key** -> **JSON**.
   * Download the file (e.g., `akto-bq-key.json`).
2.  **Mount Key**: Ensure this file is accessible to the Akto container.

    ```bash
    docker run ... -v /path/to/akto-bq-key.json:/app/credentials.json ...
    ```
3. **Specify Path**: When configuring the job in Akto, provide the path `/app/credentials.json` in the `JSON Authentication File Path` field.
{% endstep %}

{% step %}
#### **Configure Akto Job**

In the Akto Dashboard, configure the Vertex AI Custom Deployed Model connector with the following fields:

<table><thead><tr><th width="165.5078125">Field</th><th width="233.09375">Description</th><th width="106.29296875">Required</th><th>Example</th></tr></thead><tbody><tr><td><strong>GCP Project ID</strong></td><td>Your Google Cloud Platform project ID containing the BigQuery dataset.</td><td>Yes</td><td><code>my-gcp-project</code></td></tr><tr><td><strong>BigQuery Dataset</strong></td><td>The BigQuery dataset name containing Vertex AI Custom Deployed Model logs.</td><td>Yes</td><td><code>vertex_ai_logs</code></td></tr><tr><td><strong>BigQuery Table</strong></td><td>The BigQuery table name with Vertex AI Custom Deployed Model logs.</td><td>Yes</td><td><code>predictions</code></td></tr><tr><td><strong>JSON Authentication File Path (Optional)</strong></td><td>Path to the JSON authentication file. Leave empty to use Application Default Credentials (ADC).</td><td>No</td><td><code>/app/gcp-key.json</code></td></tr><tr><td><strong>URL for Data Ingestion Service</strong></td><td>URL of your Akto data ingestion service.</td><td>Yes</td><td><code>http://data-ingestion:9091</code></td></tr></tbody></table>
{% endstep %}
{% endstepper %}

## Verification

To verify that logs are flowing:

1.  **Check BigQuery**: Run a query to ensure data is present in your table.

    ```sql
    SELECT * FROM `project.dataset.table` LIMIT 10;
    ```
2. **Check Akto Logs**: Look for "Successfully ingested" messages in the `account-job-executor` logs.

## Troubleshooting

| Issue                                    | Solution                                                                                                                   |
| ---------------------------------------- | -------------------------------------------------------------------------------------------------------------------------- |
| `Permission denied`                      | Ensure the Service Account has `roles/bigquery.dataViewer` and `roles/bigquery.jobUser`.                                   |
| `Dataset not found`                      | Verify the `Project ID`, `Dataset`, and `Table` names exactly match your GCP resources.                                    |
| `ADC could not find default credentials` | If using ADC, ensure Workload Identity is configured. If using a file, ensure the path is correct and the file is mounted. |

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
