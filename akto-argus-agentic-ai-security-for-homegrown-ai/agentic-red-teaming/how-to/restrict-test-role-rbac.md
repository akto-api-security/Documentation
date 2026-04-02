# Restrict Access to a Scan Role Using RBAC

> 📖 If you’re new to Probe Roles, start with [Create a Scan Role](create-a-test-role.md).

You can now **restrict access to probe roles** based on user roles (RBAC). This gives you fine-grained control over who can view or use a particular probe role.

This is especially useful in collaborative environments where different teams (e.g., Security, QA, DevOps) need access to different sets of probes.

***

## 📘 Prerequisite

Make sure you’ve already created [Custom Roles](../../../account-management/custom-roles.md) for your team members.

***

## ✅ Steps to Restrict Probe Role Access by User Role

1. **Go to Scan Roles**
   * Navigate to **AI Red Teaming → Scan Roles**.
2. **Create or Edit a Scan Role**
   * You can either create a new Probe Role or edit an existing one.
3. **Set Scope Role**
   * In the Probe Role configuration form, locate the dropdown labeled **”Scope Role”**.
   * Select one or more user roles from the list.
   * Only users with the selected roles will be able to view or apply this Probe Role during probing.
4. **Save**
   * Click **Save** to update the Probe Role with the new RBAC restrictions.

***

## 🔒 What Happens After Setting a Scope Role?

* Users without the selected roles will **not see** the Probe Role in their list.
* They also won’t be able to select the Probe Role when triggering a probe.
* **Admins and Super Admins** retain visibility over all Probe Roles by default.

***

## 🧪 Example Use Case

* **QA Team**: Create a probe role named “Regression Suite” and assign it a scope role of **QA**.
* **Security Team**: Set up a probe role named “Critical Security Checks” and assign it to the **Security** scope role.

***

## 📎 Related Documentation

* [Create a Probe Role](create-a-test-role.md)
* [Custom Roles](../../../account-management/custom-roles.md)
