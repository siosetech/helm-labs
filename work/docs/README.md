# Helm Labs ebook (AsciiDoc → HTML + PDF)

Container-only build with the official
[`asciidoctor/docker-asciidoctor`](https://github.com/asciidoctor/docker-asciidoctor) image.
After checkout you need **Podman or Docker** — not a host JDK or Maven.

## Prerequisites

- Podman Desktop (preferred here) or Docker
- Compose (`podman compose` / `docker compose`)

## Build

From `work/docs`:

```powershell
.\build.ps1
```

```bash
./build.sh
# or:
podman compose run --rm ebook
```

Outputs (bind-mounted to the host):

- `generated/book.html`
- `generated/book.pdf`

## CI

[`.github/workflows/ebook.yml`](../../.github/workflows/ebook.yml) builds with the same
Asciidoctor image when AsciiDoc sources change. It uploads artifacts **and** on
`master`/`main` commits the files into `work/docs/generated/` so they stay in the repo.
Manual run: Actions → ebook → Run workflow.

## Source layout

```
asciidoc/
  book.adoc                 # master document
  chapters/*.adoc           # include targets — write new notes here
compose.yaml                # Asciidoctor container build
```


Do **not** `include::` lab `chapters/**/*.md` files. Labs stay drills; ebook chapters are short synthesized notes in AsciiDoc.

## After a lab session

1. Add or extend an `.adoc` under `asciidoc/chapters/`.
2. `include::` it from `book.adoc` if it is new.
3. Run `.\build.ps1` (or `./build.sh`) and skim HTML/PDF.
