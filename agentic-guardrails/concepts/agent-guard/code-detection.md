# Code Detection

Guardrails that detect programming code, or specific programming languages, in prompts and responses.

Part of the [Agent Guard](../agent-guard.md) scanner reference. Each entry notes whether it runs on **input** (user prompts and tool requests), **output** (model and tool responses), or both.

## BanCode Guardrail

**Direction**: Input and output

**Purpose**: Detects code snippets, scripts, or programming commands in user messages.

**What it Catches**:

* Programming code (Python, JavaScript, Java, etc.)
* Shell commands
* SQL queries
* Script blocks
* Executable instructions

**Risk Prevention**: Prevents code injection attempts and enforces no-code policies in specific contexts.

**Use Cases**:

* Block malicious scripts in non-technical channels
* Prevent code execution attempts
* Enforce communication policies

**Example Detection**:

* ✅ Blocks: "import os; os.system('rm -rf /')"
* ✅ Blocks: "SELECT \* FROM users WHERE admin=1"
* ✅ Allows: "I need help with coding" (mentions code but isn't code)

**On outputs**: Detects code snippets or scripts in AI-generated responses.

On the output side, example detection:

* ✅ Blocks: "Here's the solution: `rm -rf /`"
* ✅ Prevents malicious script generation
* ✅ Enforces code-free responses when required

## Code Guardrail

**Direction**: Input and output

**Purpose**: Detects and identifies programming language used in messages.

**What it Catches**:

* Specific programming languages (Python, Java, JavaScript, etc.)
* Code syntax patterns
* Language-specific constructs

**Risk Prevention**: Allows selective code detection - useful when you want to identify specific languages while allowing others.

**Use Cases**:

* Language-specific policy enforcement
* Code category identification
* Technical support routing

**Example Detection**:

* ✅ Detects: "def calculate\_sum(a, b): return a + b" (Python)
* ✅ Detects: "public class User {}" (Java)
* ✅ Configuration: Specify which languages to detect

**On outputs**: Identifies programming languages in AI-generated responses.

On the output side, example detection:

* ✅ Detects: Python, Java, JavaScript code
* ✅ Configuration: Specify which languages to flag
* ✅ Accurate language identification
