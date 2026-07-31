# Argo CD + Helm source `[CGOA]` `[CAPA]`

**Prerequisite:** `platform/` chart passes `helm lint` / `helm template`; Kind cluster is up and running.

This stub is the CGOA/CAPA bridge: Helm chart = GitOps source type.
(After Band 02 you can also practice a second Application with `source.path` + Kustomize —
one source type per Application, not both.)

## Objective

1. Install Argo CD to the lab cluster (using the official manifest or community chart).
2. Deploy the `platform` chart using the `Application` CR (path / Helm valueFiles).
3. Observe sync / diff / rollback behavior when values change.

## Challenge (blind)

1. Argo CD namespace: `argocd`.
2. Fill out the [application-platform.yaml](application-platform.yaml) skeleton according to your own repo URL / path.
3. Apply: `kubectl apply -f application-platform.yaml`.
4. Sync via UI or CLI; verify with `kubectl -n platform get all`.

> If the repo is not on remote yet: Instead of a local path for Argo CD, push to GitHub/GitLab first
> or try CLI with `argocd app create`. For the lab, use a private repo + SSH/HTTPS credential.

## Verify

```powershell
kubectl get applications -n argocd
kubectl get deploy,svc -n platform
# Application Healthy/Synced; platform workload Running
```

<details>
<summary>Argo CD install (reference)</summary>

```powershell
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
# Initial password:
# kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | %{ [Text.Encoding]::UTF8.GetString([Convert]::FromBase64String($_)) }
```

In Kind, instead of Ingress, `kubectl port-forward svc/argocd-server -n argocd 8080:443` is sufficient.

</details>

## Failure drill

- Wrong `valueFiles` path → Application Degraded; fix and sync.
- Revert via Argo history / rollback instead of `helm rollback` (GitOps mental model).
