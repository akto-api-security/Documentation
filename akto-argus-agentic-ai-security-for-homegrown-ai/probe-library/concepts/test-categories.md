---
hidden: true
---

# Test Categories

## Overview

AI Red Teaming test categories in Akto group security tests by the primary failure mode or control gap being validated. This structure helps you analyze coverage, prioritize remediation, and align AI security testing with established API and LLM risk models.

Each category represents a distinct class of vulnerability that can affect LLM-backed APIs, agent workflows, or supporting infrastructure.

## How Akto Uses Test Categories

Akto assigns every AI Red Teaming test to exactly one category. Category assignment determines how test results are grouped, counted, and reported across scans and dashboards.

Category-based organization supports:

* Risk-focused navigation of large test sets
* Aggregated visibility into recurring security weaknesses
* Consistent mapping to OWASP API and LLM security concepts
* Trend analysis across AI-enabled endpoints

## Available AI Red Teaming Test Categories

<table><thead><tr><th width="40" data-type="number"></th><th width="297.9140625">Category</th><th>What the Category Validates</th></tr></thead><tbody><tr><td>1</td><td><strong>LLM (Large Language Model)</strong></td><td>Model-level vulnerabilities such as prompt manipulation, unsafe completions, policy bypass attempts, and hallucinated authority.</td></tr><tr><td>2</td><td>Broken Function Level Authorization (BFLA)</td><td>Enforcement of authorization at the function or action level for AI-driven APIs and agent operations.</td></tr><tr><td>3</td><td><a href="https://www.akto.io/test-library/broken-object-level-authorization">Broken Object Level Authorization (BOLA)</a></td><td>Access control on object identifiers to prevent unauthorized access to data objects through manipulated IDs.</td></tr><tr><td>4</td><td><a href="https://www.akto.io/test-library/broken-user-authentication">Broken User Authentication (BUA)</a></td><td>Authentication enforcement failures, including missing token validation, insecure sessions, and authentication bypass scenarios.</td></tr><tr><td>5</td><td><a href="https://www.akto.io/test-library/command-injection">Command Injection</a></td><td>Unsafe execution of system commands through user-controlled input in agents, tools, or backend integrations.</td></tr><tr><td>6</td><td><a href="https://www.akto.io/test-library/cross-origin-resource-sharing">Cross-Origin Resource Sharing (CORS)</a></td><td>Cross-origin access control policies that may allow unauthorized web origins to access AI-enabled APIs.</td></tr><tr><td>7</td><td><a href="https://www.akto.io/test-library/crlf-injection">CRLF Injection</a></td><td>Improper input sanitization allowing manipulation of HTTP headers or responses using carriage return and line feed characters.</td></tr><tr><td>8</td><td><strong>Excessive Data Exposure</strong></td><td>API or LLM responses returning more data than required, including unintended exposure of sensitive fields.</td></tr><tr><td>9</td><td><strong>Improper Inventory Management</strong></td><td>Undocumented, deprecated, or shadow APIs and agents exposed through AI or agentic workflows.</td></tr><tr><td>10</td><td><strong>Injection Attacks (INJECTION)</strong></td><td>Generic injection vectors such as SQL, NoSQL, and expression injection caused by unsafe input handling.</td></tr><tr><td>11</td><td><strong>Input Validation (INPUT)</strong></td><td>Enforcement of data type checks, length limits, format constraints, and allowed values for request inputs.</td></tr><tr><td>12</td><td><a href="https://www.akto.io/test-library/local-file-inclusion">Local File Inclusion (LFI)</a></td><td>Unauthorized access to local files through user-influenced file path parameters.</td></tr><tr><td>13</td><td><a href="https://www.akto.io/test-library/mass-assignment">Mass Assignment (MA)</a></td><td>Direct binding of user input to internal objects without field-level allowlisting.</td></tr><tr><td>14</td><td><a href="https://www.akto.io/test-library/misconfigured-http-headers">Misconfigured HTTP Headers (MHH)</a></td><td>Missing or insecure HTTP security headers that weaken browser and client-side protections.</td></tr><tr><td>15</td><td><a href="https://www.akto.io/test-library/lack-of-resources-and-rate-limiting">Lack of Resources &#x26; Rate Limiting (RL)</a></td><td>Absence or weakness of request throttling controls, enabling abuse, denial-of-service, or excessive LLM usage.</td></tr><tr><td>16</td><td><a href="https://www.akto.io/test-library/security-misconfiguration">Security Misconfiguration (SM)</a></td><td>Insecure default settings, exposed debug configurations, weak TLS policies, or unsafe deployment states.</td></tr><tr><td>17</td><td><a href="https://www.akto.io/test-library/server-side-request-forgery">Server Side Request Forgery (SSRF)</a></td><td>Ability to force the server, agent, or tool to make unauthorized internal or external network requests.</td></tr><tr><td>18</td><td><a href="https://www.akto.io/test-library/server-side-template-injection">Server Side Template Injection (SSTI)</a></td><td>Unsafe template processing that allows code execution or sensitive data access through injected expressions.</td></tr><tr><td>19</td><td><a href="https://www.akto.io/test-library/server-version-disclosure">Server Version Disclosure (SVD)</a></td><td>Exposure of server, framework, or runtime version details through headers or error messages.</td></tr><tr><td>20</td><td><a href="https://www.akto.io/test-library/unnecessary-http-methods">Unnecessary HTTP Methods (UHM)</a></td><td>Enabled HTTP verbs that are not required for API functionality and increase the attack surface.</td></tr><tr><td>21</td><td><a href="https://www.akto.io/test-library/verbose-error-messages">Verbose Error Messages (VEM)</a></td><td>Error responses exposing stack traces, internal logic, or sensitive implementation details.</td></tr><tr><td>22</td><td><a href="https://www.akto.io/test-library/cross-site-scripting">Cross-site scripting (XSS)</a></td><td>Reflection or storage of untrusted input in responses without proper encoding, including AI-generated output paths.</td></tr></tbody></table>

## Expected Outcome

Using AI Red Teaming test categories, you gain structured visibility into security risks across LLMs, agents, and APIs. Category-level organization supports risk-based prioritisation, clearer reporting, and consistent governance for AI-enabled systems.

## What Next

To create customised tests as per your requirement: [Learn how to create custom tests](../how-to/create-a-custom-test.md)
