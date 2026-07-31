# 06 — Template functions

**Cert:** `[CGOA]` `[CAPA]` · **Timebox:** 30 mins

## Objective

Frequently used Sprig/Helm functions: `printf`, `default`, `quote`, `indent` / `nindent`,
`toYaml`, `trim`, `lower` / `upper`.

## Challenge (blind)

1. Use `default "latest"` if image tag does not exist.
2. Print annotation values with `quote`.
3. Embed a ConfigMap `data` block from values with `toYaml | nindent 2`.
4. Generate a label with `printf "%s-%s" .Release.Name .Chart.Name` (you can also put it in helpers).

## Verify

```powershell
helm template demo ./mychart --set image.tag= | Select-String "latest"
helm template demo ./mychart | Select-String '".*"'  # lines with quotes
helm lint ./mychart
```

## Compare

Course: functions demos.

## Band 3 exit

If all 01–06 verifies are green → [04-platform](../../04-platform/README.md)
