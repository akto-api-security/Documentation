# Mosyle Business MDM Deployment

### Overview

MCP Endpoint Shield can be deployed to **macOS** devices managed with **Mosyle Business** using the same **package + staging scripts** flow used for other Apple MDMs. Mosyle handles **enrollment and delivery**; Akto provides the **installer and runtime** that protect MCP traffic and sync with the Akto cloud.

**Operator runbook (step-by-step, paths, troubleshooting):** see the open-source repo file [`mosyle-scripts/README.md`](https://github.com/akto-api-security/akto-gateway/blob/main/mcp-endpoint-shield/mosyle-scripts/README.md) under **akto-gateway** / **mcp-endpoint-shield**.

#### Why use MDM?

* **Zero-touch deployment** after enrollment
* **Centralized** assignment of the pkg and scripts
* **Consistent** token and hook configuration per scope
* **Auditability** via Mosyle execution logs and Akto dashboard

#### Mosyle enrollment vs Akto package (two layers)

1. **Mosyle MDM enrollment** (push certificate, Apple identity portal, enrollment `mobileconfig`) makes a Mac **managed by Mosyle**. This is **IT infrastructure** and is unrelated to Akto’s product binaries.
2. **MCP Endpoint Shield** is deployed **after** enrollment: Mosyle installs **`mcp-endpoint-shield-Jamf-Installer.pkg`** and runs **`deploy_token.sh`** then **`install_from_staging.sh`** from the **akto-gateway** repository (see runbook above). The pkg name contains “Jamf” for historical reasons; it is the **correct** build for Mosyle.

***

### Architecture (akto-gateway build)

This matches **`install_from_staging.sh`** and **`deploy_token.sh`** in [`akto-gateway/.../jamf-scripts/`](https://github.com/akto-api-security/akto-gateway/tree/main/mcp-endpoint-shield/jamf-scripts):

* **MDM script context**: Scripts are executed as **root** (typical for MDM); they detect the **console (GUI) user** and install under that user’s home.
* **Package**: Installs payload into a **staging directory** on disk: **`/tmp/akto-mcp-endpoint-shield-staging`**.
* **Install target**: **`~/.akto-mcp-endpoint-shield/`** (binaries, logs, optional system-proxy bundle).
* **Token and flags**: **`deploy_token.sh`** writes **`~/.akto-mcp-endpoint-shield/config/config.env`** (and related config). Token may be passed as Jamf-style **argument 4** or via environment variable **`AKTO_API_TOKEN`** when `$4` is empty.
* **Services**: **LaunchAgents** under **`~/Library/LaunchAgents/`** (`io.akto.mcp-endpoint-shield*.plist`), running **as the user**.

***

### Prerequisites

* **Mosyle Business** access: ability to assign **macOS packages** and **custom scripts/commands** to scoped devices or groups.
* Macs **enrolled** in Mosyle (device shows as managed).
* **AKTO_API_TOKEN** from the Akto platform.
* **Signed and notarized** `mcp-endpoint-shield-Jamf-Installer.pkg` for production (build instructions in the [mosyle-scripts README](https://github.com/akto-api-security/akto-gateway/blob/main/mcp-endpoint-shield/mosyle-scripts/README.md)).

***

### Deployment scripts (reuse; do not duplicate)

Scripts live in **`akto-gateway/mcp-endpoint-shield/jamf-scripts/`**:

1. **`deploy_token.sh`** — deploys `AKTO_API_TOKEN` (and optional hook parameters `$5`–`$22` if used). Prefer **`AKTO_API_TOKEN` environment variable** for Mosyle when positional parameters are not available.
2. **`install_from_staging.sh`** — copies from **`/tmp/akto-mcp-endpoint-shield-staging`** into **`~/.akto-mcp-endpoint-shield/`** and configures LaunchAgents.
3. **`uninstall.sh`** — removes the product for the console user.

Upload these scripts into Mosyle’s script library and reference them from your deployment workflow.

***

### Phased deployment (Mosyle Business)

Exact menu labels depend on your Mosyle version; align to this sequence:

#### Phase 1: Package

* Upload **`mcp-endpoint-shield-Jamf-Installer.pkg`** as a **custom macOS package / application** (or equivalent).
* Assign to a **pilot** device group.
* Ensure the deployment **installs** the package (installer must run so **staging** exists).

#### Phase 2: Scripts and order

Create **two** custom commands (or one workflow with two ordered steps):

1. **`deploy_token.sh`** — set **`AKTO_API_TOKEN`** in the command environment (recommended) or pass the token as script argument 4. Run **after** the package install.
2. **`install_from_staging.sh`** — no token arguments. Run **after** `deploy_token.sh`.

**Trigger**: Prefer **after user login** or recurring check-in when a **GUI user** is present. Scripts **fail** at the login window because there is no console user.

#### Phase 3: Uninstall (optional)

* Deploy **`uninstall.sh`** via a user-initiated or IT-only workflow when removal is required.

***

### Testing and pilot checklist

On a **pilot Mac** in scope, logged in as a normal user:

1. [ ] Mosyle reports **package install success** for `mcp-endpoint-shield-Jamf-Installer.pkg`.
2. [ ] **`/tmp/akto-mcp-endpoint-shield-staging`** exists immediately after pkg install (may be removed after `install_from_staging.sh` completes successfully).
3. [ ] **`~/.akto-mcp-endpoint-shield/config/config.env`** exists after `deploy_token.sh`.
4. [ ] **`~/.akto-mcp-endpoint-shield/bin/mcp-endpoint-shield`** exists and is executable after `install_from_staging.sh`.
5. [ ] **`launchctl list | grep mcp-endpoint-shield`** shows expected agents for the user session.
6. [ ] Logs under **`~/.akto-mcp-endpoint-shield/logs/`** and **`/var/log/akto-mcp-endpoint-shield-*.log`** show no fatal errors.
7. [ ] **Akto dashboard** shows expected activity for the project tied to the token.
8. [ ] Repeat on **Apple Silicon** and **Intel** if both are in fleet.

**Quick verification commands** (run as the enrolled user on the Mac):

```bash
ls -la ~/.akto-mcp-endpoint-shield/bin/mcp-endpoint-shield
ls -la ~/.akto-mcp-endpoint-shield/config/config.env
launchctl list | grep mcp-endpoint-shield
```

***

### Rollout strategy

1. **Pilot** — small Mosyle group, 1–2 weeks, monitor logs and Akto.
2. **Expand** — engineering or security cohorts, then wider groups.
3. **Fleet** — full scope; keep a staged pkg version for rollback.

***

### Troubleshooting

| Issue | What to check |
|-------|----------------|
| Staging missing | Pkg not **installed** (only downloaded), or wrong pkg variant. |
| “No console user” | Command ran with no GUI login; reschedule for post-login. |
| Token errors | `deploy_token.sh` not run or **`AKTO_API_TOKEN` / `$4`** not set in Mosyle. |
| Services not loading | Token file missing or wrong ownership; see **`/var/log/akto-mcp-endpoint-shield-deploy-token.log`** and **`/var/log/akto-mcp-endpoint-shield-install.log`**. |

For Mosyle-specific execution errors, use Mosyle’s **device command history** and macOS **`/var/log/install.log`** for installer failures.

***

### Support

* **Mosyle**: your IT admin or [Mosyle support](https://mosyle.com/).
* **MCP Endpoint Shield build and scripts**: [akto-gateway](https://github.com/akto-api-security/akto-gateway) — **mcp-endpoint-shield** / **jamf-scripts** and **mosyle-scripts**.
* **Akto platform**: support@akto.io or in-app Intercom.

### Related documentation

* [MDM Deployment](mdm-deployment.md) — generic MDM overview
* [Jamf MDM Deployment](jamf-mdm-deployment.md) — alternate Apple MDM (legacy GitBook paths may differ; prefer **akto-gateway** runbooks for file locations)
* [MCP Endpoint Shield overview](./)
