---
description: Probe Library for OWASP MCP Top 10 for Security in Akto
---

# MCP Security Probe Library

This section documents the **MCP Security Probe Library** built by Akto to probe Model Context Protocol (MCP) servers, tools, agents, and downstream integrations.

Each probe represents a **concrete, executable security probe** that targets a specific MCP failure mode. Probes are organized by **MCP OWASP Top 10 category** and are executed using real MCP protocol flows (JSON-RPC, function calls, tool execution, session handling).

> **Note**\
> The lists below show representative probes for each category. The full library contains **4,000+ MCP and agentic security probes** and continues to expand.

### MCP01: Token Mismanagement & Secret Exposure

Probes in this category validate whether authentication tokens, session identifiers, and secrets are properly handled across MCP requests, tool calls, and downstream APIs.

#### Sample Probes in Akto Probe Library

* MCP Token Passthrough API Key
* MCP Token Passthrough Downstream
* MCP Token Passthrough Opaque Token
* Authentication Token Reflection in Response MCP
* Authentication Token Reflection in Headers MCP
* Replace Auth Token MCP
* MCP Remove Tokens
* Authentication With Wrong Auth Scheme MCP
* MCP Predictable Session IDs
* MCP Session State Persistence
* MCP Session Not Bound to User
* MCP Session Must Use per Request Auth
* MCP Session Hijacking Prompt Injection
* MCP Session Hijacking Filtered Attack

***

### MCP02: Privilege Escalation via Scope Creep

Validates whether MCP function calls and tools allow unauthorized privilege expansion through parameter manipulation, excessive invocation, or input validation bypass.

#### Sample Probes in Akto Probe Library

* MCP Function Call Privilege Escalation
* MCP Unauthorized Tool Access
* MCP Function Call Direct Method Manipulation
* MCP Function Call Excessive Invocation
* MCP Excessive Resource Reads Rate Limit
* Improper Page Size Handling MCP
* MCP Param Overload
* Bypass Input Length Validation MCP
* Bypass Input Validation With Null Values MCP
* Input Validation by Passing Unsupported MCP Method
* Input Validation by Passing Unsupported JSONRPC Version
* Input Validation by Replacing Param With Array MCP
* Input Validation for Boolean MCP
* MCP Invalid Request Removed Param
* MCP Invalid Params

***

### MCP03: Tool Poisoning

Probes whether tool outputs, metadata, or execution paths can be manipulated to influence agent behavior or bypass safety controls.

#### Sample Probes in Akto Probe Library

* Tool Poisoning Output Injection MCP
* MCP Function Call Output Manipulation
* MCP Function Call Response Manipulation
* MCP TPA Tool Metadata Injection
* MCP TPA Obfuscated Output Payloads
* MCP TPA Override Safety Checks
* MCP Elicitation Abuse General

***

### MCP04: Software Supply Chain Attacks & Dependency Tampering

Validates whether MCP implementations securely handle external resources, dependencies, SDK references, and content types.

#### Covered Probe Templates

* MCP Resource Binary URI Deserialization Attack
* Hallucinated SDK Package Suggestion
* MCP Path Traversal Resource URI
* MCP Path Traversal Parameter Injection
* MCP Invalid Origin Header Rebinding
* MCP Invalid MIME Type Injection

***

### MCP05: Command Injection & Execution

Probes whether MCP tools or resources can be abused to execute arbitrary commands or escape execution boundaries.

#### Sample Probes in Akto Probe Library

* MCP Remote Command Injection RCE
* MCP Command Injection Parameter Injection
* Command Injection by Passing Extra Values MCP
* MCP Tools Call Code Injection
* MCP Tools Call Code Injection Sandbox Escape
* MCP Tools Call Shell Like Command
* MCP Resources Read Code Injection
* MCP Indirect Prompt Injection Command Injection Agent Test
* MCP Command Injection With Operators
* MCP Command Injection With Redirection and Var Manipulation
* MCP Command Injection With Redirection and Var Manipulation Chained
* MCP Command Injection Variable Assign
* MCP Command Injection Variable Assign Chained
* MCP Command Injection User Agent Header Chained
* MCP Command Injection URL Path
* MCP Command Injection URL Path Chained
* MCP Command Injection Time Delay
* MCP Command Injection Time Delay Chained
* MCP Command Injection Curl Http Request
* MCP Command Injection Curl Http Request Chained Commands

***

### MCP06: Prompt Injection via Contextual Payloads

