# Connect Akto with LangChain

<figure><img src="../.gitbook/assets/langchain.png" alt=""><figcaption></figcaption></figure>

LangChain is a framework for developing applications powered by language models. This setup is recommended if you want to monitor API traffic from your LangChain applications and ensure your AI-powered processes maintain security standards.

The Akto LangChain connector automatically:
- Fetches all LangChain application metadata
- Monitors LangChain executions
- Sends API traffic data to Akto for security analysis

## Step 1: Configure Akto Traffic Processor

Set up and configure Akto Traffic Processor. The steps are mentioned [here](https://docs.akto.io/getting-started/traffic-processor/hybrid-saas).

## Step 2: Clone the Akto Infrastructure Repository

Clone the Akto infrastructure repository:

```bash
wget https://raw.githubusercontent.com/akto-api-security/infra/refs/heads/feature/quick-setup/docker-compose-langchain-cron.yaml

wget https://raw.githubusercontent.com/akto-api-security/infra/refs/heads/feature/quick-setup/langchain-cron.env

wget https://raw.githubusercontent.com/akto-api-security/infra/refs/heads/feature/quick-setup/watchtower.env
```

## Step 3: Configure LangChain Environment Variables

Update the following variables in the `langchain-cron.env` file:

```bash
LANGCHAIN_BASE_URL=https://<YOUR_LANGSMITH_URL>
LANGCHAIN_API_KEY=<API_KEY>
AKTO_KAFKA_BROKER_URL=kafka1:19092
```

## Step 4: Start the LangChain Traffic Connector

Run the following command to start the LangChain traffic connector:

```bash
docker compose -f docker-compose-langchain-cron.yaml up
```

This will start monitoring your LangChain applications and send API traffic data to Akto for analysis.

## What Data is Collected?

The LangChain connector collects execution data from your LangChain applications:

### Application Metadata
- All LangChain applications and traces

### Execution Data
- Recent execution traces
- Input and output data

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
