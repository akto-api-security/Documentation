# Connect Akto on TLS service (bare Linux)

Akto can automatically detect and analyze your API traffic—even if it's encrypted using TLS. This is achieved using **Akto Traffic Collector**, which leverages **eBPF** to passively observe kernel-level network activity.

You can deploy this collector on **any Linux-based system** (VM, bare metal, or cloud instance) **without Docker** by installing the **dockerless** eBPF core bundle (Go binary + BPF object + shell wrappers), distributed as a versioned **`.tar.gz`**. Here's how:

#### Step 1: Set Up Akto Traffic Processor (Mini-Runtime)

First, set up and configure the **Akto Traffic Processor (Mini-Runtime)**.

* You’ll get a **runtime service URL** or **Kafka IP** once setup is complete.
* If you're using **on-prem Akto**, this will be your internal runtime URL.

📘 [Follow this setup guide](https://docs.akto.io/getting-started/traffic-processor/hybrid-saas) for instructions.

#### Step 2: Deploy Traffic Collector (Supports TLS via eBPF, tarball)

This path uses the **bare Linux** bundle instead of a container. It mirrors API traffic at the kernel level—including **TLS-encrypted** traffic—without decrypting traffic in userspace or changing your applications.

**⚠ Prerequisites:**

* **Linux** on the target host (amd64 or arm64 matching the tarball you download).
* **Kernel / BPF**: CO-RE expects host BTF (typically `/sys/kernel/btf/vmlinux`) and sufficient privileges to load BPF (often root or the same capability set as your Kubernetes DaemonSet).
* **Network**: reachability to the Kafka broker you configure in `.env` (use the **Kafka IP** or runtime address from Step 1).

Typical archive names:

`akto-mirroring-module-<version>-<amd64|arm64>.tar.gz`

---

## Install

### 1. Download the archive

Use the HTTPS download URL Akto provides. Choose the build whose **arch** matches this machine (`amd64` vs `arm64`).

```bash
wget -O akto-mirroring-module-<version>-<arch>.tar.gz "<ARTIFACT_URL>"
```

(`curl -fL "<ARTIFACT_URL>" -o akto-mirroring-module-<version>-<arch>.tar.gz` works the same way.)

### 2. Unpack (default layout: `/ebpf`)

As **root** (paths in the archive are rooted at `ebpf/`):

```bash
sudo tar -xzf akto-mirroring-module-<version>-<arch>.tar.gz -C /
```

This creates **`/ebpf/`** including:

| Path | Role |
|------|------|
| `ebpf/ebpf-logging` | Main Go binary |
| `ebpf/kernel/module.bpf.o` | Compiled BPF object |
| `ebpf/ebpf-run.sh` | Supervisor loop |
| `ebpf/run-ebpf-core-host.sh` | Host entrypoint (sudo wrapper; **detached by default**) |
| `ebpf/uninstall-ebpf-core-host.sh` | Stops processes; leaves `${EBPF_ROOT}` on disk |
| `ebpf/.env` | Default environment (edit before production) |

If you install under a **different** directory, set **`EBPF_ROOT`** consistently (see below) and keep **`ebpf-run.sh`** and **`.env`** together under that directory.

### 3. Configure

Edit **`/ebpf/.env`** (or **`${EBPF_ROOT}/.env`**). At minimum set **`AKTO_KAFKA_BROKER_MAL`** to your broker from Step 1 (replace the `<kafka-ip>` placeholder in the shipped template).

Typical bare-metal defaults in that file:

* **`EBPF_ROOT=/ebpf`** — bundle root.
* **`HOST_MAPPING=/`** — host path prefix (use **`/host`** when running inside Docker with `-v /:/host`).
* **`ENABLE_LOGS=false`** / **`LOG_FILE=/ebpf/dump.log`** — shipped defaults; if you change **`EBPF_ROOT`**, set **`LOG_FILE`** under that directory (for example **`/opt/akto/ebpf/dump.log`**).

### 4. Run (detached by default)

`run-ebpf-core-host.sh` starts the supervisor under **`nohup`** and returns immediately. It writes **`${EBPF_ROOT}/ebpf-core-run.pid`**. **`nohup.out`** is not used. With **`ENABLE_LOGS=false`**, **`ebpf-run.sh`** attaches non-TTY stdout/stderr to **`LOG_FILE`** (see **`.env`** / **`MAX_LOG_SIZE`** for rotation).

```bash
sudo /ebpf/run-ebpf-core-host.sh
```

Follow logs:

* **`ebpf-run.sh`** shell output (memory lines, restarts) and collector when **`ENABLE_LOGS=false`** (bundle default): `tail -f /ebpf/dump.log` or override **`LOG_FILE`** in **`.env`**

Attach to the supervisor in the foreground (blocks this shell), for debugging:

```bash
sudo /ebpf/run-ebpf-core-host.sh -f
# or: sudo AKTO_FOREGROUND=true /ebpf/run-ebpf-core-host.sh
```

Or with a non-default install root:

```bash
sudo EBPF_ROOT=/opt/akto/ebpf /opt/akto/ebpf/run-ebpf-core-host.sh
```

Ensure **`EBPF_ROOT`** in the environment matches **`EBPF_ROOT`** in **`.env`** when you use a custom path.

### 5. Uninstall

Stops **`ebpf-run.sh`** / **`ebpf-logging`** for this install (using the pidfile when present, then matching processes). It does **not** remove **`EBPF_ROOT`**.

```bash
sudo /ebpf/uninstall-ebpf-core-host.sh -y
```

Custom root:

```bash
sudo EBPF_ROOT=/opt/akto/ebpf /opt/akto/ebpf/uninstall-ebpf-core-host.sh -y
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
