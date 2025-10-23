---
description: Copy MCP endpoint data for testing, debugging, and analysis.
---

# Copy MCP Component Data

You can copy MCP endpoint request/response data in `curl` format or for use in testing tools. This helps with troubleshooting MCP server integrations and security testing.

## How to Copy

1. Navigate to **Agentic Discovery > Collections**
2. Select your MCP collection and click on an endpoint
3. Click the **Copy** button in the endpoint details panel
4. Choose format:
   - **curl**: For terminal testing
   - **Burp**: For Burp Suite testing
   - **Raw**: For custom analysis

## What Gets Copied

- MCP tool invocation requests
- Tool response samples
- Resource access patterns
- Authentication headers
- Request parameters and schemas

## Use Cases

- **Testing**: Validate MCP tool behavior
- **Debugging**: Analyze MCP server responses
- **Security Testing**: Test tool permission bypasses
- **Documentation**: Create MCP integration examples
- **Monitoring**: Track MCP tool performance
