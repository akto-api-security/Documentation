# Result types

Akto's API security testing provides comprehensive insights into the security posture of your APIs. The results are categorized into different types, each offering specific information about the state of your API endpoints. Understanding these result types is crucial for effectively interpreting test outcomes and prioritizing necessary actions to enhance API security.

### 1. Vulnerable

Indicates that a security vulnerability has been detected in the API endpoint. These issues require immediate attention and remediation. The severity level (Critical, High, Medium, Low) is typically provided to prioritize the vulnerabilities.

### 2. Need Configuration

Indicates that some tests could not be performed due to missing configuration details. Akto provides an option on the screen to add the required configuration, allowing users to complete these tests without leaving the interface. This ensures a more thorough security assessment by enabling all relevant tests.

### 3. Skipped

Represents tests that were not executed. This often occurs when the API fails to satisfy certain preconditions necessary for the test, such as authentication requirements. The exact reason for skipping is usually provided in the error message.

### 4. No Vulnerability Found

Indicates that the specific security test was completed successfully, and no vulnerabilities were detected for that particular check.

### 5. Domain Unreachable

Signifies that the test couldn't connect to the API endpoint, possibly due to network issues, incorrect URL, or the API being offline. This result type requires investigation into the API's availability and accessibility.
