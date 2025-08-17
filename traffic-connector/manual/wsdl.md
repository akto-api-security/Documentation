# API Import: WSDL in Akto

You can import SOAP APIs into Akto by uploading a **WSDL (Web Services Description Language)** file. This allows Akto to automatically generate an API inventory for your SOAP APIs and start testing them.

<figure><img src="../../.gitbook/assets/image (2) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

***

### How to Import

To import your WSDL:

1. Go to **Quick Start** in the Akto dashboard.
2. Click **Connect** under **Manual >** **SOAP API**.
3. Follow the steps to upload your WSDL file using Postman.

👉 For detailed Postman integration steps, visit the guide: [Integrating Postman with Akto](postman.md#integrating-postman)

{% hint style="info" %}
✅ Enable “**Allow Akto to replay API requests if responses are not found**” to let Akto automatically retry missing responses and improve inventory accuracy.
{% endhint %}

Once the WSDL is uploaded, Akto will automatically populate your API inventory and you can start security testing.
