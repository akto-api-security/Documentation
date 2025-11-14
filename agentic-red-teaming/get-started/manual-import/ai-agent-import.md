# AI Agent Import

Akto lets you seamlessly import **AI agents** such as **AWS Bedrock, Azure AI Foundry, Databricks, Google Vertex AI, IBM Watsonx**, or even your **custom agent** into **AI Agent Security**. With just the agent endpoint URL and optional configuration, you can start monitoring and testing agent activity instantly.

<figure><img src="../../../.gitbook/assets/image.png" alt=""><figcaption></figcaption></figure>

***

### 🔧 What You Need

* **AI Endpoint URL** (e.g., `https://api.example.com/ai-agent`)
* **(Optional) Custom Request Body** – for agents requiring specific input JSON
* **(Optional) Test Role for Authentication** – for agents with role-based access

<figure><img src="../../../.gitbook/assets/image (2).png" alt=""><figcaption></figcaption></figure>

***

### ✅ Steps to Import

1. **Open Akto Dashboard** → Go to _Quick Start_
2. **Select your AI Agent provider** (Bedrock, Azure AI Foundry, Databricks, Vertex AI, Watsonx, or _Bring Your Own Agent_)
3. **Click “Connect”**
4. **Fill in agent details**:
   * **AI Endpoint URL**: e.g., `https://api.example.com/ai-agent`
   *   _(Optional)_ Check **Use custom request body** and enter JSON payload:

       ```json
       { "key": "value" }
       ```
   * _(Optional)_ Enable **Use test role for authentication** and select a role (e.g., `ATTACKER_TOKEN_ALL`)
5. **Click Import**

Akto will automatically:

* Connect to the AI agent endpoint
* Send sample test requests to validate the configuration
* Register the agent into **AI Agent Security Inventory** for monitoring and testing

***

### 📂 Supported AI Agents

* **AWS Bedrock** – Import Bedrock agents seamlessly
* **Azure AI Foundry** – Import Azure AI Foundry agents seamlessly
* **Databricks** – Import Databricks agents seamlessly
* **Google Vertex AI** – Import Vertex AI agents seamlessly
* **IBM Watsonx** – Import Watsonx agents seamlessly
* **Bring Your Own AI Agent** – Import any custom AI agent seamlessly

***

### 🔒 Security

* Auth/test roles (if any) are used **only during import** and are **not stored**
* Akto uses **read-only access** to interact with your AI agent

***

### Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
