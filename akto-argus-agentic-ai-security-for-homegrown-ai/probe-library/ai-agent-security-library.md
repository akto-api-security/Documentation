---
description: Probe Library for AI Agent OWASP Top 10 for Security
---

# AI Agent Security Probe Library

This section documents Akto’s **Agentic AI Security (ASI) probe library**, mapped to the **ASI Agentic Top 10** risk categories.

Each entry below is an **executable probe template**. Templates are grouped by:

* **ASI category** (what risk is being probed)
* **attack family / technique** (how the probe is delivered: base64, leetspeak, roleplay, etc.)
* **execution template** (single-shot, sequential, crescendo, tree, linear, judge)

> **Note**\
> The lists below represent a subset of Akto’s full agentic probe library (4,000+ probes across MCP + agentic systems).

### ASI01: Agent Goal Hijack

#### Base64

* Security Indirect Prompt Injection Base64 Sequential Jailbreaking
* Security Jailbreak Base64 Sequential Jailbreaking

#### Context Poisoning

* Business Alignment Competitor Check Context Poisoning Sequential Jailbreaking

#### Goal Redirection

* Security Jailbreak Goal Redirection Crescendo Jailbreaking

#### Input Bypass

* Security Prompt Injection Input Bypass Tree Jailbreaking

#### Leetspeak

* Security Indirect Prompt Injection Leetspeak Sequential Jailbreaking
* Security Jailbreak Leetspeak Sequential Jailbreaking
* Security Prompt Injection Leetspeak Sequential Jailbreaking

#### Math Problem

* Security System Prompt Override Math Problem Crescendo Jailbreaking

#### Multilingual

* Security Indirect Prompt Injection Multilingual Sequential Jailbreaking
* Security Jailbreak Multilingual Sequential Jailbreaking
* Security Prompt Injection Multilingual Sequential Jailbreaking

#### Permission Escalation

* Security Prompt Injection Permission Escalation Sequential Jailbreaking

#### Prompt Injection

* Security Indirect Prompt Injection Prompt Injection Crescendo Jailbreaking

#### ROT13

* Security Indirect Prompt Injection ROT13 Sequential Jailbreaking
* Security Jailbreak ROT13 Sequential Jailbreaking
* Security Prompt Injection ROT13 Sequential Jailbreaking

#### Roleplay

* Business Alignment Intentional Misuse Roleplay Tree Jailbreaking

#### Semantic Manipulation

* Security Agent Behavior Hijack and Goal Manipulation Semantic Manipulation Tree Jailbreaking

#### System Override

* Security Manipulation System Override Sequential Jailbreaking

***

### ASI02: Tool Misuse and Exploitation

#### Context Poisoning

* Security Insecure Plugin Use Context Poisoning Tree Jailbreaking
* Security Tool Discovery Context Poisoning Tree Jailbreaking
* Security Tool Misuse and Exploitation Context Poisoning Linear Jailbreaking

#### Goal Redirection

* Security Insecure Plugin Use Goal Redirection Linear Jailbreaking
* Security Tool Discovery Goal Redirection Tree Jailbreaking

#### Input Bypass

* Security Manipulation Input Bypass

#### Leetspeak

* Security Tool Discovery Leetspeak Linear Jailbreaking

#### Math Problem

* Security Tool Misuse and Exploitation Math Problem Tree Jailbreaking

#### Multilingual

* Security Tool Discovery Multilingual Linear Jailbreaking
* Security Tool Misuse and Exploitation Multilingual Tree Jailbreaking

#### Permission Escalation

* Security Insecure Plugin Use Permission Escalation Tree Jailbreaking

#### Prompt Injection

* Security Tool Discovery Prompt Injection Linear Jailbreaking

#### Roleplay

* Security Insecure Plugin Use Roleplay Linear Jailbreaking
* Security Insecure Plugin Use Roleplay Tree Jailbreaking
* Security Tool Discovery Roleplay Linear Jailbreaking
* Security Tool Discovery Roleplay Tree Jailbreaking
* Security Tool Misuse and Exploitation Roleplay Linear Jailbreaking
* Security Tool Misuse and Exploitation Roleplay Tree Jailbreaking

#### Semantic Manipulation

* Security Tool Misuse and Exploitation Semantic Manipulation Tree Jailbreaking

#### System Override

* Security Tool Misuse and Exploitation System Override

***

### ASI03: Identity and Privilege Abuse

#### Base64

* Security Identity Spoofing Base64 Crescendo Jailbreaking
* Security Sensitive Information Disclosure Base64 Crescendo Jailbreaking

#### Context Poisoning

* Safety PII Context Poisoning Crescendo Jailbreaking

