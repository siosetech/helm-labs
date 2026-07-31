# 02 · Kustomize

**Cert tags:** `[CKA]` `[CKAD]` `[CGOA]`  
**Timebox:** ~3–4 sessions (20–40 min each)  
**Prerequisite:** [01-cli](../01-cli/README.md) — you can install a chart and run `helm template`

## How this band fits

Helm = package + release lifecycle.  
Kustomize = declarative overlays (base + patches) with **no** template language.

Learn them **in sequence**, then combine:

1. Pure Kustomize (bases, overlays, patches)
2. Helm → Kustomize bridge (`helm template` then customize)
3. Later (Band 04 / CGOA): Argo CD source type is *either* Helm *or* Kustomize per Application

## Blind rule

> Read the lab → **close it** → write YAML yourself → verify with `kubectl kustomize` / `kubectl apply -k --dry-run=client`.

Work under each subfolder (create the manifests there). Do not commit cluster secrets.

## Session order

| # | Path | Topic |
|---|---|---|
| 1 | [01-basics](01-basics/README.md) | `kustomization.yaml`, resources, `kubectl kustomize` / `-k` |
| 2 | [02-overlays](02-overlays/README.md) | base + overlays, labels, namePrefix, patches |
| 3 | [03-generators](03-generators/README.md) | configMapGenerator, secretGenerator, literals |
| 4 | [04-helm-bridge](04-helm-bridge/README.md) | `helm template` → Kustomize overlay (the combo lab) |

## Common commands

```powershell
kubectl kustomize .\path\to\overlay
kubectl apply -k .\path\to\overlay --dry-run=client -o yaml
kubectl apply -k .\path\to\overlay
kubectl delete -k .\path\to\overlay
```

Built into `kubectl` — no separate `kustomize` binary required for these labs.

## Next

Band 2 done → [03-authoring](../03-authoring/README.md) (Helm chart writing)
