# Scan Results

Agentic security scan results provide insights into the security posture of your AI agents and agentic systems. Results are generated through systematic security testing that evaluates agent behaviors, tool permissions, and vulnerability responses. View all scan results and take action in one place.

To view results, navigate to **Agentic Red Teaming > Results** and select the test from your scan results.

## Viewing Scan Details

Each scan result displays comprehensive information about detected vulnerabilities:

**Severity**: Indicates risk level (Critical, High, Medium, Low)

**Agent Component**: Shows the specific agent tool or endpoint tested

**Hostname**: Identifies the host where the component is running

**Auth Type**: Displays authentication method used

**Access Type**: Shows whether the component is public, private, or partner

**Sensitive Data**: Indicates if sensitive data exposure was detected

**Detected**: Timestamp of when the vulnerability was first found

**Impact**: Describes the potential security impact

**Tags**: Category tags (OWASP, DB Leak, Connection String Exposure, etc.)

**References**: Links to relevant vulnerability documentation

### Scan Result Timeline

View the timeline of scan attempts to understand how vulnerabilities were detected and validated across multiple test iterations.

### Request and Response Analysis

Examine detailed request payloads and response data to understand exactly how the vulnerability manifests, including any prompt injection payloads, tool calls, or malicious inputs used during testing.

### Evidence as Agentic Conversation

The **Evidence** section displays scan results as a chronological agentic conversation. The conversation records how the agent executed the test and how tools responded during the scan.

#### **What the Evidence Shows**

The Evidence view includes:

* The tested interaction describing the security behaviour evaluated
* The agent response showing the sequence of tool invocations
*   The exact outputs returned by each tool

    <figure><img src="../../../.gitbook/assets/image (42).png" alt="" width="563"><figcaption></figcaption></figure>

