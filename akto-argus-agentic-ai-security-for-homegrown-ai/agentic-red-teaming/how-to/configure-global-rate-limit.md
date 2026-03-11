# Configure Global Rate Limit

The Global Rate Limit feature allows you to control the number of security probes executed per minute against agent components. This helps manage load during AI Red Teaming and prevents overwhelming your agentic systems.

## Setting the Rate Limit

1. Navigate to **Agentic Red Teaming > User Config**
2. Locate the **Global Rate Limit** section
3. Set the maximum number of probes per minute
4. Click **Save** to apply changes

## Understanding Rate Limits

The rate limit defines the maximum number of security probes Akto will perform per minute against your agent components.

"No limit" means probes will execute as fast as possible without rate restrictions.

Choose a limit that balances thorough AI Red Teaming with your infrastructure capacity.

## Use Cases

**Load Management**: Prevent overloading agent components during AI Red Teaming.

**Realistic Probing**: Simulate real-world usage patterns by limiting probe rate.

**Resource Optimization**: Manage resource allocation between probing and production environments.

## Troubleshooting

If you encounter timeouts or errors during AI Red Teaming, lower the rate limit.

For faster probe completion, increase the rate limit while monitoring component performance.
