---
description: Connect Akto with Google BigQuery for Vertex AI Logs
---

# Google BigQuery

## Overview

Akto can automatically fetch Vertex AI model prediction logs from BigQuery and analyze them for security issues. This integration allows you to monitor your AI models deployed on Vertex AI by ingesting prediction logs into Akto.

## Prerequisites

*   A Google Cloud Platform (GCP) project with Vertex AI enabled.
*   A BigQuery dataset and table where prediction logs are stored.
*   Appropriate IAM permissions to read from BigQuery.
*   Enable the following Google Cloud APIs: **Vertex AI API**, **BigQuery API**, and **Cloud Logging API**.

## Steps to Connect

{% stepper %}
{% step %}
**Enable BigQuery Logging for Vertex AI**

First, configure your Vertex AI endpoint to log predictions to BigQuery.

### Via Console

1.  Go to **Vertex AI → Endpoints** in GCP Console.
2.  Select your deployed model endpoint.
3.  Click **Edit**.
4.  Under **Logging**, enable **Request/Response logging**.
5.  Select **BigQuery** as the destination.
6.  Choose or create a dataset (e.g., `vertex_ai_logs`).
7.  Save.

### Via gcloud CLI

```bash
gcloud ai endpoints update ENDPOINT_ID \
  --region=REGION \
  --request-response-logging-config=bigquery-destination=projects/PROJECT_ID/datasets/DATASET_NAME/tables/TABLE_NAME
```
{% endstep %}

{% step %}
**Create IAM Service Account**

Create a dedicated Service Account for Akto (e.g., `akto-bq-reader`). This account will need permissions to read from your BigQuery dataset and execute query jobs.

### 1. Create Service Account

Via Console:
1.  Go to **IAM & Admin → Service Accounts**.
2.  Click **+ CREATE SERVICE ACCOUNT**.
3.  Name: `akto-bq-reader`.
4.  Description: `Service account for Akto to read BigQuery logs`.
5.  Click **CREATE AND CONTINUE**.

Via gcloud:
```bash
gcloud iam service-accounts create akto-bq-reader \
    --display-name="Akto BigQuery Reader"
```

### 2. Grant BigQuery Permissions

You must grant two key roles:
*   `BigQuery Job User` (`roles/bigquery.jobUser`): Allows running query jobs.
*   `BigQuery Data Viewer` (`roles/bigquery.dataViewer`): Allows reading table data.

Via Console (on the Service Account creation page):
1.  Under **Select a role**, search for `BigQuery Job User`.
2.  Click **ADD ANOTHER ROLE**.
3.  Search for `BigQuery Data Viewer`.
4.  Click **CONTINUE** and **DONE**.

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
**Configure Authentication**

Choose an authentication method based on your deployment. Akto supports **Application Default Credentials (ADC)** and **Service Account Key Files**.

### Option A: Use Application Default Credentials (Recommended for GKE/Cloud Run)

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
2.  **No Configuration Needed**: When configuring the job in Akto, leave the `JSON Authentication File Path` field empty. Akto acts as the service account automatically.

### Option B: Use a Service Account Key File (External Deployment)

If Akto is running outside of GCP (e.g., On-Prem, AWS, Local Docker), use a Service Account Key.

1.  **Create Key**:
    *   Go to **IAM & Admin → Service Accounts**.
    *   Select `akto-bq-reader`.
    *   Go to the **Keys** tab -> **ADD KEY** -> **Create new key** -> **JSON**.
    *   Download the file (e.g., `akto-bq-key.json`).

2.  **Mount Key**: Ensure this file is accessible to the Akto container.
    ```bash
    docker run ... -v /path/to/akto-bq-key.json:/app/credentials.json ...
    ```

3.  **Specify Path**: When configuring the job in Akto, provide the path `/app/credentials.json` in the `JSON Authentication File Path` field.

{% endstep %}

{% step %}
**Configure Akto Job**

In the Akto Dashboard, configure the BigQuery connector with the following fields:

| Field | Description | Required | Example |
| :--- | :--- | :--- | :--- |
| **GCP Project ID** | Your Google Cloud Platform project ID containing the BigQuery dataset. | Yes | `my-gcp-project` |
| **BigQuery Dataset** | The BigQuery dataset name containing Vertex AI prediction logs. | Yes | `vertex_ai_logs` |
| **BigQuery Table** | The BigQuery table name with Vertex AI Custom Deployed Model logs. | Yes | `predictions` |
| **JSON Authentication File Path (Optional)** | Path to the JSON authentication file. Leave empty to use Application Default Credentials (ADC). | No | `/app/gcp-key.json` |
| **URL for Data Ingestion Service** | URL of your Akto data ingestion service. | Yes | `http://data-ingestion:9091` |

{% endstep %}

{% endstepper %}

## Verification

To verify that logs are flowing:

1.  **Check BigQuery**: Run a query to ensure data is present in your table.
    ```sql
    SELECT * FROM `project.dataset.table` LIMIT 10;
    ```
2.  **Check Akto Logs**: Look for "Successfully ingested" messages in the `account-job-executor` logs.

## Troubleshooting

| Issue | Solution |
| :--- | :--- |
| `Permission denied` | Ensure the Service Account has `roles/bigquery.dataViewer` and `roles/bigquery.jobUser`. |
| `Dataset not found` | Verify the `Project ID`, `Dataset`, and `Table` names exactly match your GCP resources. |
| `ADC could not find default credentials` | If using ADC, ensure Workload Identity is configured. If using a file, ensure the path is correct and the file is mounted. |

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