#### Goal Redirection

* Security Cross Session Leaks Goal Redirection Crescendo Jailbreaking
* Security Identity Spoofing Goal Redirection Crescendo Jailbreaking

#### Input Bypass

* Security Cross Session Leaks Input Bypass Sequential Jailbreaking

#### Leetspeak

* Safety PII Leetspeak Crescendo Jailbreaking
* Safety Privacy Violation Leetspeak Crescendo Jailbreaking

#### Math Problem

* Safety PII Math Problem Crescendo Jailbreaking
* Security Sensitive Information Disclosure Math Problem Crescendo Jailbreaking

#### Multilingual

* Safety Privacy Violation Multilingual Crescendo Jailbreaking
* Security Identity Spoofing Multilingual Crescendo Jailbreaking
* Security Sensitive Information Disclosure Multilingual Crescendo Jailbreaking

#### Permission Escalation

* Safety PII Permission Escalation Crescendo Jailbreaking

#### ROT13

* Safety Privacy Violation ROT13 Crescendo Jailbreaking
* Security Identity Spoofing ROT13 Crescendo Jailbreaking
* Security Sensitive Information Disclosure ROT13 Crescendo Jailbreaking

#### Roleplay

* Security Identity Spoofing Roleplay Bad Likert Judge

#### Semantic Manipulation

* Security Sensitive Information Disclosure Semantic Manipulation Bad Likert Judge

#### System Override

* Safety Privacy Violation System Override Sequential Jailbreaking

***

### ASI04: Agentic Supply Chain Vulnerabilities

#### Base64

* Security Malicious Resource Fetching Base64 Sequential Jailbreaking

#### Context Poisoning

* Security Malicious Resource Fetching Context Poisoning Crescendo Jailbreaking

#### Goal Redirection

* Security Agentic Supply Chain Vulnerabilities Goal Redirection Sequential Jailbreaking

#### Input Bypass

* Security Agentic Supply Chain Vulnerabilities Input Bypass Sequential Jailbreaking

#### Leetspeak

* Security Training Data Poisoning Leetspeak Tree Jailbreaking

#### Multilingual

* Security Agentic Supply Chain Vulnerabilities Multilingual Crescendo Jailbreaking

#### Permission Escalation

* Security Malicious Resource Fetching Permission Escalation Tree Jailbreaking
* Security Training Data Poisoning Permission Escalation Tree Jailbreaking

#### Prompt Injection

* Security Training Data Poisoning Prompt Injection Tree Jailbreaking

#### Roleplay

* Security Agentic Supply Chain Vulnerabilities Roleplay Crescendo Jailbreaking
* Security Training Data Poisoning Roleplay Crescendo Jailbreaking

#### System Override

* Security Agentic Supply Chain Vulnerabilities System Override Crescendo Jailbreaking
* Security Agentic Supply Chain Vulnerabilities System Override Sequential Jailbreaking
* Security Agentic Supply Chain Vulnerabilities System Override Tree Jailbreaking
* Security Malicious Resource Fetching System Override Crescendo Jailbreaking
* Security Malicious Resource Fetching System Override Sequential Jailbreaking
* Security Malicious Resource Fetching System Override Tree Jailbreaking
* Security Training Data Poisoning System Override Crescendo Jailbreaking
* Security Training Data Poisoning System Override Sequential Jailbreaking
* Security Training Data Poisoning System Override Tree Jailbreaking

***

### ASI05: Unexpected Code Execution (RCE)

#### Base64

* Security XSS Base64

#### Context Poisoning

* Security Code Execution Context Poisoning Tree Jailbreaking

#### Input Bypass

* Security Unexpected Code Execution RCE Input Bypass Tree Jailbreaking

#### Math Problem

* Security Web Injection Math Problem Tree Jailbreaking

#### Permission Escalation

* Security Code Execution Permission Escalation Linear Jailbreaking

#### Prompt Injection

* Security Code Execution Prompt Injection

#### ROT13

* Security Code Execution ROT13 Linear Jailbreaking
* Security Code Execution ROT13 Tree Jailbreaking
* Security Web Injection ROT13 Linear Jailbreaking
* Security Web Injection ROT13 Tree Jailbreaking
* Security XSS ROT13 Linear Jailbreaking
* Security XSS ROT13 Tree Jailbreaking

#### Roleplay

* Security Code Execution Roleplay Linear Jailbreaking
* Security Code Execution Roleplay Tree Jailbreaking
* Security Web Injection Roleplay Linear Jailbreaking
* Security Web Injection Roleplay Tree Jailbreaking
* Security XSS Roleplay Linear Jailbreaking
* Security XSS Roleplay Tree Jailbreaking

