# 04 — range (list + dict)

**Cert:** `[CGOA]` `[CAPA]` · **Timebox:** 35 mins

## Objective

- List: `range .Values.env` → Env vars
- Dict: `range $k, $v := .Values.labels` → label pairs
- Use `$` with root/Release inside `range`

## Challenge (blind)

1. `values.yaml`:

   ```yaml
   env:
     - name: LOG_LEVEL
       value: info
     - name: REGION
       value: eu
   extraLabels:
     team: platform
     tier: web
   ```

2. Generate the `env:` list in Deployment using `range`.
3. Add the `extraLabels` dict to pod labels using `range`.
4. Adding the release name as an annotation or label to each env var is **not mandatory**; but use `$` in at least one place.

## Verify

```powershell
helm template demo ./mychart | Select-String "LOG_LEVEL|REGION|team:|tier:"
helm lint ./mychart
```

## Compare

Course: range list/dict demos.
