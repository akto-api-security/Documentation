# Configure Global Rate Limit

The Global Rate Limit feature allows you to control the number of security tests executed per minute against agent components. This helps manage load during testing and prevents overwhelming your agentic systems.

## Setting the Rate Limit

1. Navigate to **Agentic Red Teaming > User Config**
2. Locate the **Global Rate Limit** section
3. Set the maximum number of tests per minute
4. Click **Save** to apply changes

## Understanding Rate Limits

The rate limit defines the maximum number of security tests Akto will perform per minute against your agent components.

"No limit" means tests will execute as fast as possible without rate restrictions.

Choose a limit that balances thorough testing with your infrastructure capacity.

## Use Cases

**Load Management**: Prevent overloading agent components during security testing.

**Realistic Testing**: Simulate real-world usage patterns by limiting test rate.

**Resource Optimization**: Manage resource allocation between testing and production environments.

## Troubleshooting

If you encounter timeouts or errors during testing, lower the rate limit.

For faster test completion, increase the rate limit while monitoring component performance.
