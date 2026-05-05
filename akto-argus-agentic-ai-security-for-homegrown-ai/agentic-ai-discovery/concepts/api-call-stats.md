---
hidden: true
---

# Agent Component Usage Stats

The **Agent Component Usage Stats** tab provides a detailed view of how an agent component or MCP endpoint is being used over time. It helps identify usage patterns, detect anomalies, and understand agent behavior.

## How to Access

1. Go to the **Agentic Discovery** section in the Akto dashboard
2. Click on a **Collection** to view the grouped agent components
3. Select a **Component** from the list
4. In the right-hand **Component details** pane, navigate to the **"Usage Stats"** tab

## Time Range Selection

At the top of the tab, you can choose the time interval to analyze traffic trends. Available intervals include:

- 15 minutes
- 30 minutes
- 1 hour
- 3 hours
- 6 hours
- 12 hours
- 1 day
- 7 days

This allows you to view recent activity spikes or analyze long-term patterns.

## Graph 1: Component Invocation Count Over Time

**What it shows:**
This time series chart displays the number of times the selected agent component was invoked during the chosen interval.

**How to use it:**

- Spot spikes or drops in usage that may indicate incidents or load changes
- Identify peak usage periods and correlate with deployments, issues, or user activity
- Monitor agent component health and availability
- Detect unusual invocation patterns that might indicate security issues

## Graph 2: Component Invocation Frequency Distribution

**What it shows:**
This histogram visualizes how many users or agents are making a specific number of component invocations. It shows the distribution of call volume across users and systems.

**How to use it:**

- Identify high-frequency users (potentially automated systems or abuse)
- Understand general usage patterns — whether most invocations are casual or intensive
- Pinpoint outliers and investigate unusual behavior
- Detect potential denial-of-service or resource exhaustion attacks on agent components

## Use Cases

- **Performance Monitoring**: Track agent component response times and availability
- **Security Analysis**: Detect unusual invocation patterns that might indicate attacks
- **Capacity Planning**: Understand peak usage to scale infrastructure appropriately
- **Anomaly Detection**: Identify sudden changes in component usage patterns
