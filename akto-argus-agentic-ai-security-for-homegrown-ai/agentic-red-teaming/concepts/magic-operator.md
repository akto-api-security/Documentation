# Magic Operator

The Magic Operator (`$magic`) allows you to dynamically inject intelligent behavior into test templates using natural language prompts. By prefixing a command with `$magic`, the engine interprets the instruction and performs intelligent actions such as modifying, deleting, or generating headers, payloads, or validations without hardcoding logic.

For example, `$magic delete sec headers` instructs the engine to remove security-related headers from the request, making it easier to simulate attack conditions or bypass scenarios.

This operator enhances flexibility and automation in crafting agentic security test cases by leveraging AI-driven contextual understanding.
