---
description: Copy agent component data for testing, debugging, and analysis.
---

# Copy Agent Component Data

You can copy agent component request/response data in `curl` format or for use in testing tools. This helps with troubleshooting, debugging, and security testing.

## How to Copy

1. Navigate to **Agentic Discovery > Collections**
2. Select your collection and click on an agent component
3. Click the **Copy** button in the component details panel
4. Choose format:
   - **curl**: For terminal replay
   - **Burp**: For Burp Suite testing
   - **Raw**: For custom tools

## What Gets Copied

- Request structure (prompts, inputs, parameters)
- Response samples (agent outputs, LLM responses)
- Headers and authentication
- Tool invocations (for MCP-integrated agents)
- Context data (if available)

## Use Cases

- **Testing**: Replay agent requests for validation
- **Debugging**: Analyze agent behavior with specific inputs
- **Security Testing**: Test prompt injection with copied requests
- **Documentation**: Create examples for team reference
- **Version Control**: Track agent behavior changes over time
