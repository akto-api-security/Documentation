# Content Safety

Guardrails that moderate toxic, abusive, biased, off-topic, or over-cautious content.

Part of [Agent Guard](../agent-guard.md). Each entry notes whether it runs on **input** (user prompts and tool requests), **output** (model and tool responses), or both.

## Toxicity Guardrail

Identifies offensive, abusive, or harmful language in user inputs.

| Direction | Configure in |
|---|---|
| Input and output | [Content and Policy Guardrails](../../how-to/guardrail-policy-fields/content-and-language-safety.md#content-and-policy-guardrails) |

**What it catches**

* Profanity and vulgar language
* Personal attacks and insults
* Hate speech
* Threatening language
* Sexually explicit content

{% hint style="info" %}
**Risk prevention**: Maintains a safe, professional environment by filtering toxic communication before it reaches AI systems or other users.
{% endhint %}

**Use cases**

* Content moderation in chat applications
* Professional communication enforcement
* Community guideline compliance

**Example**

| Input | Result |
|---|---|
| "You are stupid and worthless!" | Blocked |
| Messages with profanity or hate speech | Blocked |
| "This is disappointing" (negative but not toxic) | Allowed |

**Performance**: ONNX-optimized for real-time toxicity detection.

**On outputs**: Identifies offensive, harmful, or inappropriate content in AI-generated responses.

**Output example**

| Input | Result |
|---|---|
| AI responses containing insults or profanity | Blocked |

* Prevents aggressive or harmful suggestions
* Maintains professional tone

## Profanity Guardrail

Detects and redacts offensive, abusive, or inappropriate language from inputs and outputs.

| Direction | Configure in |
|---|---|
| Input and output | [Language Safety and Abuse](../../how-to/guardrail-policy-fields/content-and-language-safety.md#language-safety-and-abuse-guardrails) |

**What it does**

* Identifies profanity and abusive language
* Redacts offensive words or phrases
* Supports custom word and phrase filtering
* Applies filtering across user inputs and model responses

{% hint style="info" %}
**Risk prevention**: Prevents harmful, offensive, or non-compliant language from being processed or generated.
{% endhint %}

**Use cases**

* Content moderation for user interactions
* Blocking abusive or toxic language
* Enforcing brand-safe communication
* Filtering organization-specific restricted words

**Example**

| Stage | Example |
|---|---|
| Input | "You are a stupid idiot" |
| Configured Custom Word | "idiot" |
| Filtered Output | "You are a stupid \[REDACTED]" |

## Sentiment Guardrail

Analyzes emotional tone and sentiment in user messages.

| Direction | Configure in |
|---|---|
| Input and output | [Language Safety and Abuse](../../how-to/guardrail-policy-fields/content-and-language-safety.md#language-safety-and-abuse-guardrails) |

**What it catches**

* Extremely negative sentiment
* Positive sentiment (if threshold set)
* Neutral sentiment
* Emotional intensity

{% hint style="info" %}
**Risk prevention**: Identifies highly emotional or negative inputs that may require special handling or escalation.
{% endhint %}

**Use cases**

* Customer satisfaction monitoring
* Escalation triggering for angry customers
* Sentiment-based routing

**Example**

| Input | Result |
|---|---|
| "I absolutely hate this! Worst experience ever!" | Flagged |

* Configurable threshold for negative/positive detection
* Risk scoring based on sentiment intensity

**On outputs**: Analyzes emotional tone in AI-generated responses.

**Output example**

| Input | Result |
|---|---|
| Overly negative AI responses | Flagged |

* Configurable sentiment thresholds
* Tone analysis and scoring

## Bias Guardrail

Detects discriminatory, biased, or unfair content in AI responses.

| Direction |
|---|
| Output |

**What it catches**

* Gender bias
* Racial/ethnic bias
* Age discrimination
* Religious bias
* Stereotyping
* Unfair generalizations

{% hint style="info" %}
**Risk prevention**: Ensures AI outputs are fair, inclusive, and non-discriminatory, protecting brand reputation and compliance.
{% endhint %}

**Use cases**

* Fairness enforcement
* HR application safety
* Inclusive AI systems

**Example**

| Input | Result |
|---|---|
| "Women are naturally better at nursing" | Blocked |
| Gender stereotypes in career recommendations | Blocked |
| Racially insensitive generalizations | Flagged |

**Performance**: ONNX-optimized machine learning model.

## Relevance Guardrail

Ensures AI responses are relevant and on-topic to user queries.

| Direction |
|---|
| Output |

**What it catches**

* Off-topic responses
* Irrelevant information
* Context drift
* Hallucinated tangents

{% hint style="info" %}
**Risk prevention**: Maintains response quality by detecting when AI strays from the user's actual question.
{% endhint %}

**Use cases**

* Quality assurance
* Hallucination detection
* Response validation

**Example**

| Stage | Example |
|---|---|
| User asks | "What is the capital of France?" |
| Good response | "The capital of France is Paris" |
| Blocked response | "Bananas are yellow and monkeys like them" (irrelevant) |

**Performance**: ONNX-optimized for quick relevance checking.

## NoRefusal Guardrail

Detects when AI inappropriately refuses to answer legitimate queries.

| Direction |
|---|
| Output |

**What it catches**

* "I can't help with that" responses
* Unnecessary refusals
* Over-cautious denials
* False safety triggers

{% hint style="info" %}
**Risk prevention**: Improves user experience by identifying when AI is too restrictive or incorrectly refuses valid requests.
{% endhint %}

**Use cases**

* User experience optimization
* False positive detection
* AI behavior monitoring

**Example**

| Input | Result |
|---|---|
| "I cannot assist with that request" (when request was legitimate) | Flagged |

* Identifies over-cautious AI behavior
* Helps tune AI safety boundaries

**Performance**: ONNX-optimized for fast refusal detection.
