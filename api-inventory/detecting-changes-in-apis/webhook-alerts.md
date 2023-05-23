# Webhook alerts

You can receive alerts via Slack or Webhooks about new APIs and new sensitive parameters in existing APIs. This guide helps to set up webhook alerts.

## Add a webhook

1. Go to `My accounts` > `Settings` > `Integrations` in Akto dashboard![Open Integrations](https://github.com/akto-api-security/Documentation/assets/91221068/ce9013a1-c148-4fd5-8667-8331ccdb9a46)
2. Select `Webhooks` under `Alerts` category.  ![Select webhooks](https://github.com/akto-api-security/Documentation/assets/91221068/d9626233-b94a-4ff0-a273-72fc46bcde7a)
3. Click on `Create new webhook` button![Create new webhook](https://github.com/akto-api-security/Documentation/assets/91221068/ba32d792-8229-4c27-8e5d-3e8dcd09c76d)

4. Click on the `edit` icon on the right, enter your webhook name and click on `save` icon to save webhook name.![set name](https://github.com/akto-api-security/Documentation/assets/91221068/40e0aaae-e1c2-4d4c-b09e-82a898d62d56)

5. Click `edit` on Webhook URL, enter your webhook URL and click on `save` icon to save webhook URL.![set url](https://github.com/akto-api-security/Documentation/assets/91221068/7bf6750a-fbf1-4710-9d24-d2632064a642)

6. Under `Options`, select all the data points you want in webhook alert payload![select options](https://github.com/akto-api-security/Documentation/assets/91221068/2376de50-5ed3-4027-8c91-d3fe5bc1abe9)

7. Select one or more collections to alert for new endpoints. If you don't select any API collection, webhook will be triggered for any new API added to any collection. ![select collections](https://github.com/akto-api-security/Documentation/assets/91221068/0a251880-2b09-49bc-ad9e-e3f9d1cabd75)

8. Select the frequency with which you want to receive alerts. ![select period](https://github.com/akto-api-security/Documentation/assets/91221068/40dd2dc2-17ae-4865-891d-ee5e33a62cda)
9. Sample webhook payload for new endpoint![new endpoint webhook](https://github.com/akto-api-security/Documentation/assets/91221068/7f5c8f7e-3920-425f-bbef-0e4e0bcbde74)
10. Sample webhook payload for new sensitive endpoint. Note that an extra field `subtypes` is present that mentions the type of sensitive params in the API. ![sens ep](https://github.com/akto-api-security/Documentation/assets/91221068/61ec8d82-5b56-4f4e-bfdb-b407e4db14e7)

