
#### Understanding Threat Actors

Threat actors are individuals, groups, or entities responsible for carrying out malicious activities targeting your AI agents, MCP endpoints, and autonomous systems. They are often motivated by financial gain, espionage, ideology, or disruption. Threat actors targeting agentic systems may attempt prompt injections, tool abuse, data exfiltration through agent interactions, or unauthorized access to agent capabilities. They can range from lone hackers to organized crime groups, nation-states, or insider threats.

#### Key Metrics to Monitor:

**Critical Actors**: Threat actors posing a high risk to your agentic systems due to their capability and intent

**Active Actors**: The total number of threat actors currently engaging in malicious activities against agent components

**Threat Activity Timeline**: Tracks the frequency and volume of attacks over time (e.g., agent component invocations, tool abuse attempts)

**Threat Actor Map**: Geographically maps the origin of threat actors targeting your autonomous systems

#### How to configure Threat Actors

By default Akto's Guardrails module uses the client's IP address to identify a threat actor targeting your agent components.

To configure threat actors, navigate to the Settings → Threat Configuration section in left navigation bar.

##### Example Configuration
- **Type**: `hostname`
- **Hostname**: `dev.*com`
- **Header Name**: `authorization`

This configuration will monitor any requests from hostnames matching dev.*com (e.g., dev.example.com) that include an authorization header, identifying the threat actors uniquely based on the value of authorization header.