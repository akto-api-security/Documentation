---
hidden: true
description: Understand agent component sequences and workflow patterns in your agentic systems.
---

# Agent Component Sequences

## Overview

Agent component sequences are chains of component invocations that represent user or agent workflows. Identifying these sequences is critical for:

- Detecting logic-based vulnerabilities in agentic workflows
- Improving security testing coverage
- Understanding agent usage patterns and behavior
- Identifying potential security risks in multi-step operations

Akto automatically detects component sequences based on traffic patterns and presents them with visual flow charts and associated statistics.

## Component Sequence Statistics

The **Component Sequences Overview** section gives a snapshot of the identified sequences:

- **Total Sequences**: Number of detected unique agent workflows
- **Total Transitions**: Number of component invocations between steps
- **Avg Probability**: Likelihood of these sequences occurring in real traffic (based on behavioral analysis)

Example metrics:
- **10 Total Sequences**
- **196 Total Transitions**
- **67.1% Avg Probability**

## How Sequences Are Formed

Akto analyzes live traffic to group agent components into sequences by:

1. **Temporal Proximity**: Component invocations made in close succession
2. **Entity Linkage**: Requests sharing identifiers (like `userId`, `sessionId`, `conversationId`)
3. **Agent Flow Logic**: Common patterns like `agent init → tool invocation → response generation`
4. **Data Dependencies**: When output from one component becomes input to another

Each node in the sequence represents a component (e.g., `agent/chat`, `mcp/filesystem/read`), and edges indicate transitions and data flow.

## Common Agent Sequence Patterns

### User Interaction Flow
```
User Request → Agent Router → Context Retrieval → LLM Invocation → Tool Execution → Response
```

### MCP Tool Chain
```
Agent Init → MCP Discovery → Tool Selection → Tool Invocation → Result Processing
```

### Multi-Agent Workflow
```
Primary Agent → Sub-Agent 1 → Sub-Agent 2 → Result Aggregation → Final Response
```

## Get Support

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply
2. Join our [discord channel](https://www.akto.io/community) for community support
3. Contact `help@akto.io` for email support
4. Contact us [here](https://www.akto.io/contact-us)
