# Run tests in CLI using Akto

You can run Akto testing module via CLI for local testing of agent components.

## When to Use

* Run Akto tests locally on any agent collection
* Results from CLI are NOT saved in Akto dashboard
* Best used when developers want to run tests locally before committing code
* Override application host URL to localhost or different staging URL

## How to Use

Prepare the following environment variables:

1. `AKTO_API_KEY` - Go to My accounts > Settings > Integrations > Akto API > Generate token
2. `AKTO_DASHBOARD_URL` - URL of your dashboard
3. `TEST_IDS` - Space-separated list of test IDs to run (e.g., `PROMPT_INJECTION MCP_AUTH_BYPASS`) or `ALL` for all tests
4. `API_COLLECTION_NAME` - Collection name to test (e.g., agent\_collection)
5. `API_COLLECTION_ID` - Collection ID (integer). Only one of `API_COLLECTION_NAME` or `API_COLLECTION_ID` is required
6. `TEST_APIS` - Space-separated list of components to test. If absent, all components are selected
7. `OVERRIDE_APP_URL` - Change the application host for testing
8. `OUTPUT_LEVEL` - Output level:
   * `NONE` - No output file
   * `SUMMARY` - \[Default] Tests executed and list of vulnerable components
   * `DETAILED` - Summary plus test descriptions and impact
   * `DEBUG` - Detailed output with original and attempt request/response

Example CLI:

```bash
docker run -v ${PWD}:/out \
   -e AKTO_DASHBOARD_URL=https://your.dashboard.url \
   -e TEST_IDS=PROMPT_INJECTION \
   -e API_COLLECTION_ID=1689063104 \
   -e AKTO_API_KEY=your_api_key \
   -e OUTPUT_LEVEL=DETAILED \
   aktosecurity/akto-api-testing-cli:latest
```

## Results

1. Short summary (Component, Vulnerability, Severity) printed on command line
2. File `output.txt` contains test details based on output level
3. If you see version mismatch error, match release version of dashboard vs testing-cli

## Limitations

1. Results are not saved in Akto dashboard
2. Tests which use context will be skipped
