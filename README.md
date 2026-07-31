# helm-labs

My own workspace to learn Helm (and Kustomize) by **writing**. Reference:
`../helm-masterclass` (stacksimplify Udemy course) — but I'm not copying the folders from there.

## Why a separate repo

In the course repo, the chart of each demo is **already finished**, and some also have
`backup-files/final-*`. Working in that format teaches you how to run `helm install` but
does not teach you how to write templates. The rule here is simple:

> Read the README → **close it** → write it yourself from scratch → then compare it with the course.

## Bands

| Band | Path | Focus | Method | Duration |
|---|---|---|---|---|
| **00 · Setup** | [chapters/00-setup](chapters/00-setup/README.md) | WSL, Podman, CLIs, Kind provider | Host toolchain | ~1 session |
| **01 · Helm CLI** | [chapters/01-cli](chapters/01-cli/README.md) | install/upgrade/rollback, values | Terminal drills | ~90 mins |
| **02 · Kustomize** | [chapters/02-kustomize](chapters/02-kustomize/README.md) | base/overlay, generators, Helm bridge | Write YAML yourself | ~3–4 sessions |
| **03 · Chart authoring** | [chapters/03-authoring](chapters/03-authoring/README.md) | templates, helpers, functions | Blind chart writing | ~6 sessions |
| **04 · Real world** | [chapters/04-platform](chapters/04-platform/README.md) | umbrella chart, Argo, OCI/sign | Accumulate one chart | ~4 sessions |

Order: **Helm CLI → Kustomize → Helm authoring → platform/GitOps**.  
Do not mix template authoring and Kustomize patches in the same sitting until the bridge lab (02 / 04-helm-bridge).

Band 04 logic: course dependency demos accumulate on one parent chart in
`chapters/04-platform/platform/` — a portfolio chart, not 47 toys.

## Relationship with certifications

Recommended order: **Setup → 01 → CKA/CKAD Helm+Kustomize drills → 02 → 03 → 04 → CGOA/CAPA → CKS**.

| Certification | Focus here | Band |
|---|---|---|
| **CKA / CKAD** | Helm release CLI; `kubectl -k` / kustomize | **01 + 02** |
| **CGOA / CAPA** | Helm or Kustomize as Argo source; umbrella | **02 + 03 + 04** |
| **CKS** | OCI, sign/verify, secure values/RBAC | **04** ([cks](chapters/04-platform/cks/README.md)) |
| **PCA / OTCA** | real charts (`kube-prometheus-stack`) | **04** practice |

## Lab enhance rules

In each lab: **cert tag**, **blind drill**, **verify block**, **failure drill** when needed,
**timebox**. In Band 04, topics accumulate in `platform/` (no folder-per-topic toys).

## Progress

- [ ] **00 · Setup** — [chapters/00-setup/README.md](chapters/00-setup/README.md)
- [ ] **0 · Cluster** — [cluster/README.md](cluster/README.md)
- [ ] **01 · Helm CLI** — [chapters/01-cli/README.md](chapters/01-cli/README.md)
- [ ] **02 · Kustomize** — [chapters/02-kustomize/README.md](chapters/02-kustomize/README.md)
  - [ ] [Basics](chapters/02-kustomize/01-basics/README.md)
  - [ ] [Overlays](chapters/02-kustomize/02-overlays/README.md)
  - [ ] [Generators](chapters/02-kustomize/03-generators/README.md)
  - [ ] [Helm bridge](chapters/02-kustomize/04-helm-bridge/README.md)
- [ ] **03 · Chart authoring** — [chapters/03-authoring/README.md](chapters/03-authoring/README.md)
  - [ ] [Built-ins](chapters/03-authoring/01-builtins/README.md)
  - [ ] [Conditionals](chapters/03-authoring/02-conditionals/README.md)
  - [ ] [with / variables](chapters/03-authoring/03-with-vars/README.md)
  - [ ] [range](chapters/03-authoring/04-range/README.md)
  - [ ] [helpers](chapters/03-authoring/05-helpers/README.md)
  - [ ] [functions](chapters/03-authoring/06-functions/README.md)
- [ ] **04 · Real world** — [chapters/04-platform/README.md](chapters/04-platform/README.md)
  - [ ] create + package + repo
  - [ ] dependency: alias, condition, tags
  - [ ] global values + import-values
  - [ ] hooks + weights + delete policy
  - [ ] tests, resource policy
  - [ ] values.schema.json
  - [ ] [OCI + chart signing](chapters/04-platform/cks/README.md)
  - [ ] [Argo CD Application](chapters/04-platform/argocd/README.md)

## Ebook (HTML + PDF)

Synthesized notes (AsciiDoc), separate from lab drills.
Build runs in the Asciidoctor container — checkout needs Podman/Docker, not a host JDK/Maven:

```powershell
cd work/docs
.\build.ps1
# → target/generated-docs/book.html
# → target/generated-docs/book.pdf
```

Details: [work/docs/README.md](work/docs/README.md)

## Getting Started

```powershell
# 1) Host toolchain — chapters/00-setup/README.md
# 2) Cluster create — cluster/README.md
$env:KIND_EXPERIMENTAL_PROVIDER = "podman"
kind create cluster --name helm-lab --config cluster/kind-config.yaml
kubectl config use-context kind-helm-lab

# 3) Band 1 — chapters/01-cli/README.md
# 4) Band 2 — chapters/02-kustomize/README.md
```
