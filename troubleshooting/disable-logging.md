# How to disable logging

By default, all Akto modules have logging enabled for visibility and troubleshooting purposes, ensuring that critical events and activities are recorded for better debugging and monitoring.

### Disabling Logs:
* Set the environment variable `ENABLE_LOGS` to `false` to disable logging to `stdout/stderr`.
* Logs will then be redirected to a file: `/tmp/dump.log`.

### Log Storage Details:
* Logs are stored on a rolling basis with a default file size limit of 10MB.
* This limit can be customized using the `MAX_LOG_SIZE` environment variable (value in bytes).

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
