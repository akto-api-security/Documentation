# Akto java agent

### Track data sent from backend through third party APIs

<mark style="color:purple;">**Akto helps you track sensitive PII data leakage from your third-party APIs. 💪🏽**</mark>

Track outgoing data sent through third party APIs from your backend servers using Akto's agent. Below is the guide to integrate java agent.

The Java agent installation involves copying all the unzipped Akto files into the directory structure of your application server/container.

1. Download the agent from [here](https://akto-setup.s3.amazonaws.com/templates/javaagent-1.0-SNAPSHOT-jar-with-dependencies.jar) and put it in your application server directory.
2. Get the private ip of your Akto dashboard. Use this private ip in the next step
3. Include the below option to your application server/container when it starts Java ( Make sure you add your akto\_dashboard ip you fetch in the previous step. `-javaagent:/path/to/javaagent-1.0-SNAPSHOT-jar-with-dependencies.jar=<`<mark style="color:purple;">`akto_dashboard_ip`</mark>`>:9092`
4. Deploy the application server

{% hint style="info" %}
**How it works:** This agent intercepts all the http calls from the attached java process. The performance impact is negligible ( <0.1% ). Your attached java process will not be impacted at all.&#x20;
{% endhint %}
