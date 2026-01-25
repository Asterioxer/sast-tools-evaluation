# SonarQube – Linux Commands

## Installation
```bash
docker run -d --name sonarqube -p 9000:9000 sonarqube
```

## Basic Scan
```bash
sonar-scanner \
  -Dsonar.projectKey=my_project \
  -Dsonar.sources=. \
  -Dsonar.host.url=http://localhost:9000 \
  -Dsonar.login=my_token
```

## Report Generation
```bash
# Reports are typically viewed in the UI or exported via API/Plugins given the command structure above.
# The basic scan command uploads results to the server.
```
