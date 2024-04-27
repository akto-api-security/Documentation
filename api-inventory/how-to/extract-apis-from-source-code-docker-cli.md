# Extract APIs from source code using Docker based CLI

You can extract APIs from your code repositories using our Docker based CLI.

### How to use

Prepare the following variables:
1. `AKTO_SYNC` - Set this to `TRUE` if you want the CLI to import the extracted APIs into the Akto dashboard
2. `AKTO_API_KEY` - Go to My accounts > Settings > Integrations > Akto API > Generate token. Copy the token generated.
3. `AKTO_DASHBOARD_URL` - URL of your Akto dashboard. Please ensure the github action runner can access the Akto dashboard,
4. `API_COLLECTION_NAME` - The API collection name into which you want to import the extracted APIs. Ensure that this collection exists.
5. `GITHUB_REPOSITORY` - The name of the Github repository to be used for source location links.
6. `GITHUB_BRANCH` - The branch of the Github repository to be used for source location links.


To extract 
```yaml
- name: Akto code analysis
  uses: akto-api-security/code-analysis-action@v1
  with:
    AKTO_DASHBOARD_URL: "<AKTO_DASHBOARD_URL>"
    AKTO_API_KEY: ${{ secrets.AKTO_API_KEY }}
    API_COLLECTION_NAME: juice_shop_demo
```

### Results

1. A summary of all the extracted APIs should be avaialbe in the Github workflow run summary. The summary includes a list of the new APIs that were added in the present commit. 
2. The API collection as specified by the `API_COLLECTION_NAME` variable can be viewed in the Akto dashboard to review the APIs extracted from source code.

<figure><img src="../../.gitbook/assets/code_analysis_github_actions_summary.png" alt=""><figcaption><p>Github workflow summary</p></figcaption></figure>