#### Semantic Manipulation

* Security XSS Semantic Manipulation Tree Jailbreaking

#### System Override

* Security Web Injection System Override Linear Jailbreaking

***

### ASI06: Memory & Context Poisoning

#### Base64

* Security Context Leakage Base64 Sequential Jailbreaking

#### Context Poisoning

* Security Context Leakage Context Poisoning Crescendo Jailbreaking
* Security Context Leakage Context Poisoning Tree Jailbreaking
* Security Context Poisoning Context Poisoning Crescendo Jailbreaking
* Security Context Poisoning Context Poisoning Sequential Jailbreaking
* Security Context Poisoning Context Poisoning Tree Jailbreaking
* Security RAG Poisoning Context Poisoning Crescendo Jailbreaking
* Security RAG Poisoning Context Poisoning Sequential Jailbreaking
* Security RAG Poisoning Context Poisoning Tree Jailbreaking

#### Input Bypass

* Security RAG Poisoning Input Bypass Crescendo Jailbreaking

#### Multilingual

* Security Context Poisoning Multilingual Tree Jailbreaking

#### Prompt Injection

* Security Context Leakage Prompt Injection Crescendo Jailbreaking
* Security Context Leakage Prompt Injection Sequential Jailbreaking
* Security Context Leakage Prompt Injection Tree Jailbreaking
* Security Context Poisoning Prompt Injection Crescendo Jailbreaking
* Security Context Poisoning Prompt Injection Sequential Jailbreaking
* Security Context Poisoning Prompt Injection Tree Jailbreaking
* Security RAG Poisoning Prompt Injection Crescendo Jailbreaking
* Security RAG Poisoning Prompt Injection Sequential Jailbreaking
* Security RAG Poisoning Prompt Injection Tree Jailbreaking

***

### ASI07: Insecure Inter-Agent Communication

#### Base64

* Security Data Exfiltration Base64 Tree Jailbreaking
* Security Insecure Inter Agent Communication Base64 Sequential Jailbreaking
* Security Insecure Inter Agent Communication Base64 Tree Jailbreaking

#### Input Bypass

* Security Data Exfiltration Input Bypass Crescendo Jailbreaking

#### Leetspeak

* Security Insecure Inter Agent Communication Leetspeak Sequential Jailbreaking

#### Permission Escalation

* Security Insecure Inter Agent Communication Permission Escalation Sequential Jailbreaking

#### Prompt Injection

* Security Cross Session Leaks Prompt Injection
* Security Cross Session Leaks Prompt Injection Bad Likert Judge
* Security Cross Session Leaks Prompt Injection Crescendo Jailbreaking
* Security Cross Session Leaks Prompt Injection Linear Jailbreaking
* Security Cross Session Leaks Prompt Injection Sequential Jailbreaking
* Security Cross Session Leaks Prompt Injection Tree Jailbreaking

#### ROT13

* Security Data Exfiltration ROT13 Tree Jailbreaking

#### Semantic Manipulation

* Security Data Exfiltration Semantic Manipulation Tree Jailbreaking

#### System Override

* Security Data Exfiltration System Override Crescendo Jailbreaking
* Security Data Exfiltration System Override Sequential Jailbreaking
* Security Data Exfiltration System Override Tree Jailbreaking
* Security Insecure Inter Agent Communication System Override Crescendo Jailbreaking
* Security Insecure Inter Agent Communication System Override Sequential Jailbreaking
* Security Insecure Inter Agent Communication System Override Tree Jailbreaking

***

### ASI08: Cascading Failures

#### Base64

* Hallucination and Trustworthiness Hallucination Propagation Base64 Tree Jailbreaking
* Security Model Denial of Service Base64 Tree Jailbreaking

#### Context Poisoning

* Hallucination and Trustworthiness Hallucination Propagation Context Poisoning Sequential Jailbreaking

#### Goal Redirection

* Hallucination and Trustworthiness Hallucination Propagation Goal Redirection Tree Jailbreaking
* Security Model Denial of Service Goal Redirection Tree Jailbreaking

#### Input Bypass

* Hallucination and Trustworthiness Hallucination Propagation Input Bypass Tree Jailbreaking
* Security Model Denial of Service Input Bypass Tree Jailbreaking

#### Leetspeak

* Hallucination and Trustworthiness Hallucination Propagation Leetspeak Tree Jailbreaking
* Security Model Denial of Service Leetspeak Tree Jailbreaking

#### Math Problem

* Hallucination and Trustworthiness Hallucination Propagation Math Problem Tree Jailbreaking
* Security Model Denial of Service Math Problem Tree Jailbreaking

#### Multilingual

* Security Model Denial of Service Multilingual Crescendo Jailbreaking

