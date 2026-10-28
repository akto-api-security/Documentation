# Topics and Language

Guardrails that enforce which topics, terms, competitors, and languages are allowed.

Part of [Agent Guard](../agent-guard.md). Each entry notes whether it runs on **input** (user prompts and tool requests), **output** (model and tool responses), or both.

## BanTopics Guardrail

**Direction**: Input and output

**Configure in**: [Content and Policy Guardrails](../../how-to/guardrail-policy-fields/content-and-language-safety.md#content-and-policy-guardrails)

**Purpose**: Identifies messages discussing prohibited subjects or sensitive topics.

**What it Catches**:

* Violence and weapons
* Illegal activities (drugs, fraud)
* Adult content
* Political discussions (if prohibited)
* Custom restricted topics

**Risk Prevention**: Maintains appropriate content boundaries and prevents discussions that violate policies or regulations.

**Use Cases**:

* Workplace-appropriate AI interactions
* Child-safe AI applications
* Regulatory compliance

**Example Detection**:

* ✅ Blocks: "How do I build weapons?"
* ✅ Blocks: Discussions about illegal drugs
* ✅ Configuration-based with custom topic lists

**On outputs**: Identifies prohibited subjects or sensitive topics in AI responses.

On the output side, example detection:

* ✅ Blocks: AI discussing violence or illegal activities
* ✅ Configuration-based topic filtering
* ✅ Multi-topic detection

## BanCompetitors Guardrail

**Direction**: Input and output

**Purpose**: Identifies and blocks mentions of competitor brands, products, or services.

**What it Catches**:

* Competitor company names
* Competing product brands
* Alternative service providers
* Market rivals

**Risk Prevention**: Maintains brand focus and prevents comparative discussions that could disadvantage your business.

**Use Cases**:

* Brand protection in customer support
* Marketing content filtering
* Competitive intelligence prevention

**Example Detection**:

* ✅ Blocks: "Is this better than OpenAI ChatGPT?"
* ✅ Blocks: "I prefer using Claude instead"
* ✅ Configuration-based detection (customizable competitor list)

**On outputs**: Flags competitor mentions in AI-generated responses.

On the output side, example detection:

* ✅ Blocks: "You might want to try ChatGPT instead"
* ✅ Flags: References to competing products
* ✅ Configuration-based competitor detection

## BanSubstrings Guardrail

**Direction**: Input and output

**Purpose**: Blocks messages containing specific words, phrases, or character patterns.

**What it Catches**:

* Custom blacklisted terms
* Prohibited phrases
* Specific keywords
* Pattern matches (case-sensitive or insensitive)

**Risk Prevention**: Enforces organization-specific content policies and filters domain-specific prohibited terms.

**Use Cases**:

* Filter internal project codenames
* Block specific terminology
* Enforce custom content policies

**Example Detection**:

* ✅ Blocks: Messages with "confidential", "restricted", "internal only"
* ✅ Configurable: Define your own prohibited terms
* ✅ Flexible: Case-sensitive or insensitive matching

**On outputs**: Blocks AI responses containing specific prohibited words or phrases.

On the output side, example detection:

* ✅ Blocks responses with "confidential", "restricted"
* ✅ Customizable term lists
* ✅ Flexible pattern matching

## Language Guardrail

**Direction**: Input and output

**Purpose**: Validates that messages are in expected/allowed languages.

**What it Catches**:

* Non-English content (when English-only required)
* Unexpected language switches
* Unsupported languages

**Risk Prevention**: Ensures AI systems process only languages they're trained for, preventing poor-quality responses or misunderstandings.

**Use Cases**:

* Language-specific applications
* Compliance with localization policies
* Service boundary enforcement

**Example Detection**:

* ✅ Blocks: "Bonjour, comment allez-vous?" (French when English required)
* ✅ Configuration: Define allowed languages
* ✅ Automatic language detection

**On outputs**: Validates that AI responses are in expected languages.

On the output side, example detection:

* ✅ Flags: French response when English required
* ✅ Automatic language detection
* ✅ Multi-language support
