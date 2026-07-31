# 01 — Built-ins + template basics

**Cert:** `[CGOA]` `[CAPA]` · **Timebox:** 30 mins

## Objective

Use built-in objects consciously after `helm create mychart`:

- `.Release` (Name, Namespace, Service)
- `.Chart` (Name, Version, AppVersion)
- `.Values`
- `.Capabilities` (brief look)
- `{{ /* comment */ }}`, `{{ .Values.x }}`, pipeline `|`

## Challenge (blind)

1. Create a chart.
2. Put `app.kubernetes.io/instance: {{ .Release.Name }}` in Deployment labels (keep it if it already exists).
3. Add a ConfigMap: populate `release`, `chart`, and `appVersion` strings in data using templates.
4. Define `greeting: hello` in `values.yaml`; write it to the ConfigMap.

## Verify

```powershell
helm lint ./mychart
helm template demo ./mychart | Select-String "hello|demo|appVersion"
helm template demo ./mychart --debug 2>&1 | Select-Object -First 5
```

## Compare

Course: template / built-in object demos (stacksimplify ~10–12). Take a diff; no copying.
