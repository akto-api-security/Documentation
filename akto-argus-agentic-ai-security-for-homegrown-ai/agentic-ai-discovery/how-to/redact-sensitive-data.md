---
description: >-
  Sensitive data in agent traffic is redacted automatically. No configuration
  needed.
---

# Redact sensitive data

Akto redacts sensitive data in agent and MCP traffic automatically. There are no settings to enable and no redaction levels to choose.

Agent prompts and responses often contain PII and credentials. Automatic redaction lets your team review agent activity without exposing that data.

## Where Redaction Applies

| Where                  | Who sees redacted data                        |
| ---------------------- | --------------------------------------------- |
| **Guardrail Activity** | Everyone. Data is always redacted.            |
| **Traces**             | Everyone except admins. Admins see full data. |

## How Redaction Works

Akto detects sensitive values in requests and responses and replaces each one with `[REDACTED]`. Only the sensitive values are replaced. The rest of the content stays readable, so you can still follow what the agent did.

```
... delta3 echo4 foxtrot5 golf6 [REDACTED] papa15 alpha16 bravo17 ...
```

## Guardrail Activity

In **Guardrail Activity**, open an event to view its **Request** and **Response**. Detected sensitive values are shown as `[REDACTED]`. This applies to all users, including admins.

<div data-with-frame="true"><figure><img src="../../../.gitbook/assets/image (251).png" alt="" width="563"><figcaption></figcaption></figure></div>

## Traces

In **Traces**, what you see depends on your role:

* **Admin**: full, unredacted data
* **All other users**: redacted data, with sensitive values shown as `[REDACTED]`

## Important Notes

* Redaction is automatic. You do not need to configure it.
* Admins can see full data in **Traces**, so give the admin role only to people who are allowed to view sensitive data.
* The same admin sees `[REDACTED]` in **Guardrail Activity** and full data in **Traces**.
