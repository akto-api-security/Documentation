---
description: Organize and categorize related agent components using Agent Groups.
---

# Agent Groups

Agent Groups are a feature in Akto that allow you to organize and categorize related agent components and endpoints. This functionality helps in managing large agentic inventories by grouping components based on common characteristics, functionalities, frameworks, or any other relevant criteria.

## What is an Agent Group?

An Agent Group is a logical collection of agent components that share common attributes. Unlike collections, which are primarily for discovery and organization, groups enable you to:

- Apply bulk security policies
- Run targeted security tests
- Monitor related components together
- Manage access control at the group level
- Track metrics across similar agents

## Common Agent Grouping Strategies

### By Framework

Group agents using the same framework:
- **LangChain Agents**: All agents built with LangChain
- **LlamaIndex Agents**: Query engines and agents using LlamaIndex
- **CrewAI Multi-Agent Systems**: CrewAI agent orchestrations
- **Custom Framework Agents**: Your proprietary agent implementations

### By Functionality

Group agents by their purpose:
- **Customer Service Agents**: Chat agents, support bots
- **Data Analysis Agents**: RAG systems, query agents
- **Workflow Automation Agents**: Task automation, orchestration
- **Code Assistants**: Developer tools, code generation agents

### By Risk Level

Group agents by security risk:
- **High-Risk Agents**: Public-facing, handling sensitive data
- **Medium-Risk Agents**: Internal use with limited data access
- **Low-Risk Agents**: Read-only, non-sensitive operations

### By Environment

Group agents by deployment environment:
- **Production Agents**: Live, customer-facing systems
- **Staging Agents**: Pre-production testing
- **Development Agents**: Development and experimentation

### By LLM Provider

Group agents by the AI provider they use:
- **OpenAI Agents**: Using GPT-4, GPT-3.5, etc.
- **Anthropic Agents**: Using Claude models
- **Google Agents**: Using Gemini, PaLM
- **Self-Hosted Agents**: Using local or private models

## Use Cases

### Security Testing by Group

Run comprehensive security tests on:
- All customer-facing agents
- All agents with database access
- All agents handling PII
- All public API agents

### Cost Management

Track and optimize costs for:
- High-token-usage agent groups
- Premium model usage groups
- External API calling agents

### Performance Optimization

Monitor and improve:
- Response times for customer service agents
- Token efficiency for similar agents
- Tool invocation patterns by group

Agent groups are a powerful tool for organizing your agentic inventory, enabling more efficient management, security testing, and analysis of your AI agent systems.
