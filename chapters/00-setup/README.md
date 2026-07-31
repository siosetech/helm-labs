# 00 · Setup (Windows + Podman + Kind)

**Cert tags:** foundation for `[CKA]` `[CKAD]` (and later CGOA/CKS labs)  
**Timebox:** ~45–90 min once; then reuse  
**Goal:** After this chapter you can run Band 1 without hunting host tools.

Teaching note: walk these steps while explaining *why* each piece exists.
Deep cluster create/delete lives in [cluster/README.md](../../cluster/README.md) — this chapter is the **host + toolchain** story.

## Do you need this folder?

Yes, if you (or a classmate) start from a clean Windows machine.  
Skip only when all verifies below are already green.

## What you will set up

| Step | Why |
|---|---|
| WSL2 | Podman Machine on Windows runs here |
| Podman Desktop + machine | Containers / Kind nodes |
| `kubectl`, `helm`, `kind` | Cluster + Helm labs |
| `KIND_EXPERIMENTAL_PROVIDER=podman` | Kind talks to Podman, not Docker |
| Kind lab cluster | Shared context `kind-helm-lab` |
| (Optional) ebook container build | AsciiDoc → HTML/PDF; same Podman, no host JDK |

**Out of scope here:** Docker Desktop, Minikube, host Java/Maven, full CKA networking curriculum.

---

## Lab 0.1 — WSL2 `[foundation]`

**Challenge:** Confirm WSL2 is available (Podman Desktop installer often enables this).

**Verify:**

```powershell
wsl --status
wsl -l -v
# Default version should be 2; at least one distro or Podman’s WSL VM present
```

<details>
<summary>Hints</summary>

- Microsoft Store / “Windows Subsystem for Linux” feature, or: `wsl --install`
- Reboot may be required once
- Podman Machine uses its own WSL distro; you do not need Ubuntu for Kind, but WSL2 must work

</details>

---

## Lab 0.2 — Podman Desktop + machine `[foundation]`

**Challenge:**

1. Install Podman Desktop (if missing).
2. Create/start a **rootful** machine.
3. Leave it RUNNING before any Kind command.

**Verify:**

```powershell
podman version
podman machine list
# STATUS = Currently running (rootful preferred for Kind)
```

<details>
<summary>Hints</summary>

```powershell
podman machine start
# First-time create is usually done via Podman Desktop UI
```

WSL machines often **cannot** change CPUs/memory via `podman machine set`.  
For more RAM (multi-node Kind later), use `%UserProfile%\.wslconfig` — see Lab 0.6.

</details>

---

## Lab 0.3 — CLI tools: kubectl, helm, kind `[foundation]`

**Challenge:** Install client tools on Windows (winget, Chocolatey, Scoop, or vendor installers).

**Verify:**

```powershell
kubectl version --client
helm version
kind version
```

<details>
<summary>Example (winget)</summary>

```powershell
winget install -e --id Kubernetes.kubectl
winget install -e --id Helm.Helm
winget install -e --id Kubernetes.kind
```

Exact package IDs change; if winget fails, use upstream install docs.

</details>

---

## Lab 0.4 — Kind → Podman provider `[foundation]`

**Challenge:** Make Kind use Podman on every new shell (user env or PowerShell profile).

**Verify:**

```powershell
$env:KIND_EXPERIMENTAL_PROVIDER = "podman"
# Persistent check: reopen a terminal and print the variable
[Environment]::GetEnvironmentVariable("KIND_EXPERIMENTAL_PROVIDER", "User")
# expect: podman
```

<details>
<summary>Solution</summary>

```powershell
[Environment]::SetEnvironmentVariable("KIND_EXPERIMENTAL_PROVIDER", "podman", "User")
$env:KIND_EXPERIMENTAL_PROVIDER = "podman"
```

Without this, Kind may look for Docker and fail on a Podman-only host.

</details>

---

## Lab 0.5 — Create lab cluster `[foundation]`

**Challenge:** Follow [cluster/README.md](../../cluster/README.md) and bring up `kind-helm-lab`.

**Verify:**

```powershell
kubectl config use-context kind-helm-lab
kubectl get nodes
kubectl cluster-info
helm version
```

<details>
<summary>Minimal create</summary>

```powershell
$env:KIND_EXPERIMENTAL_PROVIDER = "podman"
kind create cluster --name helm-lab --config cluster/kind-config.yaml
kubectl config use-context kind-helm-lab
```

Default config is **single-node** (fits low WSL RAM). Workers are commented in `cluster/kind-config.yaml`.

</details>

---

## Lab 0.6 — (Optional) More WSL RAM for multi-node `[foundation]`

Only if you need extra Kind workers or Argo CD + heavy charts.

**Challenge:** Raise WSL memory via `.wslconfig`, restart WSL, confirm Podman still runs.

**Verify:**

```powershell
# After edit + wsl --shutdown + podman machine start:
podman machine list
kubectl get nodes   # if you enabled workers and recreated the cluster
```

<details>
<summary>Example `%UserProfile%\.wslconfig`</summary>

```ini
[wsl2]
memory=8GB
processors=8
```

Then:

```powershell
wsl --shutdown
podman machine start
```

`podman machine set --memory` is **not** supported for WSL machines — `.wslconfig` is the lever.

</details>

---

## Lab 0.7 — (Optional) Ebook build toolchain `[docs]`

Same Podman; no host JDK. Needed only if you maintain `work/docs`.

**Challenge:** From `work/docs`, run the container build once.

**Verify:**

```powershell
cd work/docs
.\build.ps1
# target/generated-docs/book.html and book.pdf exist
```

Details: [work/docs/README.md](../../work/docs/README.md)

---

## Setup checklist

- [ ] WSL2 OK  
- [ ] Podman machine RUNNING (rootful)  
- [ ] `kubectl` / `helm` / `kind` on PATH  
- [ ] `KIND_EXPERIMENTAL_PROVIDER=podman` (persistent)  
- [ ] `kubectl get nodes` on `kind-helm-lab`  
- [ ] (Optional) ebook build once  
- [ ] (Optional) `.wslconfig` if RAM is tight  

## Next

→ [01-cli](../01-cli/README.md)
