# Akto Traffic Collector Platform Specific (bare Linux)

This document is for **clients** who install the **dockerless** eBPF bundle (Go binary + module.cc(bcc) + shell wrappers), distributed as a versioned **`.tar.gz`**.

Tarball naming convention:

`akto-mirroring-module-<version>-<os>-<kernel>-<arch>.tar.gz`

---

## Platform download URLs

| Platform | Download URL |
|----------|-------------|
| Amazon Linux 2 — kernel 5.10, x86_64 | `https://akto.blob.core.windows.net/traffic-collector-binaries/akto-mirroring-module-1.0.0-amzn2-5.10-x86_64.tar.gz` |

Contact Akto for a download URL if your platform is not listed.

---

## Install

### 1. Download the archive

Use the platform-specific URL from the table above.

```bash
wget -O akto-mirroring-module-<version>-<os>-<kernel>-<arch>.tar.gz "<ARTIFACT_URL>"
```

(`curl -fL "<ARTIFACT_URL>" -o akto-mirroring-module-<version>-<os>-<kernel>-<arch>.tar.gz` works the same way.)

### 2. Unpack (default layout: `/ebpf`)

As **root** (paths in the archive are rooted at `ebpf/`):

```bash
sudo mkdir -p /ebpf && sudo tar -xzf akto-mirroring-module-<version>-<os>-<kernel>-<arch>.tar.gz -C /ebpf --strip-components=1
```

This creates **`/ebpf/`** including:

| Path | Role |
|------|------|
| `ebpf/ebpf-logging` | Main Go binary |
| `ebpf/<platform>-setup.sh` | Platform-specific prerequisite script |
| `ebpf/kernel/module.cc` | C kernel code |
| `ebpf/ebpf-bcc-run.sh` | Supervisor loop |
| `ebpf/run-ebpf-bcc-host.sh` | Host entrypoint (sudo wrapper; **detached by default**) |
| `ebpf/uninstall-ebpf-bcc-host.sh` | Stops processes; leaves `${EBPF_ROOT}` on disk |
| `ebpf/.env` | Default environment (edit before production) |

If you install under a **different** directory, set **`EBPF_ROOT`** consistently (see below) and keep **`ebpf-bcc-run.sh`** and **`.env`** together under that directory.

### 3. Run platform prerequisites

The tarball includes a platform-specific setup script that installs required kernel headers and BCC libraries.
This must be run before akto ebpf module is started everytime.
Run it once after unpacking:

| Platform | Script |
|----------|--------|
| Amazon Linux 2 (kernel 5.10, x86\_64) | `sudo bash /ebpf/amzn2-5.10-setup.sh` |

For reference, upstream BCC installation docs: https://github.com/iovisor/bcc/blob/master/INSTALL.md

### 4. Configure

Edit **`/ebpf/.env`** (or **`${EBPF_ROOT}/.env`**). At minimum set **`AKTO_KAFKA_BROKER_MAL`** to your broker (replace the `<kafka-ip>` placeholder in the shipped template).

Typical bare-metal defaults in that file:

- **`EBPF_ROOT=/ebpf`** — bundle root.
- **`HOST_MAPPING=/`** — host path prefix (use **`/host`** when running inside Docker with `-v /:/host`).
- **`ENABLE_LOGS=false`** / **`LOG_FILE=/ebpf/dump.log`** — shipped defaults; if you change **`EBPF_ROOT`**, set **`LOG_FILE`** under that directory (for example **`/opt/akto/ebpf/dump.log`**).

### 5. Run (detached by default)

`run-ebpf-bcc-host.sh` starts the supervisor under **`nohup`** and returns immediately. It writes **`${EBPF_ROOT}/ebpf-bcc-run.pid`**. **`nohup.out`** is not used. With **`ENABLE_LOGS=false`**, **`ebpf-bcc-run.sh`** attaches non-TTY stdout/stderr to **`LOG_FILE`** (see **`.env`** / **`MAX_LOG_SIZE`** for rotation).

```bash
sudo /ebpf/run-ebpf-bcc-host.sh
```

Follow logs:

- **`ebpf-bcc-run.sh`** shell output (memory lines, restarts) and collector when **`ENABLE_LOGS=false`** (bundle default): `tail -f /ebpf/dump.log` or override **`LOG_FILE`** in **`.env`**

Attach to the supervisor in the foreground (blocks this shell), for debugging:

```bash
sudo /ebpf/run-ebpf-bcc-host.sh -f
# or: sudo AKTO_FOREGROUND=true /ebpf/run-ebpf-bcc-host.sh
```

Or with a non-default install root:

```bash
sudo EBPF_ROOT=/opt/akto/ebpf /opt/akto/ebpf/run-ebpf-bcc-host.sh
```

Ensure **`EBPF_ROOT`** in the environment matches **`EBPF_ROOT`** in **`.env`** when you use a custom path.

### 6. Uninstall

Stops **`ebpf-bcc-run.sh`** / **`ebpf-logging`** for this install (using the pidfile when present, then matching processes). It does **not** remove **`EBPF_ROOT`**.

```bash
sudo /ebpf/uninstall-ebpf-bcc-host.sh -y
```

Custom root:

```bash
sudo EBPF_ROOT=/opt/akto/ebpf /opt/akto/ebpf/uninstall-ebpf-bcc-host.sh -y
```

Omit **`-y`** for an interactive confirmation (requires a TTY).

#### What’s Happening Behind the Scenes?

* **eBPF hooks into your Linux kernel** to capture real-time traffic—even if it’s encrypted (TLS).
* No code changes, no traffic proxying, no SSL termination.
* The collector forwards API traces to Akto for real-time inventory and security analysis.

## Get Support for your Akto setup

There are multiple ways to request support from Akto. We are 24X7 available on the following:

1. In-app `intercom` support. Message us with your query on intercom in Akto dashboard and someone will reply.
2. Join our [discord channel](https://www.akto.io/community) for community support.
3. Contact `help@akto.io` for email support.
4. Contact us [here](https://www.akto.io/contact-us).
