---
description: AI-driven API security testing that reasons, acts, and iterates to find vulnerabilities.
---

# Smart Automated Testing

Smart Automated Testing is Akto's AI-powered testing mode where an intelligent agent takes over the execution of security tests. Rather than mechanically replaying pre-defined payloads, the agent reasons about each test, forms a plan, executes HTTP requests, observes the response, and refines its approach across multiple attempts — all to determine whether a vulnerability is real.

## How It Works

The agent follows a **Think → Plan → Act → Observe** loop, repeating until it either confirms a vulnerability or exhausts its attempts. Each iteration builds on what the previous one learned.

### Execution Loop

| Step | What Happens |
|------|-------------|
| **Thinking** | The agent reads the test scenario and baseline request, then reasons about what a successful exploit would look like — which parameters to change, what response signals matter (status code, body similarity, error messages). |
| **Plan (Attempt N)** | Before sending a request, the agent decides exactly what to change and why — e.g., swap the auth token with a different user's token, alter an object ID, or craft a malformed payload. |
| **Action (Attempt N)** | The agent sends the crafted HTTP request. The full request is logged: method, URL, headers, and body. |
| **Observation (Attempt N)** | The agent reads the response — status code, body, headers — and judges whether it indicates a vulnerable or secure state. If the response is not conclusive, it adjusts and tries again. |

Attempts continue sequentially, with each one improving on the last based on what the previous observation revealed. The final step is **Vulnerability Validation**, where the agent makes a definitive determination based on all accumulated evidence.

### Vulnerability Validation

At the end of the loop, the agent validates the vulnerability by checking the key indicators defined in the test scenario — for example:

- HTTP response code is `2XX`
- Response body matches the baseline by more than 90%
- No error message is present in the body

If the criteria are met, the issue is flagged as confirmed.

## How to Run Smart Automated Tests

Smart Automated Testing runs the same way as standard tests — you select the tests you want to run, and the AI agent executes them.

1. Go to **Testing** and open a collection or endpoint.
2. Click **Run Test** and select the tests (by test name or category).
3. Choose **Smart Automated Testing** as the testing mode.
4. The agent will reference the selected test definitions and begin the execution loop.

The agent uses the test ID and its associated YAML definition to understand the scenario — what vulnerability to test for, what parameters to manipulate, and what response conditions confirm a finding.

## Viewing the AI Execution Trace

Each Smart Automated Testing run produces a detailed **AI Execution Trace** visible in the test result. See [AI Execution Trace in Test Results](test-result.md#ai-execution-trace) for details on reading the trace.

## Key Differences from Standard Testing

| | Standard Testing | Smart Automated Testing |
|--|--|--|
| Execution | Fixed payload templates | AI-reasoned, adaptive requests |
| Attempts | Single pass | Multiple attempts, each improving on the last |
| Transparency | Request/response logs | Full reasoning trace (Thinking, Plan, Action, Observation) |
| Validation | Rule-based matchers | AI-driven judgment with evidence |
