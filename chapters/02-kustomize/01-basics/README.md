# 01 — Kustomize basics

**Cert:** `[CKA]` `[CKAD]` · **Timebox:** 25 min  
**Prerequisite:** cluster context `kind-helm-lab`

## Objective

Build a tiny app with a single `kustomization.yaml` that lists resources. Render and apply with kubectl.

## Challenge (blind)

Under this folder create:

1. `deployment.yaml` — nginx, 1 replica, label `app: web`
2. `service.yaml` — ClusterIP targeting `app: web`
3. `kustomization.yaml` — `resources:` listing both files  
   Optional: `commonLabels: { env: lab }`

Do **not** use Helm in this lab.

## Verify

```powershell
kubectl kustomize .
# Must show Deployment + Service; commonLabels appear on both if set

kubectl apply -k . --dry-run=client -o yaml | Select-String "kind:"
kubectl apply -k .
kubectl get deploy,svc -l app=web
kubectl delete -k .
```

<details>
<summary>Shape hint (not a full solution)</summary>

```yaml
# kustomization.yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
  - deployment.yaml
  - service.yaml
```

</details>
