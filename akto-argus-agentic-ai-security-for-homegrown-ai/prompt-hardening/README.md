# Prompt Hardening

## Overview

Prompt Hardening supports security testing of AI agents against prompt injection and related adversarial techniques. Prompt Hardening focuses on identifying unsafe responses, policy violations, and unintended agent behaviour triggered by malicious prompts. This capability helps enterprise security and platform teams validate AI agent resilience before production exposure.

Prompt Hardening is part of the **Agentic Security** product and supports controlled, repeatable testing workflows for AI-driven systems.

<figure><img src="../../.gitbook/assets/image (40).png" alt="" width="563"><figcaption></figcaption></figure>

## Prompt Types Available for Testing

Prompt Hardening provides structured prompt sources to support both targeted and exploratory testing.

### Custom Security Prompts

Custom Security Prompts allow you to test specific attack classes with precise intent.

1. **Tool Misuse**\
   Evaluates whether an AI agent invokes tools or actions beyond intended authorisation.
2. **Data Leakage**\
   Tests whether an AI agent exposes sensitive, private, or restricted data.
3. **Prompt Injection**\
   Assesses whether an AI agent follows malicious instructions embedded in user input.
4. **Policy Evasion**\
   Validates whether an AI agent bypasses internal governance, safety, or compliance controls.
5. **Jailbreak & Safety Bypass**\
   Tests attempts to override system-level safeguards and safety boundaries.

### Akto Default

The Akto Security Prompt Library provides curated prompts aligned with common enterprise AI risk scenarios.

* **Security Testing**\
  Focuses on vulnerability discovery and unsafe agent behaviour.
* **Performance Testing**\
  Evaluates response stability, consistency, and behaviour under edge conditions.

## Next Step

After reviewing available prompt types, you can proceed to [hands-on testing and configuration](play-around-in-prompt-hardening.md).
