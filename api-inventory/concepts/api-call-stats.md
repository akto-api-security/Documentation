# API Call Stats

The **API Call Stats** tab provides detailed insights into the usage patterns of a specific API endpoint, allowing you to monitor traffic volume and detect anomalies effectively.

<figure><img src="../../.gitbook/assets/image (109).png" alt=""><figcaption></figcaption></figure>

The **API Call Stats** tab provides a detailed view of how an API endpoint is being used over time. It helps identify traffic patterns, detect anomalies, and understand user behavior.

### **How to Access:**

1. Go to the **Discovery** section in the Akto dashboard.
2. Click on a **Collection** to view the grouped API endpoints.
3. Select an **Endpoint** from the list.
4. In the right-hand **API details** pane, navigate to the **"API Call Stats"** tab.

### Time Range Selection

At the top of the tab, you can choose the time interval to analyze traffic trends. Available intervals include:

* 15 minutes
* 30 minutes
* 1 hour
* 3 hours
* 6 hours
* 12 hours
* 1 day
* 7 days

This allows you to view recent activity spikes or analyze long-term patterns.

### Graph 1: API Call Count Over Time

**What it shows:**\
This time series chart displays the number of times the selected API endpoint was called during the chosen interval.

**How to use it:**

* Spot spikes or drops in usage that may indicate incidents or load changes.
* Identify peak usage periods and correlate with deployment, issues, or user activity.

### Graph 2: API Call Frequency Distribution

**What it shows:**\
This histogram visualizes how many users are making a specific number of API calls. It shows the distribution of call volume across users.

**How to use it:**

* Identify high-frequency users (potentially automated systems or abuse).
* Understand general usage patterns — whether most users are casual or intensive.
* Pinpoint outliers and investigate unusual behavior.
