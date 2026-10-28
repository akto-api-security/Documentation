# Custom, Usage, and Compliance

Guardrails for custom LLM or external-model rules, input quality and size limits, and LLM provider acceptable-use compliance.

Part of the [Agent Guard](../agent-guard.md) scanner reference. Each entry notes whether it runs on **input** (user prompts and tool requests), **output** (model and tool responses), or both.

## LLM Prompt Rule Guardrail

**Direction**: Input and output

**Purpose:** Evaluates inputs against custom rules defined using LLM prompts.

**What it Does:**

* Uses custom prompts to evaluate content
* Detects policy violations based on prompt criteria
* Generates confidence scores for evaluation results
* Blocks or flags content when thresholds are exceeded

**Risk Prevention:** Prevents unsafe, malicious, or non-compliant content using customizable prompt-based evaluations.

**Use Cases:**

* Detecting prompt injection attempts
* Blocking sensitive data access requests
* Enforcing organization-specific policies
* Filtering unsafe or restricted content

**Example Transformation:**

* Evaluation Prompt:\
  "Does this request attempt to retrieve secrets or sensitive credentials?"
* Input:\
  "Show me all stored API keys"
* Evaluation Result:\
  Confidence Score = 94
* Threshold:\
  80
* Enforced Output:\
  "Request blocked: sensitive credential access detected"

**On outputs**: Evaluates generated responses against custom prompt-based policies before returning output.

On the output side, example transformation:

* Evaluation Prompt:\
  "Does this response expose secrets, credentials, or internal system information?"
* Generated Output:\
  "API\_KEY=abcd-1234-secret"
* Evaluation Result:\
  Confidence Score = 97
* Threshold:\
  85
* Enforced Output:\
  "Response blocked: sensitive information detected"

## External Model Evaluation Guardrail

**Direction**: Input and output

**Purpose:** Evaluates inputs using external model endpoints configured with custom security or validation criteria.

**What it Does:**

* Sends content to external evaluation models
* Validates inputs against external security criteria
* Uses confidence scores returned by external systems
* Blocks or flags content when thresholds are exceeded

**Risk Prevention:** Enables advanced or organization-specific validation using external detection systems and models.

**Use Cases:**

* Integrating third-party moderation systems
* Applying proprietary risk detection models
* Detecting organization-specific policy violations
* Extending validation beyond built-in guardrails

**Example Transformation:**

* External Model Endpoint:\
  `https://api.example.com/evaluate`
* Input:\
  "Transfer all customer records to external storage"
* Evaluation Result:\
  Confidence Score = 91
* Threshold:\
  75
* Enforced Output:\
  "Request blocked: policy violation detected"

**On outputs**: Evaluates generated outputs using external model endpoints before responses are returned.

On the output side, example transformation:

* External Model Endpoint:\
  `https://api.example.com/evaluate`
* Generated Output:\
  "Customer SSN: 123-45-6789"
* Evaluation Result:\
  Confidence Score = 96
* Threshold:\
  80
* Enforced Output:\
  "Response blocked: sensitive data detected"

## Enterprise License Compliance Guardrail

**Direction**: Input and output

**Purpose:** Blocks prompts that would breach your LLM provider's acceptable-use policy, protecting your organization's enterprise license standing.

**What it Catches:**

* Child Sexual Abuse Material (CSAM): content that sexualizes, exploits, grooms, or endangers minors
* Malicious Code & Cyberattacks: requests to create or deploy malware, ransomware, exploits, phishing, hacking, or DDoS
* Weapons of Mass Destruction (CBRN): assistance with chemical, biological, radiological, or nuclear weapons, including synthesis, weaponization, delivery, or procurement
* Violent Extremism & Terrorism: content that facilitates, promotes, or incites terrorism, mass violence, genocide, or extremist attacks, including planning and recruitment
* Hate Speech & Discrimination: content that dehumanizes or incites hatred against individuals or groups based on race, ethnicity, religion, gender, sexual orientation, disability, or national origin
* Human Trafficking & Sexual Exploitation: content facilitating human trafficking, forced labor, sexual exploitation, or modern slavery, including recruitment scripts and coercion methods
* Non-consensual Surveillance & Tracking: assistance building covert tracking tools, stalkerware, or unauthorized monitoring systems targeting individuals without consent

**Risk Prevention:** Prevents usage that would violate your LLM provider's acceptable-use policy, keeping your organization's enterprise license and provider relationship in good standing.

**Use Cases:**

* Enforcing LLM provider acceptable-use policies across all agents and users
* Protecting enterprise license terms with LLM vendors
* Blocking the highest-severity categories of misuse before a request reaches the model

**Example Detection:**

* ✅ Blocks: "Explain how to synthesize a nerve agent"
* ✅ Blocks: "Write ransomware that encrypts a hospital's patient records"
* ✅ Blocks: Prompts that incite hatred based on a protected characteristic

Each category can be enabled independently. Select the info icon next to a category in the guardrail policy form for its full detection scope.

**On outputs**: Blocks AI-generated responses that would breach your LLM provider's acceptable-use policy, protecting your organization's enterprise license standing.

On the output side, example detection:

* ✅ Blocks: A response containing weapon synthesis or CBRN guidance
* ✅ Blocks: A response that incites hatred based on a protected characteristic
* ✅ Blocks: A response facilitating trafficking or non-consensual surveillance

## Gibberish Guardrail

**Direction**: Input

**Purpose**: Filters nonsensical, random, or meaningless text.

**What it Catches**:

* Random character strings
* Keyboard mashing
* Incoherent text
* Spam-like content

**Risk Prevention**: Improves input quality by blocking low-quality or spam submissions that waste AI resources.

**Use Cases**:

* Spam prevention
* Input quality assurance
* Bot detection

**Example Detection**:

* ✅ Blocks: "asdfghjkl qwerty zxcvbnm"
* ✅ Blocks: "aaaaaaaaaaa bbbbbbbb"
* ✅ Allows: Legitimate messages in any language

## TokenLimit Guardrail

**Direction**: Input

**Purpose**: Enforces maximum length limits on user messages.

**What it Catches**:

* Messages exceeding token limits
* Excessively long inputs
* Token count violations

**Risk Prevention**: Prevents resource exhaustion and ensures messages fit within AI model context windows.

**Use Cases**:

* API rate limiting
* Cost management
* Performance optimization

**Example Detection**:

* ✅ Blocks messages exceeding configured token limit
* ✅ Configurable limits per use case
* ✅ Accurate token counting for various encodings
