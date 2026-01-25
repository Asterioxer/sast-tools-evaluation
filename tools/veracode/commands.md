# Veracode Static Analysis – Linux Commands

## Installation
```bash
curl -O https://downloads.veracode.com/securityscan/pipeline-scan-LATEST.zip
unzip pipeline-scan-LATEST.zip
```

## Basic Scan
```bash
java -jar pipeline-scan.jar \
  --file myapp.war \
  --project_name 'MyApp' \
  --fail_on_severity 'Very High, High'
```

## Report Generation
```bash
# Pipeline scan generates results in JSON/standard output by default.
# The Basic Scan command above performs the scan.
```
