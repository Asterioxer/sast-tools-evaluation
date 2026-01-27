# Create database
docker run --rm --entrypoint "" -v "${PWD}:/src" mcr.microsoft.com/cstsectools/codeql-container codeql database create /src/experiments/tool-runs/codeql/database --language=python --source-root /src/experiments/vulnerable-apps/python --overwrite

# Analyze database
docker run --rm --entrypoint "" -v "${PWD}:/src" mcr.microsoft.com/cstsectools/codeql-container codeql database analyze /src/experiments/tool-runs/codeql/database codeql/python-queries --format=sarif-latest --output=/src/experiments/tool-runs/codeql/results.sarif
