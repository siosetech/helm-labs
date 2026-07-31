# Cluster — Kind on Podman

Lab context: **`kind-helm-lab`**

This folder sets up a single reproducible lab cluster. It assumes Windows + Podman Desktop (rootful WSL machine).

## Prerequisites

Ensure the following are installed on the host:

| Tool | Check |
|---|---|
| Podman Machine (RUNNING) | `podman machine list` |
| `kind` | `kind version` |
| `kubectl` | `kubectl version --client` |
| `helm` | `helm version` |

For Windows + Podman, explicitly provide the provider to Kind:

```powershell
$env:KIND_EXPERIMENTAL_PROVIDER = "podman"
podman machine list
# STATUS = Should be 'Currently running'
```

If the machine is stopped: `podman machine start`.

To make it persistent, you can add `KIND_EXPERIMENTAL_PROVIDER=podman` to your PowerShell profile or user environment variables.

## Create

From the repository root:

```powershell
$env:KIND_EXPERIMENTAL_PROVIDER = "podman"
kind create cluster --name helm-lab --config cluster/kind-config.yaml
kubectl config use-context kind-helm-lab
```

## Smoke

```powershell
kubectl get nodes
kubectl cluster-info
helm version
```

Expected: 3 nodes `Ready`, API server accessible, Helm client version printed.

## Useful commands

```powershell
# Context
kubectl config get-contexts
kubectl config use-context kind-helm-lab

# Delete / recreate cluster
kind delete cluster --name helm-lab
kind create cluster --name helm-lab --config cluster/kind-config.yaml
```

## Resource notes

- Config: single control-plane ([kind-config.yaml](kind-config.yaml)). Sufficient for the Helm lab.
- `podman machine set --memory/--cpus` does not work on Podman **WSL** machine. For more RAM, an example `%UserProfile%\.wslconfig`:

  ```ini
  [wsl2]
  memory=8GB
  processors=8
  ```

  Then run `wsl --shutdown` and `podman machine start`. After increasing RAM, you can uncomment the worker lines in `kind-config.yaml` (for CKA multi-node).
- In Band 04, Argo CD + platform chart consumes RAM; a single node + 8 GB WSL will be comfortable.
- When the lab is finished, `kind delete cluster --name helm-lab` will free up disk/CPU resources.

## Next

If the cluster is green → [chapters/01-cli/README.md](../chapters/01-cli/README.md)
