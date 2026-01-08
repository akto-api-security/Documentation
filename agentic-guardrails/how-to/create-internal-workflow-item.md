# Create Internal Workflow Item

## **Overview**

When you review a guardrail activity in Akto, you may need to involve internal teams for deeper investigation, tracking, or coordinated remediation. You can create workflow items directly from the guardrail activity details, including Jira tickets or internal work items, ensuring smooth cross-team collaboration.

## **Create Jira Ticket**

### **Prerequisites**

Before creating Jira tickets from Akto, ensure that your Jira account is integrated with Akto.

If not yet configured, complete the setup here: **Set up Jira Integration**

### **Steps**

{% stepper %}
{% step %}
Navigate to **Guardrail Activity** under **Agentic Guardrails**.
{% endstep %}

{% step %}
Open the **activity details** for the guardrail event you want to send to Jira.
{% endstep %}

{% step %}
On the right panel, select **Create Jira Ticket**.
{% endstep %}

{% step %}
In the dialog box, choose the **Jira project** and **issue type** from the dropdown options.
{% endstep %}

{% step %}
Click **Create Ticket**.
{% endstep %}
{% endstepper %}

Akto will automatically generate the Jira ticket with the selected configuration.

## **Create Work Item**

If your team uses internal workflows within Akto, you can log and assign tasks using **Work Items**.

### **Prerequisite**

Before creating Jira tickets from Akto, ensure that your Azure DevOps Board is integrated with Akto. Follow for [**Integrations Setup**](/broken/pages/KRajfTWw91KllsU24SAE)

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
{% endstep %}

{% step %}
Choose details such as title, description, severity, assignee, or notes for internal tracking.
{% endstep %}

{% step %}
Save the work item.
{% endstep %}
{% endstepper %}