#### Prompt Injection

* Hallucination and Trustworthiness Hallucination Propagation Prompt Injection Tree Jailbreaking
* Security Model Denial of Service Prompt Injection Tree Jailbreaking

#### ROT13

* Hallucination and Trustworthiness Hallucination Propagation ROT13 Tree Jailbreaking
* Security Model Denial of Service ROT13 Tree Jailbreaking

#### Roleplay

* Security Model Denial of Service Roleplay Tree Jailbreaking

#### Semantic Manipulation

* Hallucination and Trustworthiness Hallucination Propagation Semantic Manipulation Tree Jailbreaking

#### System Override

* Hallucination and Trustworthiness Hallucination Propagation System Override Tree Jailbreaking
* Security Model Denial of Service System Override Tree Jailbreaking

***

### ASI09: Human-Agent Trust Exploitation

#### Base64

* Business Alignment Human Agent Trust Exploitation Base64 Crescendo Jailbreaking
* Business Alignment Overwhelming Human in the Loop Base64 Crescendo Jailbreaking
* Security Overreliance Base64 Bad Likert Judge
* Security Overreliance Base64 Sequential Jailbreaking

#### Goal Redirection

* Security Overreliance Goal Redirection Sequential Jailbreaking

#### Input Bypass

* Business Alignment Human Agent Trust Exploitation Input Bypass Sequential Jailbreaking
* Business Alignment Overwhelming Human in the Loop Input Bypass Sequential Jailbreaking
* Security Overreliance Input Bypass Bad Likert Judge

#### Prompt Injection

* Business Alignment Overwhelming Human in the Loop Prompt Injection Sequential Jailbreaking

#### Roleplay

* Business Alignment Human Agent Trust Exploitation Roleplay Bad Likert Judge

#### Semantic Manipulation

* Business Alignment Human Agent Trust Exploitation Semantic Manipulation Bad Likert Judge
* Business Alignment Human Agent Trust Exploitation Semantic Manipulation Crescendo Jailbreaking
* Business Alignment Human Agent Trust Exploitation Semantic Manipulation Sequential Jailbreaking
* Business Alignment Overwhelming Human in the Loop Semantic Manipulation Bad Likert Judge
* Business Alignment Overwhelming Human in the Loop Semantic Manipulation Crescendo Jailbreaking
* Business Alignment Overwhelming Human in the Loop Semantic Manipulation Sequential Jailbreaking
* Security Overreliance Semantic Manipulation Bad Likert Judge
* Security Overreliance Semantic Manipulation Crescendo Jailbreaking
* Security Overreliance Semantic Manipulation Sequential Jailbreaking

#### System Override

* Business Alignment Overwhelming Human in the Loop System Override Crescendo Jailbreaking

***

### ASI10: Rogue Agents

#### Base64

* Business Alignment Off Topic Base64 Crescendo Jailbreaking
* Security Excessive Agency Base64 Crescendo Jailbreaking

#### Context Poisoning

* Security Excessive Agency Context Poisoning Crescendo Jailbreaking

#### Goal Redirection

* Business Alignment Legally Binding Goal Redirection Crescendo Jailbreaking

#### Input Bypass

* Business Alignment Off Topic Input Bypass Crescendo Jailbreaking
* Business Alignment Rogue Agents Input Bypass Crescendo Jailbreaking
* Security Excessive Agency Input Bypass Crescendo Jailbreaking

#### Leetspeak

* Business Alignment Legally Binding Leetspeak Crescendo Jailbreaking
* Business Alignment Rogue Agents Leetspeak Crescendo Jailbreaking

#### Multilingual

* Business Alignment Legally Binding Multilingual Crescendo Jailbreaking
* Business Alignment Rogue Agents Multilingual Crescendo Jailbreaking

#### Permission Escalation

* Business Alignment Legally Binding Permission Escalation Crescendo Jailbreaking
* Business Alignment Off Topic Permission Escalation Crescendo Jailbreaking

#### Prompt Injection

* Business Alignment Misaligned and Deceptive Behaviors Prompt Injection Sequential Jailbreaking

#### ROT13

* Business Alignment Legally Binding ROT13 Crescendo Jailbreaking
* Business Alignment Misaligned and Deceptive Behaviors ROT13 Crescendo Jailbreaking
* Business Alignment Rogue Agents ROT13 Crescendo Jailbreaking

#### Roleplay

* Business Alignment Off Topic Roleplay Tree Jailbreaking

#### Semantic Manipulation

* Security Excessive Agency Semantic Manipulation Tree Jailbreaking

#### System Override

* Business Alignment Rogue Agents System Override Sequential Jailbreaking
