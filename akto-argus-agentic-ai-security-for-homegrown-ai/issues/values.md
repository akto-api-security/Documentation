# Values

The Values tab in the Issue details provides in-depth information about the specific agent component interactions associated with the detected vulnerability. When examining an issue, the Values tab offers detailed insights into the agent invocations, tool calls, or MCP endpoint interactions that triggered the security concern. This includes both the requests sent to agent components and the responses received, allowing for a comprehensive analysis of the vulnerability context.

### Request

The request section typically displays:

* HTTP method used
* Agent component endpoint or MCP server path
* Headers sent with the request
* Prompt data or tool parameters included in the request body
* Authentication tokens or agent credentials

This information helps in understanding how the agent component was invoked and what data was sent, which is crucial for identifying the root cause of agentic security issues.

### Response

The response section usually shows:

* HTTP status code
* Response headers
* Body of the response from the agent or LLM
* Tool execution results
* Data returned from MCP endpoints

Analyzing the response data is essential for understanding how the agent component reacted to the potentially vulnerable request and what information may have been exposed through agent interactions.

### Usage

Examining the Values tab allows you to:

1. Understand the exact nature of the agentic vulnerability by seeing the raw data exchanged
2. Identify specific prompts, tool parameters, or payload elements causing the security issue
3. Verify the severity and impact of the vulnerability based on the actual data exposed or manipulated through agent interactions
4. Guide the development of precise fixes by pinpointing problematic parts of agent requests or responses
5. Analyze tool permission violations or prompt injection attempts

The Values tab is crucial to gain a detailed understanding of each detected agentic vulnerability, facilitating more effective and targeted remediation efforts.
