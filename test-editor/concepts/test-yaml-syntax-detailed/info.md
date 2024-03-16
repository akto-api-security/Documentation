# Info

This section provides information about the test's purpose, the type of vulnerability it targets, the test category and the overall impact. This section contains multiple descriptive keys that explain the test.

### Name

The name key shows the name or `title` of the test. It should make clear what the test does. The test name helps users quickly identify and understand the purpose of the assessment.

Example:

```yaml
# THIS IS THE INFO SECTION
info:
	# THIS IS NAME KEY
  name: "CSRF Login attack"
```

### Description

The description key provides a brief explanation of the `test's objective`. This description may contain details about the target system, possible vulnerabilities, and anticipated assessment results.

Example:

```yaml
info:
	# THIS IS DESCRIPTION KEY
  description: "Hackers trick users to log into their account by forging requests, exploiting server authentication."
 
```

### Details

In addition to the description section, the `details` key provides a more in-depth view. It explains how the API was detected to be vulnerable and also provides information on the test category. The details section may include information about the `target system`, `potential vulnerabilities`, and the expected outcome of the assessment.

Example:

```yaml
info:
	# THIS IS DETAILS KEY
  details: "A login CSRF attack involves hackers tricking users into logging into an attacker-controlled account. By forging a request using their credentials and submitting it to the victim's browser, the server mistakenly authenticates the request, granting access to the attacker's account."
```

### Impact

The `impact` key describes the potential `risks` or `consequences` associated with the identified vulnerabilities. It helps users understand the severity and potential implications of the vulnerabilities if exploited by attackers.

Example:

```yaml
info:
	# THIS IS IMPACT KEY
	impact: "Depending on the user account and information exposed, the impacts of an attack range from mild to severe. Some consequences of a successful login CSRF attack include: Deployment of malicious code, Unauthorized financial transactions and Data breach and sensitive information exposure"
```

### Category

This key represents the exact `category` to which the test belongs, for example, "Broken User Authentication" or "Broken Object Level Authorization".

Example:

```yaml
info:
	# THIS IS CATEGORY KEY
category:
    name: NO_AUTH
    shortName: Broken Authentication
    displayName: Broken User Authentication (BUA)
```

### SubCategory

The value of this key is exactly the same as the value of the `Id key`.

Example:

```yaml
info:
	# THIS IS SUBCATEGORY KEY
	subCategory: CSRF_LOGIN_ATTACK
```

### Severity

This key is used to assign the severity of the test and can take on values `HIGH`, `MEDIUM`, or `LOW`.

Example:

```yaml
info:
	# THIS IS SEVERITY KEY
	severity: LOW
```

### Tags

The `tags` key is used to list `relevant categories` or keywords that help users identify the test and understand its purpose.

Example:

```yaml
info:
	# THIS IS TAGS KEY
	tags: 
		- Business logic
    - OWASP top 10
    - HackerOne top 10
```

### References

The references section provides a `list of resources` that can be used to obtain additional information about the test. These resources may include `websites`, `articles`, or other materials.

Example:

```yaml
info:
	# THIS IS REFERENCES KEY
	references: 
		- "https://crashtest-security.com/csrf-login-attack/"
    - "https://www.invicti.com/web-vulnerability-scanner/vulnerabilities/cross-site-request-forgery-in-login-form-invicti/"
```
