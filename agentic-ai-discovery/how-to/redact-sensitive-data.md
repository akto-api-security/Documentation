---
description: Protect sensitive data by redacting it from the Akto dashboard and logs.
---

# Redact Sensitive Data

Redact sensitive data to comply with privacy regulations and prevent unauthorized access. Critical for agent systems handling PII and credentials.

## Redaction Levels

1. **By Data Type**: Redact all instances of a data type (e.g., all API keys)
2. **By Collection**: Redact entire agent/MCP collection
3. **Global**: Redact all data across all agents

## Important Note

{% hint style="warning" %}
Redacting data affects security testing. Without stored values, agent requests can't be replayed and tested.
{% endhint %}

## How Redaction Works

Values are replaced with `*****`:
```json
{"agent_prompt": "*****", "llm_response": "*****"}
```

## Redact by Data Type

1. Go to **Agentic Discovery > Sensitive Data**
2. Select data type
3. Click **Edit**
4. Set **Redact this data type** to **True**

## Redact by Collection

1. Open the agent/MCP collection
2. Click **More options**
3. Select **Redact**
4. Click **Enable**

## Redact All Data

1. Go to **Settings > About**
2. Click **Redact data**
3. Confirm (affects all collections)
