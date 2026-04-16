# Fetch Data

## Agent & MCP

<table data-full-width="true"><thead><tr><th width="50">#</th><th width="430">API</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td><strong>POST /api/getAllCollectionsBasic</strong></td><td>Fetch a lightweight list of all agentic collections with only basic metadata. Useful for quick lookups or dropdowns.</td></tr><tr><td>2</td><td><strong>POST /api/getAllCollections</strong></td><td>Retrieve the complete list of all agentic collections with detailed information.</td></tr><tr><td>3</td><td><strong>POST /api/getAllUsersCollections</strong></td><td>Fetch all agentic collections accessible to the current user.</td></tr><tr><td>4</td><td><strong>POST /api/getCoverageInfoForCollections</strong></td><td>Get scan coverage data for each collection (e.g., how many Agentic components are scanned vs. unscanned). Used to track which agentic components are covered by scans.</td></tr><tr><td>5</td><td><strong>POST /api/getSeverityInfoForCollections</strong></td><td>Retrieve aggregated severity information (High, Medium, Low) across agentic collections.</td></tr><tr><td>6</td><td><strong>POST /api/getSeveritiesCountPerCollection</strong></td><td>Get the count of issues grouped by severity for each collection.</td></tr><tr><td>7</td><td><strong>POST /api/getLastSeenTrafficInfoForCollections</strong></td><td>Fetch last seen traffic timestamps for each collection, helping track activity recency.</td></tr><tr><td>8</td><td><strong>POST /api/getSensitiveInfoForCollections</strong></td><td>Retrieve sensitive data findings per collection (e.g., PII, secrets).</td></tr><tr><td>9</td><td><strong>POST /api/getRiskScoreInfo</strong></td><td>Get risk scores calculated for agentic collections, based on guardrails and sensitive data exposure.</td></tr><tr><td>10</td><td><strong>POST /api/fetchCollectionWiseApiEndpoints</strong></td><td>Fetch all Agentic components belonging to a specific collection.</td></tr><tr><td>11</td><td><strong>POST /api/fetchApiInfosForCollection</strong></td><td>Retrieve detailed agentic component information for a given collection (method, path, params, etc.).</td></tr><tr><td>12</td><td><strong>POST /api/fetchEndpointsCount</strong></td><td>Get a count of Agentic components per collection.</td></tr><tr><td>13</td><td><strong>POST /api/fetchApiCallStats</strong></td><td>Retrieve traffic statistics such as call counts, trends, and usage metrics per agentic component call.</td></tr><tr><td>14</td><td><strong>POST /api/fetchIpLevelApiCallStats</strong></td><td>Get agentic component call stats broken down by IP, useful for identifying abusive clients or usage patterns.</td></tr><tr><td>15</td><td><strong>POST /api/fetchSampleData</strong></td><td>Fetch sample request/response payloads observed for a given agentic component, used for scanning or schema generation.</td></tr><tr><td>16</td><td><strong>POST /api/generateOpenApiFile</strong></td><td>Generate an OpenAPI (Swagger) specification file from discovered Agentic Component data.</td></tr><tr><td>17</td><td><strong>POST /api/fetchAllUrlsAndMethods</strong></td><td>Fetch all unique Agentic components and HTTP methods in a collection.</td></tr><tr><td>18</td><td><strong>POST /api/fetchNewEndpointsTrendForHostCollections</strong></td><td>Get trend of newly discovered Agentic components for host-based collections (for Agentic dashboard).</td></tr><tr><td>19</td><td><strong>POST /api/fetchNewEndpointsTrendForNonHostCollections</strong></td><td>Get trend of newly discovered Agentic components for non-host collections (for Agentic dashboard).</td></tr><tr><td>20</td><td><strong>POST /api/fetchAPICollection</strong></td><td>Fetch Agentic Component collection details and metadata.</td></tr><tr><td>21</td><td><strong>POST /api/fetchChanges</strong></td><td>Retrieve changes and modifications to Agentic Collections.</td></tr><tr><td>22</td><td><strong>POST /api/fetchCustomAuthTypes</strong></td><td>Fetch custom authentication types configured in the system.</td></tr><tr><td>23</td><td><strong>POST /api/fetchDataTypeNames</strong></td><td>Retrieve names of all configured data types.</td></tr><tr><td>24</td><td><strong>POST /api/fetchDataTypes</strong></td><td>Fetch detailed information about data types.</td></tr><tr><td>25</td><td><strong>POST /api/fetchEndpointTrafficData</strong></td><td>Get traffic and usage data for Agentic Components.</td></tr><tr><td>26</td><td><strong>POST /api/fetchNewParametersTrend</strong></td><td>Retrieve trends of newly discovered parameters.</td></tr><tr><td>27</td><td><strong>POST /api/fetchSensitiveParamsForEndpoints</strong></td><td>Fetch parameters identified as sensitive for Agentic components.</td></tr><tr><td>28</td><td><strong>POST /api/fetchTagConfigs</strong></td><td>Retrieve tag configurations for Agentic Component organization.</td></tr><tr><td>29</td><td><strong>POST /api/loadRecentEndpoints</strong></td><td>Load recently discovered or modified Agentic components.</td></tr><tr><td>30</td><td><strong>POST /api/checkAgentRunModule</strong></td><td>Checks if an agent process is currently running on any module.</td></tr><tr><td>31</td><td><strong>POST /api/fetchMcpAuditInfoByCollection</strong></td><td>Fetches MCP audit information for a specific API collection by extracting the MCP server name from hostname.</td></tr><tr><td>32</td><td><strong>POST /api/fetchMcpToolsApiCalls</strong></td><td>Fetches API calls made by MCP tools in a collection, grouping them by parent tool names.</td></tr><tr><td>33</td><td><strong>POST /api/getAgentLogs</strong></td><td>Fetches agent logs for a specific agent within a time range, sorted by timestamp (newest first), capped at 10,000 logs.</td></tr><tr><td>34</td><td><strong>POST /api/getAgentModels</strong></td><td>Fetches all configured AI models for agents, excluding sensitive parameter data.</td></tr><tr><td>35</td><td><strong>POST /api/getAllAgentRunningDetails</strong></td><td>Fetches complete agent run and all its subprocesses for reboot/recovery scenarios.</td></tr><tr><td>36</td><td><strong>POST /api/getAllAgentRuns</strong></td><td>Fetches all currently running agent runs, with special handling for discovery agents.</td></tr><tr><td>37</td><td><strong>POST /api/getAllAgentRunsObject</strong></td><td>Fetches all agent runs (any state) for a specific agent type.</td></tr><tr><td>38</td><td><strong>POST /api/getMcpServersByAgent</strong></td><td>Retrieves MCP servers configured for a specific agent or device, including server name, URL, and last seen timestamp.</td></tr><tr><td>39</td><td><strong>POST /api/getMcpdata</strong></td><td>Fetches MCP-related metrics and data based on filter type, including API counts, audit alerts, and traffic analysis.</td></tr><tr><td>40</td><td><strong>POST /api/getMemberAgents</strong></td><td>Returns all available agent types/modules from the Agent enum.</td></tr><tr><td>41</td><td><strong>POST /api/receiveDataFromAgent</strong></td><td>Receives various types of data updates from running agents, handling logs, state changes, HAR data, and API dependencies.</td></tr><tr><td>42</td><td><strong>POST /api/fetchAllResponsesForApiCollectionOrdered</strong></td><td>Fetches sample response data for APIs in a collection with pagination support, ordered by API creation time.</td></tr><tr><td>43</td><td><strong>POST /api/getAllSubProcesses</strong></td><td>Fetches all subprocesses for an agent run, with special handling for discovery agents.</td></tr><tr><td>44</td><td><strong>POST /api/getFileForDiscovery</strong></td><td>Retrieves compressed file content for discovery agent, validating it's within allowed size.</td></tr><tr><td>45</td><td><strong>POST /api/getSubProcess</strong></td><td>Fetches details of a specific subprocess attempt.</td></tr><tr><td>46</td><td><strong>GET /api/inventory/{collectionId}/openapi</strong></td><td>Retrieve OpenAPI specification for a specific API collection.</td></tr><tr><td>47</td><td><strong>POST /api/getAPICatalog</strong></td><td>Retrieve the complete API catalog with all discovered APIs.</td></tr><tr><td>48</td><td><strong>POST /api/fetchCollections</strong></td><td>Fetch all available API collections.</td></tr><tr><td>49</td><td><strong>POST /api/getCollection</strong></td><td>Get details of a specific API collection.</td></tr><tr><td>50</td><td><strong>POST /api/fetchIconsForHostnames</strong></td><td>Fetch icons for given hostnames.</td></tr><tr><td>51</td><td><strong>POST /api/getApiSequences</strong></td><td>Get API call sequences for a collection.</td></tr><tr><td>52</td><td><strong>POST /api/getSwaggerDependencies</strong></td><td>Get Swagger/OpenAPI dependencies for APIs.</td></tr><tr><td>53</td><td><strong>POST /api/getCountForHostnameDeactivatedCollections</strong></td><td>Get count of deactivated collections per hostname.</td></tr><tr><td>54</td><td><strong>POST /api/getCountForUningestedApis</strong></td><td>Get count of unintegrated APIs.</td></tr><tr><td>55</td><td><strong>POST /api/fetchUningestedApis</strong></td><td>Fetch all unintegrated APIs.</td></tr><tr><td>56</td><td><strong>POST /api/getSensitiveAndUnauthenticatedValue</strong></td><td>Get sensitive fields and unauthenticated endpoints.</td></tr><tr><td>57</td><td><strong>POST /api/getHighRiskThirdPartyValue</strong></td><td>Get high-risk third-party APIs.</td></tr><tr><td>58</td><td><strong>POST /api/getShadowApis</strong></td><td>Get shadow/unmanaged APIs.</td></tr><tr><td>59</td><td><strong>POST /api/fetchActionItemsApiInfo</strong></td><td>Fetch action items related to API information.</td></tr><tr><td>60</td><td><strong>POST /api/fetchAllUnauthenticatedApis</strong></td><td>Fetch all unauthenticated APIs.</td></tr><tr><td>61</td><td><strong>POST /api/getCustomerEndpoints</strong></td><td>Get customer endpoints statistics.</td></tr><tr><td>62</td><td><strong>POST /api/getDeMergedApis</strong></td><td>Get list of de-merged APIs.</td></tr><tr><td>63</td><td><strong>POST /api/fetchNonStandardHeaderKeys</strong></td><td>Fetch non-standard headers found in APIs.</td></tr><tr><td>64</td><td><strong>POST /api/getUniqueHostsTested</strong></td><td>Get count of unique hosts that have been tested.</td></tr><tr><td>65</td><td><strong>POST /api/fetchCountMapOfApis</strong></td><td>Fetch count map of APIs by data type.</td></tr></tbody></table>



