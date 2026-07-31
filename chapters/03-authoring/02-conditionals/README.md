# 02 — Conditionals

**Cert:** `[CGOA]` `[CAPA]` · **Timebox:** 30 mins

## Objective

Toggle resources or fields using `if` / `else` / `else if`, `eq`, `ne`, `and`, `or`, `not`.

## Challenge (blind)

1. `values.yaml`: `serviceAccount.create` (bool), `ingress.enabled` (bool), `env: prod|dev`.
2. Render ServiceAccount only when `create: true`.
3. Render Ingress only when `enabled: true`.
4. ConfigMap annotation: if `env` is `prod` then `critical: "true"`, otherwise omit it (use `eq`).

## Verify

```powershell
helm template demo ./mychart --set serviceAccount.create=false | Select-String "kind: ServiceAccount"
# Line should be absent

helm template demo ./mychart --set ingress.enabled=true | Select-String "kind: Ingress"
# Line should be present

helm template demo ./mychart --set env=prod | Select-String "critical"
```

## Compare

Course: if/else demos. Diff; no copying.
