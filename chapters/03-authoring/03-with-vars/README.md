# 03 — with + variables

**Cert:** `[CGOA]` `[CAPA]` · **Timebox:** 25 mins

## Objective

- `{{- with .Values.x }} ... {{- end }}` (root changes; `.` is now x)
- Return to outer scope with `$root := .` / `$rel := .Release.Name`
- Observe that the block is skipped when `with` is empty/nil

## Challenge (blind)

1. Nested `image: { repository, tag, pullPolicy }` in `values.yaml`.
2. Write the Deployment container image line inside `with .Values.image`.
3. In the same `with` block, **Release.Name** is needed for a label — get it with a `$` variable.
4. When `image:` is completely deleted from values, the template should skip the image section without throwing an error (or use a conscious default; choose one and verify).

## Verify

```powershell
helm template demo ./mychart | Select-String "image:"
helm template demo ./mychart -f values-no-image.yaml
# Conscious behavior: either skip or default — check according to what you chose
```

## Compare

Course: with / variables demos.
