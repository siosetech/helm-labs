# CKS bridge — OCI + chart signing + secure values

**Cert:** `[CKS]` · **Timebox:** 1 session  
**Prerequisite:** Band 04 packaging (`helm package ./platform`)

Supply chain: push the chart to OCI registry, sign it, verify it; pay attention to secret/RBAC hygiene in values.

## Lab C.1 — Package + OCI push `[CKS]`

**Challenge:**

1. `helm package ../platform` → `.tgz`
2. Select a local / remote OCI registry (for the lab: `zot`, `registry:2` in Kind, or `oci://ghcr.io/<user>`).
3. `helm push platform-0.1.0.tgz oci://...`
4. `helm pull oci://.../platform --version 0.1.0`

**Verify:**

```powershell
helm show chart oci://REPLACE/platform --version 0.1.0
```

<details>
<summary>Reference commands</summary>

```powershell
helm package ../platform
# Example GHCR (login required):
# echo $env:GITHUB_TOKEN | helm registry login ghcr.io -u USER --password-stdin
# helm push platform-0.1.0.tgz oci://ghcr.io/USER/charts
```

</details>

## Lab C.2 — Sign / verify `[CKS]`

**Challenge:**

1. Sign the chart / artifact with Provenance or cosign (`helm package --sign` **or** `cosign sign`).
2. Verify fail scenario: broken signature / wrong key → the command should fail.
3. Verify should pass with the correct key.

**Verify:**

```powershell
# Depending on the tool you chose:
# helm verify platform-0.1.0.tgz --keyring ...
# cosign verify ...
```

<details>
<summary>Failure drill</summary>

Verify with a wrong public key or mutated `.tgz` → **fail** is expected.
CKS mental model: do not deploy when the supply chain is broken.

</details>

## Lab C.3 — Secure values / RBAC hygiene `[CKS]`

**Challenge:**

1. **Do not** add a ServiceAccount that binds unnecessary `cluster-admin` to the chart (or values); instead:
   - design a minimal Role/RoleBinding example **or**
   - write a note for narrow permissions with `serviceAccount.create` in values.
2. Do not put Secrets in plaintext in `values.yaml`; use the `existingSecret` pattern or an external secret note.
3. Verify that there is no ClusterRoleBinding in the `helm template` output (for the lab chart).

**Verify:**

```powershell
helm template lab ../platform | Select-String "ClusterRole|kind: Secret"
# Expected: No ClusterRole; if there is a Secret, consciously explain why
```

## Checklist

- [ ] OCI push/pull
- [ ] sign + verify + intentional fail
- [ ] values/RBAC hygiene note or minimal RBAC template
