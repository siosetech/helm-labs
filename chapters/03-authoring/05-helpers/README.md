# 05 — Named templates + helpers

**Cert:** `[CGOA]` `[CAPA]` · **Timebox:** 40 mins

## Objective

- `{{- define "mychart.fullname" -}}` in `_helpers.tpl`
- `include` vs `template` (include enters the pipeline; use it with indent)
- `mychart.labels` / `mychart.selectorLabels` pattern

## Challenge (blind)

1. Helpers: `name`, `fullname`, `labels`, `selectorLabels`.
2. Deployment, Service, ConfigMap — all use the same `include "mychart.labels" . | nindent 4` pattern.
3. `fullname` should truncate according to the 63 characters rule (check the helm create default and rewrite it).
4. Intentionally try with `template` in one place; write a one-sentence note in notes.md on why `include` is preferred (or put it in a scratch file if you don't want to commit).

## Verify

```powershell
helm template demo ./mychart | Select-String "app.kubernetes.io/name|app.kubernetes.io/instance"
helm lint ./mychart
# Names must be consistent (deploy + service selector match)
```

## Compare

Course: named templates / include demos.
