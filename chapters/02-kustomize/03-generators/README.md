# 03 — Generators

**Cert:** `[CKAD]` · **Timebox:** 25 min

## Objective

Use `configMapGenerator` / `secretGenerator` so names get content hashes (rolling updates when data changes). Avoid hand-written ConfigMap/Secret YAML when literals suffice.

## Challenge (blind)

1. Start from a small Deployment (or reuse base from lab 02).
2. In `kustomization.yaml`:
   - `configMapGenerator` with literals `LOG_LEVEL=debug`, `FEATURE_X=true`
   - `secretGenerator` with a dummy literal password (lab only)
3. Mount or inject the ConfigMap into the Pod (envFrom or volume).
4. Render twice after changing a literal — observe the generated name suffix change.

## Verify

```powershell
kubectl kustomize . | Select-String "kind: ConfigMap|kind: Secret|configMapRef|secretRef|name:"
# Change a literal, kustomize again — ConfigMap name hash should change
```

**Cleanup:** never commit real credentials; delete any applied Secrets after the drill.

<details>
<summary>Generator sketch</summary>

```yaml
configMapGenerator:
  - name: app-config
    literals:
      - LOG_LEVEL=debug
secretGenerator:
  - name: app-secret
    literals:
      - password=lab-only-not-real
```

</details>
