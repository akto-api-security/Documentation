# Custom roles

Custom roles let you create a role that fits your team instead of using one of the [built-in roles](understanding-role-permissions.md). Start from a built-in role, change only the permissions it needs, and optionally limit which collections its users can see.

## Create a custom role

{% stepper %}
{% step %}
Go to **Settings** > **Roles** and click **Create role**.

<div data-with-frame="true"><figure><img src="../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png" alt="" width="563"><figcaption></figcaption></figure></div>
{% endstep %}

{% step %}
Enter a **Role name**, for example `PAYMENTS-TEAM-SECURITY-ENGINEER`. Use letters, numbers, `-` and `_` only, up to 50 characters. The name cannot match a built-in or existing role.
{% endstep %}

{% step %}
Under **Start from**, pick the built-in role to base it on: **Admin**, **Security Engineer**, **Developer**, **Guest**, **Threat Engineer** or **Threat Viewer**. The new role starts with that role's permissions.
{% endstep %}

{% endstepper %}

## Change the permissions

{% stepper %}
{% step %}
Open the role and go to **Permissions**.
{% endstep %}

{% step %}
For each permission you want to change, open its dropdown and pick one of these options:

* **Default**: keeps what the base role gives. The label shows that level, for example **Default (Read and write)**.
* **No access**: users cannot see or use this permission.
* **Read**: users can view but not change.
* **Read and write**: users can view and change.
{% endstep %}

{% step %}
Click **Save**. To undo all your changes, click **Reset to base role** instead.
{% endstep %}
{% endstepper %}

Permissions are grouped by area:

| Group                   | Permissions you can set                                                 |
| ----------------------- | ----------------------------------------------------------------------- |
| **People and Settings** | Invite Users and Change Their Roles, Integrations, API Tokens           |
| **Inventory and Data**  | Collections and Inventory, Sensitive Data, Request and Response Samples |
| **Testing**             | Run Tests, Test Results, Issues, Pre and Post Request Scripts           |
| **Guardrails**          | Agentic Guardrail Activity, Guardrail Settings and Data Retention       |

## Limit the collections a role can see

A role sees all collections by default. You can limit it to chosen collections, to collections that match a rule, or both.

{% stepper %}
{% step %}
Open the role and go to **Collections**.
{% endstep %}

{% step %}
To pick collections by hand, click **Choose collections** and select the ones this role should see.
{% endstep %}

{% step %}
To include collections automatically, add a rule under **Also include collections matching**:

* **Host name**: enter a regular expression, for example `^team-a-.*\.example\.com$`. Use `^` and `$` to match the whole host name.
* **Tag**: enter a `key=value` pair.

Then click **Add rule**. Collections created later are included when they match.
{% endstep %}

{% step %}
Click **Save**.
{% endstep %}
{% endstepper %}

{% hint style="info" %}
To give a role access to all collections again, remove every chosen collection and every rule.
{% endhint %}

## Let team admins invite people

If a role is limited to specific collections, you can let its users invite people and assign them roles, but only the roles you choose.

{% hint style="warning" %}
**Invite Users and Change Their Roles** must be set to **Read and write** for this role. Without write access, **Invite Permissions** does not work and users with this role cannot invite people or assign roles.
{% endhint %}

{% stepper %}
{% step %}
Set **Invite Users and Change Their Roles** to **Read and write** under **Permissions**.
{% endstep %}

{% step %}
Go to **Invite Permissions** and tick the roles this role can give. Users with this role can add users and assign them only the roles selected here.

Only roles limited to collections are listed, and roles based on **Admin** are never listed.
{% endstep %}

{% step %}
Click **Save**.
{% endstep %}
{% endstepper %}

{% hint style="info" %}
If no other role is limited to collections yet, **Invite Permissions** shows **No other roles are limited to collections yet (roles based on Admin don't count), so there is nothing to select.** Create and [limit another role to collections](#limit-the-collections-a-role-can-see) first, then come back.
{% endhint %}

For example, a `SECURITY_ENGINEER_TEAM_1` role limited to Team 1's collections can invite users as `GUEST_TEAM_1` or `DEVELOPER_TEAM_1` if you tick those roles. Users who see all collections ignore this list and follow the usual role levels.

## Assign a role to users

{% stepper %}
{% step %}
Go to **Settings** > **Users**.
{% endstep %}

{% step %}
Invite a user, or change an existing user's role, and select your custom role.
{% endstep %}
{% endstepper %}

To make a role the default, open it and select **Default role for new invites**. It is then pre-selected when you invite someone, and given to people who join from your company's domain. Only one role can be the default at a time.

{% hint style="warning" %}
Be careful with **Default role for new invites**. Anyone invited, or joining from your company's domain, automatically gets this role's permissions.
{% endhint %}

To see who has a role, open it and check **Users With This Role**. It lists users and pending invites.

## Delete a role

Open the role and click **Delete**. You can delete a role only when no user or pending invite has it, so assign them another role first.

{% hint style="info" %}
Only admins with access to all collections can create, edit or delete roles. Everyone else sees roles as read-only.
{% endhint %}

## Copy a role

Copy a role you have already configured to create a new role from it. The copy keeps the role's permissions, collections and rules, so you only change what is different.

{% stepper %}
{% step %}
Open the role and click **Copy** at the top of the page.
{% endstep %}

{% step %}
Enter a **Role name** for the copy. It is pre-filled with the original name followed by `_COPY`. Use letters, numbers, `-` and `_` only. Akto saves the name in capitals.
{% endstep %}

{% step %}
Check **Start from**, which shows the built-in role the copy is based on.
{% endstep %}

{% step %}
Click **Create copy**.
{% endstep %}
{% endstepper %}


## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
