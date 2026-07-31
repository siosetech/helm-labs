# 04 — Helm ↔ Kustomize bridge

**Cert:** `[CKA]` `[CKAD]` `[CGOA]` · **Timebox:** 40 min  
**Prerequisite:** Band 01 (Helm CLI) + Kustomize labs 01–02

## Objective

Use Helm as the **package**, Kustomize as the **env overlay**:

`helm template` → YAML tree → Kustomize patches/labels → apply

This is the systematic “learn together” lab — still one job per tool.

## Challenge (blind)

Suggested layout:

```
04-helm-bridge/
  chart-out/                 # generated — gitignore locally if you want
  overlay/
    kustomization.yaml
    patch-replicas.yaml      # force replicas / add label
```

Steps:

1. Render a public chart (same one you used in Band 01 is fine):

   ```powershell
   New-Item -ItemType Directory -Force chart-out | Out-Null
   helm template bridge-web bitnami/nginx --set replicaCount=1 `
     --output-dir chart-out
   ```

   (OCI alternative if the repo chart fails: `oci://registry-1.docker.io/bitnamicharts/nginx`)

2. Point `overlay/kustomization.yaml` `resources:` at the rendered manifests  
   (path into `chart-out/.../templates` or a flattened folder you copy).

3. Patch: set replicas to `2` and add label `managed-by-bridge: "true"`.

4. Do **not** `helm install` for the final apply — use `kubectl apply -k overlay`.

5. Bonus: explain in one line why Argo would pick **Helm source** *or* **Kustomize source**, not both in one Application.

## Verify

```powershell
kubectl kustomize overlay | Select-String "replicas:|managed-by-bridge"
kubectl apply -k overlay --dry-run=client
kubectl apply -k overlay
kubectl get deploy -l managed-by-bridge=true
kubectl delete -k overlay
```

## Failure drill

Break the patch path (wrong `resources:` entry) → `kubectl kustomize` must fail clearly. Fix and re-run.

## Next

→ [03-authoring](../../03-authoring/README.md) — write Helm charts from scratch  
(Kustomize stays in your toolkit for env overlays and CGOA source types.)
