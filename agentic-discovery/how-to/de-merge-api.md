# De-merge API

Akto automatically merges APIs when it detects changing elements like UUIDs, String, Integer, etc in endpoints. This helps keep your API inventory clean and organized. However, there might be cases where you want to separate these merged APIs.

{% @arcade/embed flowId="XotQ1dCbLDUUsblmFAym" url="https://app.arcade.software/share/XotQ1dCbLDUUsblmFAym" %}



### Steps to De-merge APIs:

1. Go to API Collection page from left nav
2. Open your API Collection
3. Select the API endpoint you want to de-merge
4. Click on more options and then click on `De merge` button

### This action will:

* Split the merged endpoint back into separate API endpoints
* Restore individual tracking for each endpoint
* Maintain all existing test coverage and security checks
* Keep your API inventory accurate while giving you more granular control
