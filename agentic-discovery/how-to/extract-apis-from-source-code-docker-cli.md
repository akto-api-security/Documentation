---
hidden: true
description: Extract agent components from source code using Docker-based CLI for static code analysis.
---

# Extract Agent Components from Source Code using Docker CLI

You can extract agent components and MCP endpoints from your code repositories using our Docker-based CLI. This static analysis tool scans your codebase to discover AI agent implementations, MCP server definitions, and agentic integrations.

## How to Use

Prepare the following variables:

1. `AKTO_SYNC` - Set this to `TRUE` if you want the CLI to import the extracted components into the Akto dashboard
2. `AKTO_API_KEY` - Go to My accounts > Settings > Integrations > Akto API > Generate token. Copy the token generated
3. `AKTO_DASHBOARD_URL` - URL of your Akto dashboard. Please ensure the docker container can access the Akto dashboard
4. `COLLECTION_NAME` - The agentic collection name into which you want to import the extracted components. Ensure that this collection exists
5. `GITHUB_REPOSITORY` - The name of the Github repository to be used for source location links
6. `GITHUB_BRANCH` - The branch of the Github repository to be used for source location links

## Extract Components Locally

To extract agent components from a local code repository, run the following docker command in a terminal:

```bash
docker run -it --rm -v "$(pwd)":/usr/source_code \
  aktosecurity/akto-puppeteer-replay:doom_latest cli extract \
    --IS_DOCKER="true"
```

**Command explanation:**

- `-it` - enables interactive terminal input, allowing command line interaction
- `--rm` - automatically removes container after it exits
- `-v "$(pwd)":/usr/source_code` - mounts current directory to /usr/source_code in the container

## Import into Akto Dashboard

To import the extracted agent components into a collection in Akto dashboard, run the following command:

```bash
docker run -it --rm -v "$(pwd)":/usr/source_code \
  aktosecurity/akto-puppeteer-replay:doom_latest cli extract \
  		--IS_DOCKER="true" \
			--AKTO_SYNC="true" \
			--AKTO_DASHBOARD_URL="AKTO_DASHBOARD_URL" \
			--AKTO_API_KEY="AKTO_API_KEY" \
			--COLLECTION_NAME="production_ai_agents"
```

## Add Source Code Links

To add source code links to the extracted agent components for better traceability, run:

```bash
docker run -it --rm -v "$(pwd)":/usr/source_code \
  aktosecurity/akto-puppeteer-replay:doom_latest cli extract \
  		--IS_DOCKER="true" \
			--AKTO_SYNC="true" \
			--AKTO_DASHBOARD_URL="AKTO_DASHBOARD_URL" \
			--AKTO_API_KEY="AKTO_API_KEY" \
			--COLLECTION_NAME="production_ai_agents" \
      --GITHUB_REPOSITORY="your-org/your-agentic-app" \
      --GITHUB_BRANCH="main"
```

## What Gets Extracted

The CLI analyzes your source code to discover:

- **AI Agent Definitions**: LangChain agents, LlamaIndex agents, CrewAI agents, etc.
- **MCP Server Implementations**: MCP server definitions and tool registrations
- **Tool Definitions**: Custom tools and functions accessible by agents
- **Agent Endpoints**: HTTP endpoints that expose agent functionality
- **Framework Integrations**: OpenAI, Anthropic, and other LLM provider integrations
- **Data Sources**: Databases, APIs, and resources accessed by agents

## Results

1. The agentic collection as specified by the `COLLECTION_NAME` variable can be viewed in the Akto dashboard under **Agentic Discovery > Collections**
2. All extracted agent components will include source code links if GitHub repository information was provided
3. Components are automatically tagged with detected frameworks and technologies
