# Guardrail Latency

## Overview

Akto guardrails check a request before it reaches your model or tool, so a blocking guardrail adds its evaluation time to every request. This page lists measured guardrail latency and explains what makes latency go up or down.

{% hint style="info" %}
**Latency depends on the prompt.** Most benign prompts are cleared quickly. Prompts that look suspicious get a deeper check before Akto returns a verdict, so malicious traffic has a higher latency than benign traffic.
{% endhint %}

## Measured Latency

The numbers below come from a load test of Akto guardrails running on a single self-hosted deployment.

### Benign Traffic

| Sustained load | p50 | p95 | Error rate | Token throughput |
| --- | --- | --- | --- | --- |
| 15 req/s | 18 ms | 92 ms | 0% | 34,800 tokens/s |
| 30 req/s | 24 ms | 76 ms | 0% | 67,300 tokens/s |
| 40 req/s | 29 ms | 79 ms | 0.04% | 91,900 tokens/s |
| 50 req/s | 25 ms | 91 ms | 0% | 113,400 tokens/s |
| 60 req/s | 27 ms | 118 ms | 0% | 137,400 tokens/s |

### Malicious Traffic

| Sustained load | p50 | p95 | Error rate | Token throughput |
| --- | --- | --- | --- | --- |
| 15 req/s | 66 ms | 144 ms | 0% | 34,300 tokens/s |
| 30 req/s | 64 ms | 147 ms | 0% | 67,600 tokens/s |
| 45 req/s | 71 ms | 154 ms | 0% | 102,800 tokens/s |

p95 stays under 120 ms for benign traffic and under 160 ms for malicious traffic across the tested range. The p95 for benign traffic starts to rise at 60 req/s, which shows a single deployment is nearing its capacity. To serve more traffic at the same latency, add more deployments.

## What Affects Latency

| Factor | Effect |
| --- | --- |
| **Share of suspicious traffic** | Suspicious prompts get a deeper check. The more of your traffic looks suspicious, the higher the average latency. |
| **How much of the conversation is scanned** | The figures above scan the latest user message. Scanning the whole conversation on every request sends far more text to the guardrail, which raises latency sharply, especially for long conversations. |
| **Guardrails in the policy** | Pattern-based guardrails, such as Secrets or Regex Pattern, add little latency. Model-based guardrails, such as LLM Prompt Rule, take longer, and the slowest guardrail in the policy sets the latency floor. |
| **Load per deployment** | Latency stays flat until a deployment nears its capacity. Past that point, requests queue and tail latency (p95) grows quickly. |
| **Network** | Time between your application and the Akto guardrail endpoint is added on top of the figures above. Keep the guardrails close to your application, for example in the same region or cluster. |
| **Repeated prompts** | A prompt Akto has recently checked can return faster. Use distinct prompts when you benchmark, otherwise the results look better than real traffic. |

## Related Pages

* [Agent Guard](agent-guard.md)
* [Session-Based Guardrails](session-guardrails.md)
* [Guardrail Policy](threat-policy.md)
* [Guardrails as API](../overview/guardrails-api.md)
