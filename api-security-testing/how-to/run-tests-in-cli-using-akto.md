# Run tests in CLI using Akto

You can also run Akto testing module on your CLI.

### When to use

* You can use the CLI if you want to run Akto tests locally on any API Collection.
* The results from the CLI are NOT saved in Akto dashboard.
* It is best used when developers want to run tests locally before committing to their branch. Note that the application host is chosen as in the API Collection by default.
* You choose to override the application host url to localhost or a different staging URL.

### How to use

Prepare the following environment vars -

1. `AKTO_API_KEY` - Go to My accounts > Settings > Integrations > Akto API > Generate token. Copy the token generated.
2. `AKTO_DASHBOARD_URL` - URL of your dashboard. Please ensure you can access dashboard
3. `TEST_IDS` - Space-separated list of test IDs which you want to run eg. `JWT_NONE_ALGO REMOVE_TOKENS` . You can also set it as `ALL` to run all tests.
4. `API_COLLECTION_NAME` - API collection name on which you want to run tests eg. juice\_shop\_demo.
5. `API_COLLECTION_ID` - API collection id (integer) you want to run tests eg. 29623412. Only one of `API_COLLECTION_NAME` and `API_COLLECTION_ID` is required.
6. `TEST_APIS` - Space-separated list of APIs you want to test. If absent, all APIs are selected
7. `OVERRIDE_APP_URL` - change the staging application host. Akto will test APIs on this host
8. `OUTPUT_LEVEL` - Output level of the result file. We have 4 output levels:
   1. `NONE` - No output file is generated.
   2. `SUMMARY` - \[Default] The output file contains the tests executed and a list of all vulnerable APIs.
   3. `DETAILED` - The output file contains the `SUMMARY` as well as description and impact of the executed tests.
   4. `DEBUG` - The output file contains `DETAILED` output along with the original and attempt request and response for all the API tests.

Example CLI - (If you are not on Linux, please provide absolute path to your current directory instead of ${PWD})

```bash
docker run -v ${PWD}:/out \
   -e AKTO_DASHBOARD_URL=https://flash.staging.akto.io \
   -e TEST_IDS=JWT_NONE_ALGO \
   -e API_COLLECTION_ID=1689063104 \
   -e AKTO_API_KEY=OAzudPuzo8kh1234jCHtL3Vf0lTFzvDYZQMaKh4w \
   -e OUTPUT_LEVEL=DETAILED \
   aktosecurity/akto-api-testing-cli:latest
```

### Results

1. A short summary (API, Vulnerability, Severity) is printed on command line itself
2. A file `output.txt` contains details of the test, based on the output level given.
3. If you see version mismatch error, consider matching release version of your dashboard vs testing-cli

Sample results -

<figure><img src="https://github.com/akto-api-security/Documentation/assets/91221068/d6685ffe-463a-49ea-85c8-0fc670714c49" alt=""><figcaption></figcaption></figure>

### Limitations

1. Results are not saved in Akto dashboard.
2. Tests which use _context_ will be skipped eg. `AddUserId.yml`, `OldApiVersion.yml` etc.
