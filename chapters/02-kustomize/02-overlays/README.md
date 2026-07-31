# 02 — Base + overlays

**Cert:** `[CKA]` `[CKAD]` `[CGOA]` · **Timebox:** 35 min

## Objective

One **base**, two **overlays** (dev / prod) with different replicas and a patch. This is the Kustomize mental model used in GitOps.

## Challenge (blind)

Suggested layout (create it yourself):

```
02-overlays/
  base/
    kustomization.yaml
    deployment.yaml
    service.yaml
  overlays/
    dev/
      kustomization.yaml    # resources: [../../base], replicas: 1, namePrefix: dev-
    prod/
      kustomization.yaml    # resources: [../../base], replicas: 3, namePrefix: prod-
      patch-resources.yaml  # e.g. raise memory/cpu or add an annotation
```

Requirements:

1. Base has no environment-specific names.
2. `kubectl kustomize overlays/dev` and `.../prod` both succeed.
3. Prod uses a **strategic merge** or **JSON6902** patch (pick one; know which you used).
4. `commonLabels` or `labels` differ per overlay (`env: dev` / `env: prod`).

## Verify

```powershell
kubectl kustomize overlays/dev | Select-String "name:|replicas:|env:"
kubectl kustomize overlays/prod | Select-String "name:|replicas:|env:"
kubectl apply -k overlays/dev --dry-run=client
kubectl apply -k overlays/prod --dry-run=client
# Optional live:
# kubectl apply -k overlays/dev
# kubectl delete -k overlays/dev
```

## Compare

Helm values overlays vs Kustomize directory overlays — one sentence in your ebook notes: when you’d pick which.
