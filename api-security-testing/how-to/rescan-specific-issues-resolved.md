# Rescan Specific Issues Resolved

You can use Akto to **rescan individual issues** after they’ve been fixed or updated, instead of running a full security test. This allows you to validate specific fixes quickly.

Here’s what you can do:

* _Select specific issues to rescan_
* _Trigger a targeted rescan_
* _Verify if the issue is resolved_

***

### Rescan Specific Issues

1. Navigate to **Testing > Results** in the Akto dashboard.
2. Find the test in which the issue was detected.
3. Locate the issue(s) you want to retest.
4. **Check the box** next to the issue(s).
5. Click **Rerun tests** to rescan the selected issue(s).

<figure><img src="../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

Akto will automatically rerun the tests for the selected API endpoints and update the issue status.

***

### Review Results

After the scan completes:

* If the issue is fixed, it will move to the **No vulnerability found** tab.
* If the issue still exists, it remains under **Vulnerable**.
* You can repeat the rescan anytime as needed.
