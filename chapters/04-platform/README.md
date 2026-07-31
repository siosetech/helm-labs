# 04 · Real world (umbrella platform)

**Cert tags:** `[CGOA]` `[CAPA]` `[CKS]` · PCA/OTCA side track  
**Timebox:** ~4 sessions + Argo/CKS stubs  
**Prerequisite:** [03-authoring](../03-authoring/README.md)

## Logic

The separate dependency demos of the course accumulate here on a **single parent chart**:

`platform/` → an umbrella chart that can be put in a portfolio at the end.

Add each step to the same chart; do not create a new folder.

## Blind rule

Read → close → apply in `platform/` → compare with course / docs.

## Progression (in order)

- [ ] create + package + (local) repo
- [ ] dependency: alias, condition, tags
- [ ] global values + import-values
- [ ] hooks + weights + delete policy
- [ ] tests, resource policy
- [ ] values.schema.json
- [ ] OCI registry + chart signing → [cks/README.md](cks/README.md)
- [ ] Argo CD Application (Helm source) → [argocd/README.md](argocd/README.md)

## Getting Started

```powershell
cd chapters/04-platform
helm create platform
# Then you will add Chart.yaml type: application; dependencies
helm lint ./platform
helm template lab ./platform
```

If the skeleton already exists (`platform/Chart.yaml`), do not overwrite it — expand it step by step.

## Verify (after each step)

```powershell
helm dependency update ./platform   # when there are deps
helm lint ./platform
helm template lab ./platform -f platform/values.yaml | Select-Object -First 80
helm upgrade --install platform ./platform -n platform --create-namespace --dry-run
```

## Sub-labs

| Path | Purpose | Cert |
|---|---|---|
| [platform/](platform/) | Umbrella chart (accumulates) | CGOA/CAPA |
| [argocd/](argocd/README.md) | Application → Helm chart | CGOA/CAPA |
| [cks/](cks/README.md) | OCI + sign/verify + secure values | CKS |
