# Restrict Access to a Test Role Using RBAC

> 📖 If you're new to Test Roles, start with [Create a Test Role](create-a-test-role.md).

You can now **restrict access to test roles** based on user roles (RBAC). This gives you fine-grained control over who can view or use a particular test role.

This is especially useful in collaborative environments where different teams (e.g., Security, QA, DevOps) need access to different sets of tests.

***

## 📘 Prerequisite

Make sure you’ve already created [Custom Roles](../../account-management/custom-roles.md) for your team members.

***

## ✅ Steps to Restrict Test Role Access by User Role

1. **Go to Test Roles**
   * Navigate to **API Security Testing → Test Roles**.
2. **Create or Edit a Test Role**
   * You can either create a new Test Role or edit an existing one.
3. **Set Scope Role**
   * In the Test Role configuration form, locate the dropdown labeled **"Scope Role"**.
   * Select one or more user roles from the list.
   * Only users with the selected roles will be able to view or apply this Test Role during testing.
4. **Save**
   * Click **Save** to update the Test Role with the new RBAC restrictions.

***

## 🔒 What Happens After Setting a Scope Role?

* Users without the selected roles will **not see** the Test Role in their list.
* They also won't be able to select the Test Role when triggering a test.
* **Admins and Super Admins** retain visibility over all Test Roles by default.

***

## 🧪 Example Use Case

* **QA Team**: Create a test role named “Regression Suite” and assign it a scope role of **QA**.
* **Security Team**: Set up a test role named “Critical Security Checks” and assign it to the **Security** scope role.

***

## 📎 Related Documentation

* [Create a Test Role](create-a-test-role.md)
* [Custom Roles](../../account-management/custom-roles.md)
