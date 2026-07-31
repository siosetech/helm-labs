# 01 · CLI Mechanics

**Cert tags:** `[CKA]` `[CKAD]`  
**Timebox:** ~90 mins (5–10 mins per lab)  
**Prerequisite:** [cluster/README.md](../../cluster/README.md) — context `kind-helm-lab`

```powershell
kubectl config use-context kind-helm-lab
helm version
kubectl cluster-info
```

## Working Rule

1. Read the challenge.
2. Try it yourself **without** opening the solution.
3. Run the Verify block — if it passes, proceed to the next lab.
4. If you get stuck, look at the `<details>` solution; then repeat it blindly.

---

## Lab 1.1 — Helm environment `[CKA]`

View Helm's cache, config, and plugin paths.

**Challenge:** List environment variables / paths.

**Verify:**

```powershell
helm env
# HELM_REPOSITORY_CACHE, HELM_CONFIG_HOME, HELM_DATA_HOME should be visible
```

<details>
<summary>Solution</summary>

```powershell
helm env
```

</details>

---

## Lab 1.2 — Repo add / search `[CKA]` `[CKAD]`

Artifact Hub: https://artifacthub.io/

**Challenge:**

1. Add the Bitnami repo: `https://charts.bitnami.com/bitnami`
2. Update the cache.
3. Search for the `nginx` chart.

**Verify:**

```powershell
helm repo list
helm search repo bitnami/nginx
# Should return at least one line of chart/version
```

<details>
<summary>Solution</summary>

```powershell
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm search repo bitnami/nginx
```

> Bitnami has moved some charts to OCI. If `helm search repo` returns empty:
> `helm show chart oci://registry-1.docker.io/bitnamicharts/nginx`
> Use OCI install in Lab 1.3 (the alternative below).

</details>

---

## Lab 1.3 — Install / status / uninstall `[CKA]` `[CKAD]`

**Challenge:**

1. Install nginx with the release name `my-web-server`.
2. List the releases.
3. Check the status.
4. Uninstall it.

**Verify (after installation, before uninstalling):**

```powershell
helm ls
helm status my-web-server
kubectl get deploy,svc -l app.kubernetes.io/instance=my-web-server
```

<details>
<summary>Solution</summary>

```powershell
# Classic repo
helm install my-web-server bitnami/nginx

# Alternative (OCI)
# helm install my-web-server oci://registry-1.docker.io/bitnamicharts/nginx

helm ls
helm status my-web-server
helm uninstall my-web-server
```

</details>

---

## Lab 1.4 — Upgrade / history / rollback `[CKA]` `[CKAD]`

**Challenge:**

1. Install `my-web-server`.
2. Upgrade with `replicaCount=2`.
3. Check the history.
4. Rollback to Revision 1.

**Verify:**

```powershell
helm history my-web-server
kubectl get deploy -l app.kubernetes.io/instance=my-web-server -o jsonpath="{.items[0].spec.replicas}"; Write-Host
# After rollback, replica should typically be 1
```

<details>
<summary>Solution</summary>

```powershell
helm install my-web-server bitnami/nginx
helm upgrade my-web-server bitnami/nginx --set replicaCount=2
helm history my-web-server
helm rollback my-web-server 1
helm uninstall my-web-server
```

</details>

---

## Lab 1.5 — Values override (`-f` / `--set`) `[CKA]` `[CKAD]`

**Challenge:**

1. Create `values-lab.yaml`: `replicaCount: 3` and a meaningful `service.type` (e.g. `ClusterIP`).
2. Install using `-f`.
3. Upgrade the same release with `--set replicaCount=1` (observe the combination of file + set).

**Verify:**

```powershell
helm get values my-web-server
helm get values my-web-server --all
kubectl get deploy -l app.kubernetes.io/instance=my-web-server -o wide
```

<details>
<summary>Solution</summary>

```powershell
@"
replicaCount: 3
service:
  type: ClusterIP
"@ | Set-Content -Encoding utf8 values-lab.yaml

helm install my-web-server bitnami/nginx -f values-lab.yaml
helm upgrade my-web-server bitnami/nginx -f values-lab.yaml --set replicaCount=1
helm get values my-web-server
helm uninstall my-web-server
Remove-Item values-lab.yaml
```

</details>

---

## Lab 1.6 — dry-run / template / manifest `[CKA]` `[CKAD]`

In exams and prod: see what will be generated before pushing to the cluster.

**Challenge:**

1. Try to install with `--dry-run` (it shouldn't write to the cluster / or client-only).
2. Print YAML with `helm template`.
3. Get the manifest for an installed release using `helm get manifest`.

**Verify:**

```powershell
helm template demo bitnami/nginx --set replicaCount=2 | Select-String "replicas:"
# The dry-run output should show kind: Deployment; demo should not be in helm ls (client dry-run)
```

<details>
<summary>Solution</summary>

```powershell
helm install demo bitnami/nginx --dry-run --debug
helm template demo bitnami/nginx --set replicaCount=2

helm install my-web-server bitnami/nginx
helm get manifest my-web-server | Select-Object -First 40
helm uninstall my-web-server
```

</details>

---

## Lab 1.7 — Failure drill: bad upgrade → rollback `[CKA]`

**Challenge:**

1. Install a stable release (`replicaCount=2`).
2. Intentionally try to upgrade with a broken / meaningless value (e.g. invalid `image.tag` or excessive resources).
3. Examine the Pod/release status.
4. Roll back to the last known good revision.
5. Clean up.

**Verify:**

```powershell
helm history my-web-server
kubectl get pods -l app.kubernetes.io/instance=my-web-server
# After rollback, pods should be Running
```

<details>
<summary>Solution</summary>

```powershell
helm install my-web-server bitnami/nginx --set replicaCount=2
helm upgrade my-web-server bitnami/nginx --set image.tag=this-tag-does-not-exist-xyz
kubectl get pods -l app.kubernetes.io/instance=my-web-server
helm history my-web-server
helm rollback my-web-server 1
kubectl rollout status deploy -l app.kubernetes.io/instance=my-web-server --timeout=120s
helm uninstall my-web-server
```

</details>

---

## CKA / CKAD Helm checklist

- [ ] `helm repo add` / `update` / `search`
- [ ] `helm install` / `ls` / `status` / `uninstall`
- [ ] `helm upgrade` / `history` / `rollback`
- [ ] `-f` and `--set` (priority: set usually overrides the file)
- [ ] `helm template` / `--dry-run` / `helm get values|manifest`

## Next

→ [02-kustomize](../02-kustomize/README.md) (then Helm authoring)
