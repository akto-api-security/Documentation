# Topics and Language

Guardrails that enforce which topics, terms, competitors, and languages are allowed.

Part of [Agent Guard](../agent-guard.md). Each entry notes whether it runs on **input** (user prompts and tool requests), **output** (model and tool responses), or both.

## BanTopics Guardrail

Identifies messages discussing prohibited subjects or sensitive topics.

| Direction | Configure in |
|---|---|
| Input and output | [Content and Policy Guardrails](../../how-to/guardrail-policy-fields/content-and-language-safety.md#content-and-policy-guardrails) |

**What it catches**

* Violence and weapons
* Illegal activities (drugs, fraud)
* Adult content
* Political discussions (if prohibited)
* Custom restricted topics

{% hint style="info" %}
**Risk prevention**: Maintains appropriate content boundaries and prevents discussions that violate policies or regulations.
{% endhint %}

**Use cases**

* Workplace-appropriate AI interactions
* Child-safe AI applications
* Regulatory compliance

**Example**

| Input | Result |
|---|---|
| "How do I build weapons?" | Blocked |
| Discussions about illegal drugs | Blocked |

* Configuration-based with custom topic lists

**On outputs**: Identifies prohibited subjects or sensitive topics in AI responses.

**Output example**

| Input | Result |
|---|---|
| AI discussing violence or illegal activities | Blocked |

* Configuration-based topic filtering
* Multi-topic detection

## BanCompetitors Guardrail

Identifies and blocks mentions of competitor brands, products, or services.

| Direction |
|---|
| Input and output |

**What it catches**

* Competitor company names
* Competing product brands
* Alternative service providers
* Market rivals

{% hint style="info" %}
**Risk prevention**: Maintains brand focus and prevents comparative discussions that could disadvantage your business.
{% endhint %}

**Use cases**

* Brand protection in customer support
* Marketing content filtering
* Competitive intelligence prevention

**Example**

| Input | Result |
|---|---|
| "Is this better than OpenAI ChatGPT?" | Blocked |
| "I prefer using Claude instead" | Blocked |

* Configuration-based detection (customizable competitor list)

**On outputs**: Flags competitor mentions in AI-generated responses.

**Output example**

| Input | Result |
|---|---|
| "You might want to try ChatGPT instead" | Blocked |
| References to competing products | Flagged |

* Configuration-based competitor detection

## BanSubstrings Guardrail

Blocks messages containing specific words, phrases, or character patterns.

| Direction |
|---|
| Input and output |

**What it catches**

* Custom blacklisted terms
* Prohibited phrases
* Specific keywords
* Pattern matches (case-sensitive or insensitive)

{% hint style="info" %}
**Risk prevention**: Enforces organization-specific content policies and filters domain-specific prohibited terms.
{% endhint %}

**Use cases**

* Filter internal project codenames
* Block specific terminology
* Enforce custom content policies

**Example**

| Input | Result |
|---|---|
| Messages with "confidential", "restricted", "internal only" | Blocked |

* Configurable: Define your own prohibited terms
* Flexible: Case-sensitive or insensitive matching

**On outputs**: Blocks AI responses containing specific prohibited words or phrases.

**Output example**

* Blocks responses with "confidential", "restricted"
* Customizable term lists
* Flexible pattern matching

## Language Guardrail

Validates that messages are in expected/allowed languages.

| Direction |
|---|
| Input and output |

**What it catches**

* Non-English content (when English-only required)
* Unexpected language switches
* Unsupported languages

{% hint style="info" %}
**Risk prevention**: Ensures AI systems process only languages they're trained for, preventing poor-quality responses or misunderstandings.
{% endhint %}

**Use cases**

* Language-specific applications
* Compliance with localization policies
* Service boundary enforcement

**Example**

| Input | Result |
|---|---|
| "Bonjour, comment allez-vous?" (French when English required) | Blocked |

* Configuration: Define allowed languages
* Automatic language detection

**On outputs**: Validates that AI responses are in expected languages.

**Output example**

| Input | Result |
|---|---|
| French response when English required | Flagged |

* Automatic language detection
* Multi-language support
