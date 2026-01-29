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
    docker run --rm -v "${RepoRoot}:/src" returntocorp/semgrep:latest semgrep scan --config=auto --sarif --output /src/semgrep-results.sarif /src
    
    
    if ($?) {
        if (Test-Path "$RepoRoot/semgrep-results.sarif") {
            Write-Host "[Semgrep] Scan complete. Results saved to semgrep-results.sarif" -ForegroundColor Green
        }
        else {
            Write-Host "[Semgrep] Command finished, but output file 'semgrep-results.sarif' was NOT found." -ForegroundColor Red
        }
    }
    else {
        Write-Host "[Semgrep] Scan failed." -ForegroundColor Red
    }
}

function Invoke-Trivy {
    Write-Host "`n[Trivy] Starting Filesystem Scan..." -ForegroundColor Yellow
    # Using the same image as in Nomad job
    docker run --rm -v "${RepoRoot}:/src" aquasec/trivy:latest fs --format sarif --output /src/trivy-results.sarif /src
    
    
    
    if ($?) {
        if (Test-Path "$RepoRoot/trivy-results.sarif") {
            Write-Host "[Trivy] Scan complete. Results saved to trivy-results.sarif" -ForegroundColor Green
        }
        else {
            Write-Host "[Trivy] Command finished, but output file 'trivy-results.sarif' was NOT found." -ForegroundColor Red
        }
    }
    else {
        Write-Host "[Trivy] Scan failed." -ForegroundColor Red
    }
}

function Invoke-SonarQube {
    Write-Host "`n[SonarQube] Starting Scan..." -ForegroundColor Yellow
    
    # Dynamically build the report paths based on what exists
    $reportPaths = @()
    if (Test-Path "$RepoRoot/semgrep-results.sarif") { $reportPaths += "semgrep-results.sarif" }
    if (Test-Path "$RepoRoot/trivy-results.sarif") { $reportPaths += "trivy-results.sarif" }
    
    $dockerArgs = @(
        "run", "--rm",
        "-v", "${RepoRoot}:/usr/src",
        "sonarsource/sonar-scanner-cli",
        "-Dsonar.projectKey=sast-tools-demo",
        "-Dsonar.sources=.",
        "-Dsonar.host.url=http://host.docker.internal:9000",
        "-Dsonar.login=admin",
        "-Dsonar.password=admin",
        "-Dsonar.exclusions=**/node_modules/**,**/experiments/**,**/.venv/**,**/vendor/**",
        "-Dsonar.scm.disabled=true"
    )

    if ($reportPaths.Count -gt 0) {
        $dockerArgs += "-Dsonar.sarif.reportPaths=$($reportPaths -join ',')"
    }

    # Execute Docker with the array of arguments
    & docker $dockerArgs

    if ($?) {
        Write-Host "[SonarQube] Scan complete. Check your dashboard at http://localhost:9000" -ForegroundColor Green
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
