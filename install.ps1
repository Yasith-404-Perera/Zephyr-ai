<#
.SYNOPSIS
  Install Zephyr AI CLI on Windows
.DESCRIPTION
  Installs Zephyr globally via npm. Requires Node.js 18+.
.PARAMETER Version
  Version of Zephyr to install (default: latest)
.EXAMPLE
  iex "& { $(irm https://zephyr-ai.dev/install.ps1) }"
#>

param(
  [string]$Version = "latest"
)

$ZephyrNodeMin = 18

# ── Logo ────────────────────────────────────────────────
$logo = @"

  Zephyr — AI terminal agent

"@

Write-Host ""
Write-Host "   ███████╗███████╗██████╗ ██╗  ██╗██╗   ██╗██████╗" -ForegroundColor Cyan
Write-Host "   ╚══███╔╝██╔════╝██╔══██╗██║  ██║╚██╗ ██╔╝██╔══██╗" -ForegroundColor Cyan
Write-Host "     ███╔╝ █████╗  ██████╔╝███████║ ╚████╔╝ ██████╔╝" -ForegroundColor Cyan
Write-Host "    ███╔╝  ██╔══╝  ██╔═══╝ ██╔══██║  ╚██╔╝  ██╔══██╗" -ForegroundColor Cyan
Write-Host "   ███████╗███████╗██║     ██║  ██║   ██║   ██║  ██║" -ForegroundColor Cyan
Write-Host "   ╚══════╝╚══════╝╚═╝     ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝" -ForegroundColor Cyan
Write-Host ""
Write-Host "Zephyr — AI terminal agent" -ForegroundColor White
Write-Host ""

# ── Pre-flight checks ──────────────────────────────────
try {
  $nodeVersion = node --version
} catch {
  Write-Host "Error: Node.js is not installed." -ForegroundColor Red
  Write-Host "Zephyr requires Node.js v$ZephyrNodeMin+."
  Write-Host "Download from https://nodejs.org"
  exit 1
}

$majorVersion = [int]($nodeVersion -replace 'v', '' -replace '\..*', '')
if ($majorVersion -lt $ZephyrNodeMin) {
  Write-Host "Error: Node.js $nodeVersion is too old." -ForegroundColor Red
  Write-Host "Zephyr requires Node.js v$ZephyrNodeMin+."
  exit 1
}

try {
  $npmVersion = npm --version
} catch {
  Write-Host "Error: npm is not installed." -ForegroundColor Red
  exit 1
}

# ── Install ─────────────────────────────────────────────
Write-Host "Installing Zephyr..." -ForegroundColor Cyan

if ($Version -eq "latest") {
  npm install -g zephyr-ai
} else {
  npm install -g "zephyr-ai@${Version}"
}

if ($LASTEXITCODE -ne 0) {
  Write-Host "Installation failed." -ForegroundColor Red
  exit 1
}

Write-Host ""
Write-Host "✔ Zephyr installed successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "Run 'zephyr' to start." -ForegroundColor White
Write-Host "Run 'zephyr login' to configure your API provider." -ForegroundColor White
Write-Host "Run 'zephyr doctor' to verify your setup." -ForegroundColor White
Write-Host ""
