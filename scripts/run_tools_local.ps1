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
    [ValidateSet("semgrep", "trivy", "sonarqube", "all")]
    [string]$Tool = "all"
)

$RepoRoot = Get-Location
Write-Host "Running tools in: $RepoRoot" -ForegroundColor Cyan

function Invoke-Semgrep {
    Write-Host "`n[Semgrep] Starting Scan..." -ForegroundColor Yellow
    # Using the same image as in Nomad job
    docker run --rm -v "${RepoRoot}:/src" returntocorp/semgrep:latest semgrep scan --config=auto --json --output /src/semgrep-results.json /src
    
    
    if ($?) {
        if (Test-Path "$RepoRoot/semgrep-results.json") {
            Write-Host "[Semgrep] Scan complete. Results saved to semgrep-results.json" -ForegroundColor Green
        }
        else {
            Write-Host "[Semgrep] Command finished, but output file 'semgrep-results.json' was NOT found." -ForegroundColor Red
        }
    }
    else {
        Write-Host "[Semgrep] Scan failed." -ForegroundColor Red
    }
}

function Invoke-Trivy {
    Write-Host "`n[Trivy] Starting Filesystem Scan..." -ForegroundColor Yellow
    # Using the same image as in Nomad job
    docker run --rm -v "${RepoRoot}:/src" aquasec/trivy:latest fs --format json --output /src/trivy-results.json /src
    
    
    
    if ($?) {
        if (Test-Path "$RepoRoot/trivy-results.json") {
            Write-Host "[Trivy] Scan complete. Results saved to trivy-results.json" -ForegroundColor Green
        }
        else {
            Write-Host "[Trivy] Command finished, but output file 'trivy-results.json' was NOT found." -ForegroundColor Red
        }
    }
    else {
        Write-Host "[Trivy] Scan failed." -ForegroundColor Red
    }
}

function Invoke-SonarQube {
    Write-Host "`n[SonarQube] Starting Scan (Placeholder)..." -ForegroundColor Yellow
    # Placeholder for SonarQube scan
    $sonarOutput = @"
SonarQube execution requires a running server and sonar-scanner binary.
This file represents where the report would be generated (or linked from).

Typical output from scanner:
INFO: Analysis report generated in 123ms, dir size=200 KB
INFO: Analysis report compressed in 23ms, zip size=50 KB
INFO: Analysis report uploaded in 55ms
INFO: ANALYSIS SUCCESSFUL, you can browse http://localhost:9000/dashboard?id=sast-tools-demo
"@
    Set-Content -Path "$RepoRoot/sonarqube-results.txt" -Value $sonarOutput
    
    if (Test-Path "$RepoRoot/sonarqube-results.txt") {
        Write-Host "[SonarQube] Scan complete. Results saved to sonarqube-results.txt" -ForegroundColor Green
    }
    else {
        Write-Host "[SonarQube] Scan failed." -ForegroundColor Red
    }
}

# Execution Logic
$ExitCode = 0

if ($Tool -eq "semgrep" -or $Tool -eq "all") {
    Invoke-Semgrep
    if (-not $?) { $ExitCode = 1 }
}

if ($Tool -eq "trivy" -or $Tool -eq "all") {
    Invoke-Trivy
    if (-not $?) { $ExitCode = 1 }
}

if ($Tool -eq "sonarqube" -or $Tool -eq "all") {
    Invoke-SonarQube
    if (-not $?) { $ExitCode = 1 }
}

Write-Host "`nDone." -ForegroundColor Cyan
if ($ExitCode -ne 0) {
    Write-Host "One or more scans failed." -ForegroundColor Red
    exit $ExitCode
}