{% openapi-operation spec="akto-agentic-security-api" path="/api/getAllCollectionsBasic" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getSeverityInfoForCollections" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getLastSeenTrafficInfoForCollections" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getSensitiveInfoForCollections" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getRiskScoreInfo" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getCoverageInfoForCollections" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getAllCollections" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getAllUsersCollections" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getSeveritiesCountPerCollection" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchCollectionWiseApiEndpoints" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchIpLevelApiCallStats" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchApiInfosForCollection" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchApiCallStats" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchEndpointsCount" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchSampleData" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/generateOpenApiFile" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchAllUrlsAndMethods" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchNewEndpointsTrendForHostCollections" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchNewEndpointsTrendForNonHostCollections" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchAPICollection" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchChanges" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchCustomAuthTypes" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchDataTypeNames" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchDataTypes" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchEndpointTrafficData" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchNewParametersTrend" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchSensitiveParamsForEndpoints" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchTagConfigs" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/loadRecentEndpoints" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/checkAgentRunModule" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchMcpAuditInfoByCollection" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchMcpToolsApiCalls" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getAgentLogs" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getAgentModels" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getAllAgentRunningDetails" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getAllAgentRuns" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getAllAgentRunsObject" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getMcpServersByAgent" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getMcpdata" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getMemberAgents" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/receiveDataFromAgent" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchAllResponsesForApiCollectionOrdered" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getAllSubProcesses" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getFileForDiscovery" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getSubProcess" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/inventory/{collectionId}/openapi" method="get" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getAPICatalog" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchCollections" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getCollection" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchIconsForHostnames" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getApiSequences" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getSwaggerDependencies" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getCountForHostnameDeactivatedCollections" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getCountForUningestedApis" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchUningestedApis" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getSensitiveAndUnauthenticatedValue" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getHighRiskThirdPartyValue" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getShadowApis" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchActionItemsApiInfo" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchAllUnauthenticatedApis" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getCustomerEndpoints" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getDeMergedApis" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchNonStandardHeaderKeys" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/getUniqueHostsTested" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="akto-agentic-security-api" path="/api/fetchCountMapOfApis" method="post" %}
[OpenAPI akto-agentic-security-api](https://raw.githubusercontent.com/akto-api-security/Documentation/refs/heads/agentic_security/.gitbook/assets/AktoSwagger.json)
{% endopenapi-operation %}

