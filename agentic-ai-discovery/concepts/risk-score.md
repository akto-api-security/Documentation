# Risk Score

## What is Risk score?

Risk score is calculated based on the amount of sensitive information the agent component exposes and its current security status. Akto automatically assigns a risk score to each agent component, MCP endpoint, and collection.

Using the risk score provided by Akto, you can prioritize which agent components require additional security measures. Components with higher risk scores may necessitate stricter security controls, such as stronger authentication, rate limiting, or increased monitoring.

### How We Calculate Risk?

Your agent component's risk score is the sum of these four factors (capped at 5):

#### 1. Security Issue Severity

Based on the highest severity issue found:

* High severity issues: 2 points
* Medium severity issues: 1 point
* Low severity issues: 0.5 points
* No issues: 0 points

#### 2. Recent Discovery

Time-based scoring:

* Discovered in the last 30 days: +1 point
* Older discoveries: 0 points

#### 3. Sensitive Data Exposure

Response data analysis:

* Contains sensitive data: +1 point
* No sensitive data: 0 points

#### 4. Public Accessibility

Component exposure level:

* Publicly accessible: +1 point
* Internal/private: 0 points

### Example

An agent component could score 5 points if it:

* Has a high-severity issue (2 points)
* Was discovered last week (+1 point)
* Exposes sensitive data (+1 point)
* Is publicly accessible (+1 point)

## Risk scores on Akto dashboard

Go to **Agentic Discovery > Collections**. Here you can view the risk score of agent collections and MCP collections. To view the risk score of specific components within a collection, select the relevant collection.

Risk scores help you prioritize which agent components and MCP endpoints need immediate security attention based on their exposure, sensitivity, and current vulnerabilities.
