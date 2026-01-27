# Run from repository root
# Usage: ./experiments/tool-runs/sonarqube/command.sh <token>
docker run --rm -v "${PWD}:/usr/src" sonarsource/sonar-scanner-cli -Dsonar.projectKey=sast-experiments -Dsonar.sources=experiments/vulnerable-apps -Dsonar.host.url=http://host.docker.internal:9000 -Dsonar.login=$1
