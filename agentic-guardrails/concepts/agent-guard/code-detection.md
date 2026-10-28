# Code Detection

Guardrails that detect programming code, or specific programming languages, in prompts and responses.

Part of [Agent Guard](../agent-guard.md). Each entry notes whether it runs on **input** (user prompts and tool requests), **output** (model and tool responses), or both.

## BanCode Guardrail

Detects code snippets, scripts, or programming commands in user messages.

| Direction | Configure in |
|---|---|
| Input and output | [Advanced Code Detection](../../how-to/guardrail-policy-fields/sensitive-data-and-code.md#advanced-code-detection-filters) |

**What it catches**

* Programming code (Python, JavaScript, Java, etc.)
* Shell commands
* SQL queries
* Script blocks
* Executable instructions

{% hint style="info" %}
**Risk prevention**: Prevents code injection attempts and enforces no-code policies in specific contexts.
{% endhint %}

**Use cases**

* Block malicious scripts in non-technical channels
* Prevent code execution attempts
* Enforce communication policies

**Example**

| Input | Result |
|---|---|
| "import os; os.system('rm -rf /')" | Blocked |
| "SELECT \* FROM users WHERE admin=1" | Blocked |
| "I need help with coding" (mentions code but isn't code) | Allowed |

**On outputs**: Detects code snippets or scripts in AI-generated responses.

**Output example**

| Input | Result |
|---|---|
| "Here's the solution: `rm -rf /`" | Blocked |

* Prevents malicious script generation
* Enforces code-free responses when required

## Code Guardrail

Detects and identifies programming language used in messages.

| Direction | Configure in |
|---|---|
| Input and output | [Advanced Code Detection](../../how-to/guardrail-policy-fields/sensitive-data-and-code.md#advanced-code-detection-filters) |

**What it catches**

* Specific programming languages (Python, Java, JavaScript, etc.)
* Code syntax patterns
* Language-specific constructs

{% hint style="info" %}
**Risk prevention**: Allows selective code detection - useful when you want to identify specific languages while allowing others.
{% endhint %}

**Use cases**

* Language-specific policy enforcement
* Code category identification
* Technical support routing

**Example**

| Input | Result |
|---|---|
| "def calculate\_sum(a, b): return a + b" (Python) | Detected |
| "public class User {}" (Java) | Detected |

* Configuration: Specify which languages to detect

**On outputs**: Identifies programming languages in AI-generated responses.

**Output example**

| Input | Result |
|---|---|
| Python, Java, JavaScript code | Detected |

* Configuration: Specify which languages to flag
* Accurate language identification
