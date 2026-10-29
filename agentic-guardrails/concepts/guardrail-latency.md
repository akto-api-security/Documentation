# Guardrail Latency

## Overview

Akto guardrails check a request before it reaches your model or tool, so a blocking guardrail adds its evaluation time to every request. This page lists measured guardrail latency and explains what makes latency go up or down.

{% hint style="info" %}
**Latency depends on the prompt.** Most benign prompts are cleared quickly. Prompts that look suspicious get a deeper check before Akto returns a verdict, so malicious traffic has a higher latency than benign traffic.
{% endhint %}

## Measured Latency

The numbers below come from a load test of Akto guardrails running on a single self-hosted deployment.

### Benign Traffic

| Sustained load | p50 | p95 | Token throughput |
| --- | --- | --- | --- |
| 15 req/s | 18 ms | 140 ms | 34,800 tokens/s |
| 30 req/s | 24 ms | 157 ms | 67,300 tokens/s |
| 40 req/s | 29 ms | 134 ms | 91,900 tokens/s |
| 50 req/s | 25 ms | 297 ms | 113,400 tokens/s |
| 60 req/s | 27 ms | 488 ms | 137,400 tokens/s |

### Malicious Traffic

| Sustained load | p50 | p95 | Token throughput |
| --- | --- | --- | --- |
| 15 req/s | 66 ms | 282 ms | 34,300 tokens/s |
| 30 req/s | 64 ms | 216 ms | 67,600 tokens/s |
| 45 req/s | 71 ms | 299 ms | 102,800 tokens/s |

p95 stays under 160 ms for benign traffic up to 40 req/s and under 300 ms for malicious traffic across the tested range. The p95 for benign traffic starts to rise at 50 req/s and above, which shows a single deployment is nearing its capacity. To serve more traffic at the same latency, add more deployments.

### PII Redaction

When PII redaction is enabled, Akto finds and masks each sensitive value before returning the prompt, so latency grows with the number of values redacted in the prompt.

As a rough guide, a prompt with one redacted value (a person's name) measured over 100 sequential requests:

| Redacted values | p50 | p95 |
| --- | --- | --- |
| 1 | 116 ms | 127 ms |

Prompts with more redacted values take longer.

## What Affects Latency

| Factor | Effect |
| --- | --- |
| **Share of suspicious traffic** | Suspicious prompts get a deeper check. The more of your traffic looks suspicious, the higher the average latency. |
| **How much of the conversation is scanned** | The figures above scan the latest user message. Scanning the whole conversation on every request sends far more text to the guardrail, which raises latency sharply, especially for long conversations. |
| **Guardrails in the policy** | Pattern-based guardrails, such as Secrets or Regex Pattern, add little latency. Model-based guardrails, such as LLM Prompt Rule, take longer, and the slowest guardrail in the policy sets the latency floor. |
| **Load per deployment** | Latency stays flat until a deployment nears its capacity. Past that point, requests queue and tail latency (p95) grows quickly. |
| **PII redaction** | Each value that is redacted adds time, so prompts with many sensitive values take longer. See [PII Redaction](#pii-redaction). |
| **Network** | Time between your application and the Akto guardrail endpoint is added on top of the figures above. Keep the guardrails close to your application, for example in the same region or cluster. |
| **Repeated prompts** | A prompt Akto has recently checked can return faster. Use distinct prompts when you benchmark, otherwise the results look better than real traffic. |

## Related Pages

* [Agent Guard](agent-guard.md)
* [Session-Based Guardrails](session-guardrails.md)
* [Guardrail Policy](threat-policy.md)
* [Guardrails as API](../overview/guardrails-api.md)
