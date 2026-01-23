# Create Internal Workflow Item

## **Overview**

When you review a threat activity in Akto, you may need to involve internal teams for deeper investigation, tracking, or coordinated remediation. You can create workflow items directly from the threat activity details, including Jira tickets or internal work items, ensuring smooth cross-team collaboration.

## **Create Jira Ticket**

### **Prerequisites**

* Before creating Jira tickets from Akto, ensure that your Jira account is integrated with Akto.
* If not yet configured, complete the setup here: [jira.md](../../integrations/jira.md "mention")

### Steps

{% stepper %}
{% step %}
Navigate to **Threat Activity** under **API Threat Detection**.
{% endstep %}

{% step %}
Open the **activity details** for the threat event you want to send to Jira.
{% endstep %}

{% step %}
On the right panel, select **Create Jira Ticket**.

<figure><img src="../../.gitbook/assets/Screenshot 2025-12-10 at 6.43.55 PM.png" alt="" width="563"><figcaption></figcaption></figure>
{% endstep %}

{% step %}
In the dialog box, choose the **Jira project** and **issue type** from the dropdown options.

<figure><img src="../../.gitbook/assets/Screenshot 2025-12-10 at 6.45.02 PM.png" alt="" width="563"><figcaption></figcaption></figure>
{% endstep %}

{% step %}
Click **Create Ticket** and Akto will automatically generate the Jira ticket with the selected configuration.
{% endstep %}
{% endstepper %}

### How the Jira Ticket Appears

After creation, you will see a confirmation summary in Akto. Below is an example of how the ticket typically appears:

<figure><img src="../../.gitbook/assets/screenshot_2025-12-17_at_12.11.22___pm_720.png" alt="" width="540"><figcaption></figcaption></figure>

## **Create Work Item**

If your team uses internal workflows within Akto, you can log and assign tasks using **Work Items**.

### **Prerequisite**

Before creating Jira tickets from Akto, ensure that your Azure DevOps Board is integrated with Akto. Follow for [**Integrations Setup**](../../integrations/azure-devops-boards.md)

### **Steps**

{% stepper %}
{% step %}
Open **Threat Activity** under **API Threat Detection**.
{% endstep %}

{% step %}
Select the threat activity that requires internal follow-up.
{% endstep %}

{% step %}
Click **Create Work Item** from the action panel.

<figure><img src="../../.gitbook/assets/image (173).png" alt="" width="563"><figcaption></figcaption></figure>
{% endstep %}

{% step %}
Choose details such as title, description, severity, assignee, or notes for internal tracking.
{% endstep %}

{% step %}
Save the work item.
{% endstep %}
{% endstepper %}
