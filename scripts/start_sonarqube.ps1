Write-Host "Checking SonarQube Server status..." -ForegroundColor Cyan

$containerName = "sonarqube"
$imageName = "sonarqube:lts-community"
$port = "9000"

# Check if container exists
$containerExists = docker ps -a -q -f name=$containerName

if ($containerExists) {
    # Check if it is running
    $isRunning = docker ps -q -f name=$containerName
    if ($isRunning) {
        Write-Host "SonarQube container '$containerName' is already running." -ForegroundColor Green
    }
    else {
        Write-Host "Starting existing SonarQube container..." -ForegroundColor Yellow
        docker start $containerName | Out-Null
        Write-Host "SonarQube started." -ForegroundColor Green
    }
}
else {
    Write-Host "Creating and starting new SonarQube container..." -ForegroundColor Yellow
    docker run -d --name $containerName -p "${port}:${port}" $imageName
    Write-Host "SonarQube container created and started." -ForegroundColor Green
}

Write-Host "Waiting for SonarQube to be ready (this may take a minute)..." -ForegroundColor Cyan
# Simple wait loop
$retries = 30
$url = "http://localhost:${port}/api/system/status"
$ready = $false

for ($i = 0; $i -lt $retries; $i++) {
    try {
        $response = Invoke-RestMethod -Uri $url -Method Get -ErrorAction Stop
        if ($response.status -eq "UP") {
            $ready = $true
            break
        }
    }
    catch {
        # Ignore errors and wait
    }
    Write-Host -NoNewline "."
    Start-Sleep -Seconds 2
}

Write-Host ""
if ($ready) {
    Write-Host "SonarQube is UP and Ready at http://localhost:$port" -ForegroundColor Green
    Write-Host "Default login: admin / admin" -ForegroundColor Gray
}
else {
    Write-Host "SonarQube is starting up but not yet fully ready. Please check logs or wait a moment." -ForegroundColor Yellow
}
