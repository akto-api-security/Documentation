# Source Code Analyzer

The Source Code Analyzer is an autonomous AI agent that scans your source code to identify hidden API endpoints, data flows, and potential risks without requiring runtime traffic. It supports all major programming languages and frameworks, ensuring full coverage across microservices, SDKs, and legacy applications.

<figure><img src="../.gitbook/assets/image (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

***

### Key Capabilities

#### 1. API discovery from code

* Extracts API endpoints, methods, and parameters directly from source code
* Works across REST, GraphQL, gRPC, and SOAP APIs
* Helps uncover shadow APIs and undocumented endpoints

#### 2. Data flow analysis

* Tracks how data moves through code, highlighting areas where sensitive data may be exposed
* Detects risky patterns like insecure parameter handling, direct database queries, and weak input validation

#### 3. Security checks

* Identifies authentication and authorization gaps in code
* Flags misconfigurations like missing headers or unsafe defaults before deployment
* Provides developers with remediation guidance inside the dashboard

#### 4. CI/CD integration

* Runs automatically as part of build pipelines, enabling secure development at scale
* Supports shift-left security by catching risks early in the SDLC
