<#
.SYNOPSIS
    Runs SAST tools (Semgrep, Trivy) locally using Docker.
    Helps avoid overuse of Nomad for simple local verification.

.DESCRIPTION
    This script provides a simple interface to run Semgrep and Trivy scans
    against the current repository context. It mounts the current directory
    to the Docker containers.

.EXAMPLE
    .\run_tools_local.ps1 -Tool semgrep
    .\run_tools_local.ps1 -Tool trivy
#>

param(
    [Parameter(Mandatory = $false)]
    [ValidateSet("semgrep", "trivy", "all")]
    [string]$Tool = "all"
)

$RepoRoot = Get-Location
Write-Host "Running tools in: $RepoRoot" -ForegroundColor Cyan

function Run-Semgrep {
    Write-Host "`n[Semgrep] Starting Scan..." -ForegroundColor Yellow
    # Using the same image as in Nomad job
    docker run --rm -v "${RepoRoot}:/src" returntocorp/semgrep:latest semgrep scan --config=auto --json --output /src/semgrep-results.json /src
    
    if ($?) {
        Write-Host "[Semgrep] Scan complete. Results saved to semgrep-results.json" -ForegroundColor Green
    }
    else {
        Write-Host "[Semgrep] Scan failed." -ForegroundColor Red
    }
}

function Run-Trivy {
    Write-Host "`n[Trivy] Starting Filesystem Scan..." -ForegroundColor Yellow
    # Using the same image as in Nomad job
    docker run --rm -v "${RepoRoot}:/src" aquasec/trivy:latest fs --format json --output /src/trivy-results.json /src
    
    if ($?) {
        Write-Host "[Trivy] Scan complete. Results saved to trivy-results.json" -ForegroundColor Green
    }
    else {
        Write-Host "[Trivy] Scan failed." -ForegroundColor Red
    }
}

# Execution Logic
$ExitCode = 0

if ($Tool -eq "semgrep" -or $Tool -eq "all") {
    Run-Semgrep
    if (-not $?) { $ExitCode = 1 }
}

if ($Tool -eq "trivy" -or $Tool -eq "all") {
    Run-Trivy
    if (-not $?) { $ExitCode = 1 }
}

Write-Host "`nDone." -ForegroundColor Cyan
if ($ExitCode -ne 0) {
    Write-Host "One or more scans failed." -ForegroundColor Red
    exit $ExitCode
}
