# Roles

If you have role-based access control in your APIs and application, you would want to test for privilege escalation vulnerabilities. 
This typically involves checking access of all the higher-privilege APIs by a lower-privilege user. 
If any such API exists, then it's privilege should be fixed by the development team.

Akto enables you to do automate privilege escalation security tests. 
You can also use the information while creating Test YAML templates if you want to develop custom tests. 

## Testing for Privilege Escalation using Akto

1. Set up all your application roles in Akto along with the auth token for each role (hardcoded or automated)
2. For each role, find all the APIs that are accessible by that role
3. Setup automated test to check if any API exclusive to a higher-privilege role can be accessed by a lower-privilege role

The instructions here cover the above 3 steps in detail.

### Create application roles

1. In the left navigation menu, go to `Testing` and then click on `Roles` tab.
   <img width="1440" alt="Go to Roles tab" src="https://github.com/akto-api-security/Documentation/assets/91221068/5ff6cae1-f4a2-4179-843c-c77cc11da9c8">

2. Click on the plus-icon to add a new role.
   <img width="1440" alt="Click on add-icon" src="https://github.com/akto-api-security/Documentation/assets/91221068/6f8baaa1-f9fc-44b7-b303-021da6e66e6e">

3. Give a suitable name to your role eg. ADMIN. Select the APIs that belong to the application. If you want to select from an existing API Collection, use `belongs to` operator.
   <img width="1440" alt="Name the role" src="https://github.com/akto-api-security/Documentation/assets/91221068/7dcf85e2-760a-437a-a642-7283662710de">

4. Select API Collection from the dropdown menu.
<img width="1440" alt="Select API Collection" src="https://github.com/akto-api-security/Documentation/assets/91221068/3feceb3d-f4c4-42db-83f3-f7177b45aec7">

5. Select endpoints you'd want to evaluate. You can simply select all. And click on `Save` button.
<img width="1440" alt="Select endpoints" src="https://github.com/akto-api-security/Documentation/assets/91221068/e16c7d60-55de-404e-8592-c47f0e326e7b">

### Add authentication token for the role

During API testing, Akto will add these headers to the sample API calls to check if the role has access to the API. You can provide a hardcoded auth header (steps 1,2,3 below) or you can also automate fetching auth token automatically for the role. If you configure automated auth token generation, Akto will run the Login-request sequence before the test starts and fetch the auth token. 

1. Click on the `Add auth` button to add auth-token for your role. Then click on the `plus` icon to add auth headers for the role
 <img width="1440" alt="Add-auth button" src="https://github.com/akto-api-security/Documentation/assets/91221068/48c733d1-94a7-4f76-97d6-79fb724724e7">

2. Add your auth header key and its value as shown.
   <img width="1440" alt="Enter auth headers" src="https://github.com/akto-api-security/Documentation/assets/91221068/ebe48802-dd9e-477d-a4ed-d09146c680f5">

3. You can add multiple headers too. Click on the `plus` icon to add more headers for this role. Click on `Save` when you are done.
 <img width="1440" alt="Add more headers" src="https://github.com/akto-api-security/Documentation/assets/91221068/b175c895-f03d-4081-9cb6-89e8423ae025">


