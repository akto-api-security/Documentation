# Auto-Create Jira Tickets

Akto makes it simple to automate your issue tracking process by allowing **auto-creation of Jira tickets** whenever security tests are run. This ensures that any vulnerabilities or issues found during your tests are automatically logged in Jira, helping your team stay on top of critical fixes without manual intervention.

<figure><img src="../../.gitbook/assets/image (105).png" alt=""><figcaption></figcaption></figure>

### How It Works

When setting up a test run in Akto, you will see the option to **Auto-create tickets**. Once enabled, Akto will automatically create Jira tickets based on the vulnerabilities detected.

#### Configuration Options

* **Jira project:** Select the connected Jira project (project key, e.g. `PROJ`).
* **Issue type:** Choose the Jira issue type on that project (e.g. Bug, Task, Story).
* **Severity filter:** Specify the severity levels for which tickets should be created (`CRITICAL`, `HIGH`, `MEDIUM`, `LOW`, `INFO`).

### Benefits

* **Seamless Integration:** Automatically log issues in Jira without manual effort.
* **Real-Time Tracking:** Ensure vulnerabilities are tracked as soon as they're discovered.
* **Customizable:** Configure Jira project, issue type, and severity filters to fit your workflow.

### Auto-create from CI/CD

Use `AKTO_AUTO_TICKETING_DETAILS` with `aktosecurity/akto-testing-scan` when you start a **new** collection/suite test (`API_GROUP_NAME` + `TEST_SUITE_NAME`). The JSON is sent to `/api/startTest` as `autoTicketingDetails`.

```json
{"shouldCreateTickets": true, "projectId": "PROJ", "issueType": "Bug", "severities": ["CRITICAL", "HIGH"]}
```

| Field | Required | Description |
| --- | --- | --- |
| `shouldCreateTickets` | Yes | Must be `true` or tickets are not created |
| `projectId` | Yes | Jira project key already connected in Akto |
| `issueType` | Yes | Jira issue type name on that project |
| `severities` | Yes | `CRITICAL`, `HIGH`, `MEDIUM`, `LOW`, and/or `INFO` |

```bash
docker run \
  -e AKTO_DASHBOARD_URL='https://app.akto.io' \
  -e AKTO_API_KEY='<AKTO_API_KEY>' \
  -e API_GROUP_NAME='<API_COLLECTION_NAME>' \
  -e TEST_SUITE_NAME='<TEST_SUITE_NAME>' \
  -e AKTO_AUTO_TICKETING_DETAILS='{"shouldCreateTickets":true,"projectId":"PROJ","issueType":"Bug","severities":["CRITICAL","HIGH"]}' \
  aktosecurity/akto-testing-scan:latest
```

Do not use `{"enabled": true, "provider": "jira", ...}`. Those keys are not part of the API and tickets will not be created.

This env var is Jira-only. Re-running an existing test with `AKTO_TEST_ID` does not send auto-ticketing details; tickets then follow the config stored on that test run.

### Important Notes

* Make sure your Jira integration is properly set up in Akto before using the auto-create feature.
* Tickets are only created for the severity levels you specify, helping avoid unnecessary clutter in your Jira backlog.
* The account must have the Jira integration plan feature enabled.

### Need Help Setting Up Jira Integration?

Check out our step-by-step guide to set up Jira integration here: [Jira Integration Guide](https://docs.akto.io/issues/how-to/jira-integration)
