# Configure Access Types

You can configure [Access Types](configure-access-types.md) on Akto dashboard. Access Types are based on the IPs in the `X-Forwarded-For` header.

You should configure the Private IP list and Partner IP list to get an accurate view of how your APIs are exposed to the world. A `Private` microservice should NOT be hit from the `Public` domain.&#x20;

Go to **Settings** > **About**. Scroll down to check Private CIDRs list and Partner CIDRs list. You can add a comma-separated list of CIDRs.&#x20;

{% embed url="https://demo.arcade.software/X7j4ft1T1NiX419LlwHr" %}
