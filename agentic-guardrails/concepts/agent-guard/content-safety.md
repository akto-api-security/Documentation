# Content Safety

Guardrails that moderate toxic, abusive, biased, off-topic, or over-cautious content.

Part of the [Agent Guard](../agent-guard.md) scanner reference. Each entry notes whether it runs on **input** (user prompts and tool requests), **output** (model and tool responses), or both.

## Toxicity Guardrail

**Direction**: Input and output

**Purpose**: Identifies offensive, abusive, or harmful language in user inputs.

**What it Catches**:

* Profanity and vulgar language
* Personal attacks and insults
* Hate speech
* Threatening language
* Sexually explicit content

**Risk Prevention**: Maintains a safe, professional environment by filtering toxic communication before it reaches AI systems or other users.

**Use Cases**:

* Content moderation in chat applications
* Professional communication enforcement
* Community guideline compliance

**Example Detection**:

* ✅ Blocks: "You are stupid and worthless!"
* ✅ Blocks: Messages with profanity or hate speech
* ✅ Allows: "This is disappointing" (negative but not toxic)

**Performance**: ONNX-optimized for \~500ms response time after initial model load.

**On outputs**: Identifies offensive, harmful, or inappropriate content in AI-generated responses.

On the output side, example detection:

* ✅ Blocks: AI responses containing insults or profanity
* ✅ Prevents aggressive or harmful suggestions
* ✅ Maintains professional tone

**Performance**: ONNX-optimized for real-time toxicity detection.

## Profanity Guardrail

**Direction**: Input and output

**Purpose:** Detects and redacts offensive, abusive, or inappropriate language from inputs and outputs.

**What it Does:**

* Identifies profanity and abusive language
* Redacts offensive words or phrases
* Supports custom word and phrase filtering
* Applies filtering across user inputs and model responses

**Risk Prevention:** Prevents harmful, offensive, or non-compliant language from being processed or generated.

**Use Cases:**

* Content moderation for user interactions
* Blocking abusive or toxic language
* Enforcing brand-safe communication
* Filtering organization-specific restricted words

**Example Transformation:**

* Input:\
  "You are a stupid idiot"
* Configured Custom Word:\
  "idiot"
* Filtered Output:\
  "You are a stupid \[REDACTED]"

## Sentiment Guardrail

**Direction**: Input and output

**Purpose**: Analyzes emotional tone and sentiment in user messages.

**What it Catches**:

* Extremely negative sentiment
* Positive sentiment (if threshold set)
* Neutral sentiment
* Emotional intensity

**Risk Prevention**: Identifies highly emotional or negative inputs that may require special handling or escalation.

**Use Cases**:

* Customer satisfaction monitoring
* Escalation triggering for angry customers
* Sentiment-based routing

**Example Detection**:

* ✅ Flags: "I absolutely hate this! Worst experience ever!"
* ✅ Configurable threshold for negative/positive detection
* ✅ Risk scoring based on sentiment intensity

**On outputs**: Analyzes emotional tone in AI-generated responses.

On the output side, example detection:

* ✅ Flags: Overly negative AI responses
* ✅ Configurable sentiment thresholds
* ✅ Tone analysis and scoring

## Bias Guardrail

**Direction**: Output

**Purpose**: Detects discriminatory, biased, or unfair content in AI responses.

**What it Catches**:

* Gender bias
* Racial/ethnic bias
* Age discrimination
* Religious bias
* Stereotyping
* Unfair generalizations

**Risk Prevention**: Ensures AI outputs are fair, inclusive, and non-discriminatory, protecting brand reputation and compliance.

**Use Cases**:

* Fairness enforcement
* HR application safety
* Inclusive AI systems

**Example Detection**:

* ✅ Blocks: "Women are naturally better at nursing"
* ✅ Blocks: Gender stereotypes in career recommendations
* ✅ Flags: Racially insensitive generalizations

**Performance**: ONNX-optimized machine learning model.

## Relevance Guardrail

**Direction**: Output

**Purpose**: Ensures AI responses are relevant and on-topic to user queries.

**What it Catches**:

* Off-topic responses
* Irrelevant information
* Context drift
* Hallucinated tangents

**Risk Prevention**: Maintains response quality by detecting when AI strays from the user's actual question.

**Use Cases**:

* Quality assurance
* Hallucination detection
* Response validation

**Example Detection**:

* ✅ User asks: "What is the capital of France?"
* ✅ Good response: "The capital of France is Paris"
* ✅ Blocks: "Bananas are yellow and monkeys like them" (irrelevant)

**Performance**: ONNX-optimized for quick relevance checking.

## NoRefusal Guardrail

**Direction**: Output

**Purpose**: Detects when AI inappropriately refuses to answer legitimate queries.

**What it Catches**:

* "I can't help with that" responses
* Unnecessary refusals
* Over-cautious denials
* False safety triggers

**Risk Prevention**: Improves user experience by identifying when AI is too restrictive or incorrectly refuses valid requests.

**Use Cases**:

* User experience optimization
* False positive detection
* AI behavior monitoring

**Example Detection**:

* ✅ Flags: "I cannot assist with that request" (when request was legitimate)
* ✅ Identifies over-cautious AI behavior
* ✅ Helps tune AI safety boundaries

**Performance**: ONNX-optimized for fast refusal detection.
