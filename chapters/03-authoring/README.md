# 03 · Chart authoring

**Cert tags:** `[CGOA]` `[CAPA]` (in-depth); CKA/CKAD does not include chart authoring  
**Timebox:** ~6 sessions (20–40 mins per lab)  
**Prerequisite:** [01-cli](../01-cli/README.md) and [02-kustomize](../02-kustomize/README.md)

## Blind rule (blind drill)

> Read the README → **close it** → write it yourself from scratch → then
> compare with `../helm-masterclass`. No folder copying.

Each subfolder contains only the **target + verify**. The solution chart is not committed;
you create it here using `helm create`.

## Session order

| # | Folder | Topic |
|---|---|---|
| 1 | [01-builtins](01-builtins/README.md) | Built-in objects + template basics |
| 2 | [02-conditionals](02-conditionals/README.md) | if/else, eq, and, or, not |
| 3 | [03-with-vars](03-with-vars/README.md) | with, variables |
| 4 | [04-range](04-range/README.md) | range (list + dict) |
| 5 | [05-helpers](05-helpers/README.md) | named templates, `_helpers.tpl`, include vs template |
| 6 | [06-functions](06-functions/README.md) | printf, default, quote, indent/nindent |

## Common workflow

```powershell
cd chapters/03-authoring/01-builtins   # example
helm create mychart
# edit templates/ and values.yaml according to the target
helm template demo ./mychart
helm lint ./mychart
helm install demo ./mychart --dry-run
# If you want to push to the cluster:
# helm upgrade --install demo ./mychart -n helm-lab --create-namespace
```

Compare (if the course repo is next to it):

```powershell
# Example — adjust the course path for your machine
# Compare-Object (Get-Content .\mychart\templates\deployment.yaml) (Get-Content ..\..\..\helm-masterclass\...)
```

## Next

When Band 3 is finished → [04-platform](../04-platform/README.md) (accumulate in a single umbrella)
