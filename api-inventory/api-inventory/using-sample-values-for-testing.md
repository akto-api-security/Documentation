# Using sample values for testing

Akto allows you to check sample values of request and response to test for issues. Here is an example of how to use sample values:

1. Go to the endpoint you want to review for security issue.

![](<../../.gitbook/assets/Frame 26.png>)

&#x20; 2\. Click on values tab.

![](<../../.gitbook/assets/Frame 58.png>)

&#x20;3\. Use curl command to copy values.

![](<../../.gitbook/assets/Frame 47.png>)

&#x20;4\.  Go to terminal and run curl command you copied in previous step. You can also run curl command in postman or burp.

![](<../../.gitbook/assets/Screen Shot 2022-03-09 at 12.52.02 PM.png>)

5\. If the command runs with param values such as email id, phone number, auth token, and more while you didn't expect it to run with these params, you should fix these APIs by working with your engineering team.