Validates whether prompts, tool parameters, resources, or metadata can be abused to override agent behavior or bypass safeguards.

#### Sample Probes in Akto Probe Library

* MCP Direct Prompt Injection
* MCP Indirect Prompt Injection
* MCP Resource Prompt Injection
* MCP Indirect Prompt Injection Tool Bypass
* MCP Indirect Prompt Injection Tool Bypass Agent Test
* MCP Indirect Prompt Injection Response Body
* MCP Function Call Parameter Injection
* MCP Function Call Nested Parameter Injection
* MCP Ping Parameter Injection
* MCP XSS Injection Parameter Injection
* MCP SQL Injection Parameter Injection
* MCP LDAP Injection Parameter Injection
* MCP Path Traversal Parameter Injection
* Prompt Injection Markdown Abuse Injection
* MCP Function Call Params Name Manipulation
* MCP Function Call Metadata Injection
* MCP ANSI Cursor Manipulation Deception
* MCP ANSI Hyperlink Manipulation Deception
* MCP ANSI Invisible Text Deception
* MCP ANSI Screen Clearing Deception
* MCP Consent Fatigue Exploitation

***

### MCP07: Insufficient Authentication & Authorization

Scans whether authentication and authorization are consistently enforced across MCP sessions, tools, and function calls.

#### Sample Probes in Akto Probe Library

* MCP Session Hijacking Prompt Injection
* MCP Session Hijacking Filtered Attack
* MCP Session Not Bound to User
* MCP Session Must Use per Request Auth
* MCP Session State Persistence
* Authentication With Wrong Auth Scheme MCP
* MCP Remove Tokens
* Replace Auth Token MCP
* MCP Predictable Session IDs
* MCP Unauthorized Tool Access
* MCP Function Call Privilege Escalation
* MCP Invalid Request Removed Param

***

### MCP08: Lack of Audit and Telemetry

Validates whether MCP implementations provide sufficient logging, error handling, and resilience against abuse and denial-of-service conditions.

#### Sample Probes in Akto Probe Library

* MCP Missing Log for Security Errors
* MCP Reflective Invalid Tool Calls
* MCP Method Not Found
* MCP Timeout Not Handled Properly
* MCP Internal Error Exposure
* MCP Unhandled Error Disclosure Malformed JSONRPC
* MCP Ping Missing Response
* MCP Ping Invalid JSONRPC
* MCP Ping Slow Response
* MCP Ping Timing Information Leak
* MCP Ping No Rate Limiting
* MCP Ping Flooding DOS
* MCP Ping Amplification Attack
* DOS Test URL MCP
* Date Field DOS MCP
* JSON Body Param Bombing DOS MCP
* DOS Test Large Numbers MCP
* DOS File URL CSV MCP
* DOS Header Key MCP
* DOS Header Value MCP

***

### MCP09: Shadow MCP Servers

Probes whether internal MCP infrastructure, models, tools, or configuration details can be discovered or fingerprinted by an attacker.

#### Sample Probes in Akto Probe Library

* MCP Tools List Extraction via Parameters
* MCP Internal System Details Extraction
* MCP Model Name Extraction via Parameters
* MCP Configuration Information Extraction
* MCP Environment Variables Extraction
* MCP Debug Information Extraction
* MCP Model Architecture Probe
* MCP Model Backend Fingerprinting
* MCP Model Capability Inference
* MCP Model Param Inference
* MCP Model Asset Exfiltration by Prompt
* MCP Scan Dev Infra by Prompt
* MCP Browser Driver Version Disclosure (LT)
* MCP WebDriver Session ID Exposure (LT)
* File System Path Disclosure

***

### MCP10: Context Injection & Over-Sharing

Validates whether MCP systems correctly isolate context, memory, and data across sessions, agents, and tools.

#### Sample Probes in Akto Probe Library

* MCP Context Bleed
* MCP Shared Memory Context Leakage
* MCP Global Memory Buffer Leakage
* MCP Cross Session Context Bleeding
* MCP Vector Store Context Bleeding
* MCP Conversation History Theft
* MCP Conversation History Extraction via Parameters
* MCP Tool Call History Extraction via Parameters
* MCP Chain of Thought Extraction via Parameters
* MCP System Prompt Extraction
* MCP System Prompt Extraction via Parameters
* MCP Response Data Leak Check
* Memory Leak or Object Dump MCP
* MCP Data Retention and Source Disclosure
* MCP Data Exfiltration Reflection Attack
* MCP Shell Configuration Override Attack
