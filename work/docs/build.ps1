# Build HTML + PDF via asciidoctor/docker-asciidoctor (Podman preferred, Docker fallback).
# Usage: from work/docs → .\build.ps1
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

function Invoke-Compose {
    param([string]$Engine)
    & $Engine compose run --rm ebook
    if ($LASTEXITCODE -ne 0) { throw "$Engine compose failed with exit $LASTEXITCODE" }
}

if (Get-Command podman -ErrorAction SilentlyContinue) {
    Invoke-Compose podman
} elseif (Get-Command docker -ErrorAction SilentlyContinue) {
    Invoke-Compose docker
} else {
    throw "Neither podman nor docker found. Install Podman Desktop (or Docker) and retry."
}

Write-Host "Outputs: $PSScriptRoot\target\generated-docs\book.html"
Write-Host "         $PSScriptRoot\target\generated-docs\book.pdf"
