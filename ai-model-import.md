# AI Model Import

Akto lets you seamlessly import AI models like **Gemini, OpenAI, Claude, DeepSeek, Llama, Grok**, or even your **custom model** into **AI Model Security**. With just your model’s endpoint URL and optional authentication, you can start monitoring and testing instantly.

<figure><img src=".gitbook/assets/image (139).png" alt=""><figcaption></figcaption></figure>

***

### 🔧 What You Need

* **AI Endpoint URL** (e.g., `https://api.example.com/ai-agent`)
* **(Optional) Authentication details** if your AI model requires them
* **(Optional) Custom request body** for models that need non-standard inputs

<figure><img src=".gitbook/assets/image (140).png" alt=""><figcaption></figcaption></figure>

***

### ✅ Steps to Import

1. **Open Akto Dashboard** → Go to _Quick Start_
2. **Select your AI model provider** (Gemini, OpenAI, Claude, DeepSeek, Llama, Grok, or _Bring Your Own Model_)
3. **Click “Connect”**
4. **Fill in model details**:
   * **AI Endpoint URL**: e.g., `https://api.example.com/ai-agent`
   * _(Optional)_ Enable **custom request body** if the model requires non-default payloads
   * _(Optional)_ Use **test role for authentication** if your AI model enforces role-based access
5. **Click Import**

Akto will automatically:

* Connect to the AI model endpoint
* Validate request/response format
* Add the model into **AI Model Security Inventory** for monitoring and testing

***

### 📂 Supported Models

* **Gemini** – Import Google Gemini seamlessly
* **OpenAI** – Import OpenAI models seamlessly
* **Claude** – Import Anthropic Claude seamlessly
* **DeepSeek** – Import DeepSeek seamlessly
* **Llama** – Import Meta Llama seamlessly
* **Grok** – Import xAI Grok seamlessly
* **Bring Your Own Model** – Import custom AI models seamlessly

***

### 🔒 Security

* Auth tokens/headers (if used) are **only applied during import** and are **not stored**
* Akto uses **read-only access** to interact with your AI endpoint

***

### Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
