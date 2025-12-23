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

### **How the Jira Ticket Appears**

After creation, you will see a confirmation summary in Akto. Below is an example of how the ticket typically appears:
