---
description: Explore about how to do role-based testing.
---

# Conduct Role-Based Testing

Akto enables you to conduct role-based testing for your API collection which aligns with the principle of **Role-Based Access Control (RBAC).** It verifies that each role can only access its security posture

This security testing approach is essential for maintaining the integrity of the system by reducing the risk of unauthorized access and potential data breaches, especially in environments where user roles are diverse and complex.&#x20;

In the demonstration below, let’s conduct role-based testing for the **“juice\_shop\_demo”** collection by selecting a **test role** as **“Member”** and checking if access to the data and functionality present in this collection is relevant to this role.&#x20;

When you [run a test](run-test.md) you can select your test role as a **Member** for your test, ensuring that the test accurately reflects the permissions and access levels associated with this role.

Select the API Collection and click on the **Run Test.** Select the **Test Categories** and **Tests** you want to test along with selecting a **Test Role** as a **"Member"** for your test, then click on **Run Test** to conduct Role-based Testing.

{% embed url="https://demo.arcade.software/FAjElwQtMP4jcFITIg22?embed=" %}

In the demonstration above, we have performed role-based testing for the **“juice\_shop\_demo”** collection by selecting the **test role** as **Member.**\
\
Now let's check the results of the role-based testing. Akto ran BOLA tests on th **`juice_shop_demo`** collection by selecting the test role as a **Member**.

{% @arcade/embed flowId="Nx6IQOZ4WXM9P06nAuE6" url="https://app.arcade.software/share/Nx6IQOZ4WXM9P06nAuE6" %}

In the above demonstration, since there is no vulnerability found in the **`juice_shop_demo`** collection, there is no information displayed in the **`vulnerable`** section which means that the access of data and functionality present in the **`juice_shop_demo`** collection is relevant to this role.
