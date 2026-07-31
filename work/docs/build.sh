#!/usr/bin/env sh
# Build HTML + PDF via asciidoctor/docker-asciidoctor (Podman preferred, Docker fallback).
# Usage: from work/docs → ./build.sh
set -eu
cd "$(dirname "$0")"

if command -v podman >/dev/null 2>&1; then
  ENGINE=podman
elif command -v docker >/dev/null 2>&1; then
  ENGINE=docker
else
  echo "Neither podman nor docker found. Install Podman Desktop (or Docker) and retry." >&2
  exit 1
fi

"$ENGINE" compose run --rm ebook

echo "Outputs: $(pwd)/generated/book.html"
echo "         $(pwd)/generated/book.pdf"
