---
hidden: true
---

# Extract APIs from source code using our Docker based CLI

You can extract APIs from your code repositories using our Docker based CLI.

### How to use

Prepare the following variables:

1. `AKTO_SYNC` - Set this to `TRUE` if you want the CLI to import the extracted APIs into the Akto dashboard
2. `AKTO_API_KEY` - Go to My accounts > Settings > Integrations > Akto API > Generate token. Copy the token generated.
3. `AKTO_DASHBOARD_URL` - URL of your Akto dashboard. Please ensure the docker container can access the Akto dashboard,
4. `API_COLLECTION_NAME` - The API collection name into which you want to import the extracted APIs. Ensure that this collection exists.
5. `GITHUB_REPOSITORY` - The name of the Github repository to be used for source location links.
6. `GITHUB_BRANCH` - The branch of the Github repository to be used for source location links.

To extract APIs from a local code repository, run the following docker run command in a terminal:

```bash
docker run -it --rm -v "$(pwd)":/usr/source_code \
  aktosecurity/akto-puppeteer-replay:doom_latest cli extract \
    --IS_DOCKER="true"
```

Explanation:

1. `-it` - enables interactive terminal input, allowing command line interaction.
2. `--rm` - automatically removes container after it exits.
3. `-v "$(pwd)":/usr/source_code` - mounts current directory to /usr/source\_code in the container.

To import the extracted APIs into an API collection in Akto dashboard, run the following docker run command in a terminal:

```bash
docker run -it --rm -v "$(pwd)":/usr/source_code \
  aktosecurity/akto-puppeteer-replay:doom_latest cli extract \
  		--IS_DOCKER="true" \
			--AKTO_SYNC="true" \
			--AKTO_DASHBOARD_URL="AKTO_DASHBOARD_URL" \
			--AKTO_API_KEY="AKTO_API_KEY" \
			--API_COLLECTION_NAME="juice_shop_demo"
```

To add source code links to the extracted APIs, run the following docker run command in a terminal:

```bash
docker run -it --rm -v "$(pwd)":/usr/source_code \
  aktosecurity/akto-puppeteer-replay:doom_latest cli extract \
  		--IS_DOCKER="true" \
			--AKTO_SYNC="true" \
			--AKTO_DASHBOARD_URL="AKTO_DASHBOARD_URL" \
			--AKTO_API_KEY="AKTO_API_KEY" \
			--API_COLLECTION_NAME="juice_shop_demo" \
      --GITHUB_REPOSITORY="akto-api-security/juice-shop" \
      --GITHUB_BRANCH="master"
```

### Results

1. The API collection as specified by the `API_COLLECTION_NAME` variable can be viewed in the Akto dashboard to review the APIs extracted from source code.
