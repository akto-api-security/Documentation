# Auto-Create Jira Tickets

Akto makes it simple to automate your issue tracking process by allowing **auto-creation of Jira tickets** whenever security tests are run. This ensures that any vulnerabilities or issues found during your tests are automatically logged in Jira, helping your team stay on top of critical fixes without manual intervention.

<figure><img src="../../.gitbook/assets/image (105).png" alt=""><figcaption></figcaption></figure>

### How It Works

When setting up a test run in Akto, you will see the option to **Auto-create tickets**. Once enabled, Akto will automatically create Jira tickets based on the vulnerabilities detected.

#### Configuration Options

* **Environment Selection:** Choose the environment (e.g., PROD, DEV) where the test is being executed.
* **Ticket Type:** Define the type of Jira ticket to be created (e.g., Task, Bug, Story).
* **Severity Filter:** Specify the severity levels (e.g., Critical, High) for which tickets should be automatically generated.

### Benefits

* **Seamless Integration:** Automatically log issues in Jira without manual effort.
* **Real-Time Tracking:** Ensure vulnerabilities are tracked as soon as they're discovered.
* **Customizable:** Configure ticket types, environments, and severity filters to fit your workflow.

### Important Notes

* Make sure your Jira integration is properly set up in Akto before using the auto-create feature.
* Tickets are only created for the severity levels you specify, helping avoid unnecessary clutter in your Jira backlog.

### Need Help Setting Up Jira Integration?

Check out our step-by-step guide to set up Jira integration here: [Jira Integration Guide](https://docs.akto.io/issues/how-to/jira-integration)
