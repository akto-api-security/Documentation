# Auto-Create Jira Tickets

Akto automates issue tracking by allowing auto-creation of Jira tickets whenever security tests are run. This ensures vulnerabilities found in agent components are automatically logged in Jira, helping teams track critical fixes without manual intervention.

## How It Works

When setting up a test run in Akto, enable the **Auto-create tickets** option. Akto will automatically create Jira tickets based on detected vulnerabilities.

## Configuration Options

**Environment Selection**: Choose the environment (PROD, DEV, STAGING) where the test is executed.

**Ticket Type**: Define the type of Jira ticket to create (Task, Bug, Story).

**Severity Filter**: Specify severity levels (Critical, High, Medium, Low) for which tickets should be automatically generated.

## Benefits

**Seamless Integration**: Automatically log issues in Jira without manual effort.

**Real-Time Tracking**: Ensure vulnerabilities are tracked as soon as they're discovered.

**Customizable**: Configure ticket types, environments, and severity filters to fit your workflow.

## Important Notes

Ensure your Jira integration is properly set up in Akto before using the auto-create feature.

Tickets are only created for the severity levels you specify, helping avoid unnecessary clutter in your Jira backlog.
