# Fetch Data

<table data-full-width="true"><thead><tr><th width="413.728515625">API</th><th>Description</th></tr></thead><tbody><tr><td>[<strong>POST /api/fetchSuspectSampleData</strong>](#fetchsuspectsampledata)</td><td>Fetch suspicious sample request/response data flagged during guardrail detection.</td></tr><tr><td>[<strong>POST /api/fetchThreatActors</strong>](#fetchthreatatcors)</td><td>Retrieve details of identified guardrail actors (malicious sources).</td></tr><tr><td>[<strong>POST /api/fetchFiltersThreatTable</strong>](#fetchfiltersthreatale)</td><td>Fetch available filters for organizing and querying the guardrail table.</td></tr><tr><td>[<strong>POST /api/getThreatActivityTimeline</strong>](#getthreattimelinectivity)</td><td>Retrieve the activity timeline of guardrails across a given period.</td></tr><tr><td>[<strong>POST /api/fetchAggregateMaliciousRequests</strong>](#fetchaggreatemaliciousrequests)</td><td>Get aggregated statistics of malicious requests detected across Agentic Components.</td></tr><tr><td>[<strong>POST /api/fetchCountBySeverity</strong>](#fetchcountbyseverity)</td><td>Retrieve counts of guardrails grouped by severity (Critical, High, Medium, Low).</td></tr><tr><td>[<strong>POST /api/fetchRemediationInfo</strong>](#fetchremediationinfo)</td><td>Fetch remediation details and guidance for specific guardrails or issues.</td></tr><tr><td>[<strong>POST /api/fetchThreatApis</strong>](#fetchthreatapis)</td><td>Get the list of Agentic Components targeted by guardrails or malicious traffic.</td></tr><tr><td>[<strong>POST /api/fetchThreatCategoryCount</strong>](#fetchthreatcategorycount)</td><td>Retrieve the count of guardrails grouped by categories (e.g., Injection, Auth, DoS).</td></tr><tr><td>[<strong>POST /api/fetchFilterYamlTemplate</strong>](#fetchfilteryamltemplate)</td><td>Fetch the YAML template for building custom filters for guardrail analysis.</td></tr><tr><td>[<strong>POST /api/fetchFiltersForThreatActors</strong>](#fetchfilterforthreatatcors)</td><td>Retrieve filter options for drilling into guardrail actor activity.</td></tr><tr><td>[<strong>POST /api/getDailyThreatActorsCount</strong>](#getdailythreatactorscount)</td><td>Get the count of active guardrail actors observed per day.</td></tr><tr><td>[<strong>POST /api/getActorsCountPerCounty</strong>](#getactorscountpercountry)</td><td>Retrieve the distribution of guardrail actors grouped by country.</td></tr><tr><td>[<strong>POST /api/fetchSessionContext</strong>](#fetchsessioncontext)</td><td>Fetch session context and metadata for analyzing guardrail actor behavior within Agentic sessions.</td></tr><tr><td>[<strong>POST /api/fetchGuardrailData</strong>](#fetchguardraildata)</td><td>Retrieve aggregated guardrail detection data and statistics.</td></tr><tr><td>[<strong>POST /api/fetchMcpdata</strong>](#fetchmcpdata)</td><td>Fetch data related to Multi-Capable Platforms (MCP) guardrail detection and interaction patterns.</td></tr><tr><td>[<strong>POST /api/fetchBrowserExtensionConfigs</strong>](#fetchbrowserextensionconfigs)</td><td>Fetch configuration details for browser extension-based guardrail detection and monitoring.</td></tr><tr><td>[<strong>POST /api/fetchThreatTopNData</strong>](#fetchthreatttopndata)</td><td>Get top N guardrail actors or malicious patterns based on frequency or severity.</td></tr><tr><td>[<strong>POST /api/fetchThreatComplianceInfos</strong>](#fetchthreatcomplianceinfos)</td><td>Retrieve compliance-related security information and risk assessments.</td></tr><tr><td>[<strong>POST /api/fetchThreatData</strong>](#fetchthreatdata)</td><td>Consolidated endpoint to fetch comprehensive guardrail detection and activity data across dashboards.</td></tr><tr><td>[<strong>POST /api/getIpReputationScore</strong>](#getipreputationscore)</td><td>Retrieve the reputation score of an IP address for security intelligence.</td></tr></tbody></table>

## Guardrail-Specific APIs

### fetchSuspectSampleData

### fetchFiltersThreatTable

### fetchAggregateMaliciousRequests

### fetchSessionContext

### fetchGuardrailData

### fetchMcpdata

### fetchBrowserExtensionConfigs

## Guardrail Detection APIs

### fetchThreatActors

### getThreatActivityTimeline

### fetchCountBySeverity

### fetchThreatApis

### fetchThreatCategoryCount

### getDailyThreatActorsCount

### getActorsCountPerCounty

### fetchThreatTopNData

### fetchThreatComplianceInfos

### getIpReputationScore

## Support & Utility APIs

### fetchRemediationInfo

### fetchFilterYamlTemplate

### fetchFiltersForThreatActors

### fetchThreatData

