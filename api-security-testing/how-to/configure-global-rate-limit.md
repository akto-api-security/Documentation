# Configure global rate limit

## Configure Global Rate Limit

The Global Rate Limit feature in Akto allows you to control the number of API tests executed per minute. This helps in managing the load on your API endpoints during testing and prevents overwhelming your systems.

{% @arcade/embed flowId="1QaTKUMxKMQbDgzpmfih" url="https://app.arcade.software/share/1QaTKUMxKMQbDgzpmfih" %}

### Understanding the Rate Limit

* The rate limit defines the maximum number of API tests Akto will perform per minute.
* "No limit" means Akto will test APIs as fast as possible, without any rate restriction.
* Choose a limit that balances between thorough testing and the capacity of your API infrastructure.

### Use Cases

1. **Load Management**: Prevent overloading your API servers during testing phases.
2. **Realistic Testing**: Simulate real-world API usage patterns by limiting the test rate.
3. **Resource Optimization**: Manage resource allocation between testing and production environments.

### Best Practices

1. Start with a lower limit and gradually increase it to find the optimal testing speed for your environment.
2. Consider your API's normal traffic patterns when setting the limit.
3. Adjust the limit based on the time of day or your application's peak/off-peak hours.
4. For critical or high-load systems, maintain a conservative rate limit to ensure stability.

### Troubleshooting

* If you encounter timeouts or errors during testing, consider lowering the rate limit.
* For faster test completion, increase the rate limit, but monitor your API's performance closely.

Remember, the ideal rate limit depends on your specific API infrastructure and testing requirements. Regularly review and adjust this setting as your API ecosystem evolves.
