# Webhook alerts

You can receive alerts via Slack or Webhooks about new APIs and new sensitive parameters in existing APIs. This guide helps to set up webhook alerts.

## Add a webhook

1. Go to `My accounts` > `Settings` > `Integrations` in Akto dashboard <figure><img src="https://github-production-user-asset-6210df.s3.amazonaws.com/91221068/240230705-ce9013a1-c148-4fd5-8667-8331ccdb9a46.png" alt=""><figcaption></figcaption></figure>

2. Select `Webhooks` under `Alerts` category. <figure><img src="https://github-production-user-asset-6210df.s3.amazonaws.com/91221068/240230892-d9626233-b94a-4ff0-a273-72fc46bcde7a.png" alt=""><figcaption></figcaption></figure>

3. Click on `Create new webhook` button <figure><img src="https://github-production-user-asset-6210df.s3.amazonaws.com/91221068/240231569-ba32d792-8229-4c27-8e5d-3e8dcd09c76d.png" alt=""><figcaption></figcaption></figure>

4. Click on the `edit` icon on the right, enter your webhook name and click on `save` icon to save webhook name. <figure><img src="https://github-production-user-asset-6210df.s3.amazonaws.com/91221068/240231582-40e0aaae-e1c2-4d4c-b09e-82a898d62d56.png" alt=""><figcaption></figcaption></figure>

5. Click `edit` on Webhook URL, enter your webhook URL and click on `save` icon to save webhook URL. <figure><img src="https://github-production-user-asset-6210df.s3.amazonaws.com/91221068/240231603-7bf6750a-fbf1-4710-9d24-d2632064a642.png" alt=""><figcaption></figcaption></figure>

6. Under `Options`, select all the data points you want in webhook alert payload <figure><img src="https://github-production-user-asset-6210df.s3.amazonaws.com/91221068/240231702-2376de50-5ed3-4027-8c91-d3fe5bc1abe9.png" alt=""><figcaption></figcaption></figure>

7. Select one or more collections to alert for new endpoints. If you don't select any API collection, webhook will be triggered for any new API added to any collection. <figure><img src="https://github-production-user-asset-6210df.s3.amazonaws.com/91221068/240231735-0a251880-2b09-49bc-ad9e-e3f9d1cabd75.png" alt=""><figcaption></figcaption></figure>

8. Select the frequency with which you want to receive alerts.<figure><img src="https://github-production-user-asset-6210df.s3.amazonaws.com/91221068/240234723-40dd2dc2-17ae-4865-891d-ee5e33a62cda.png" alt=""><figcaption></figcaption></figure>
9. Sample webhook payload for new endpoint <figure><img src="https://github-production-user-asset-6210df.s3.amazonaws.com/91221068/240234784-7f5c8f7e-3920-425f-bbef-0e4e0bcbde74.png" alt=""><figcaption></figcaption></figure>
10. Sample webhook payload for new sensitive endpoint. Note that an extra field `subtypes` is present that mentions the type of sensitive params in the API. <figure><img src="https://github-production-user-asset-6210df.s3.amazonaws.com/91221068/240235430-61ec8d82-5b56-4f4e-bfdb-b407e4db14e7.png" alt=""><figcaption></figcaption></figure>

