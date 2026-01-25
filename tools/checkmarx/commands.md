# Checkmarx SAST (CxSAST) – Linux Commands

## Installation
```bash
# Assumes cx-cli is downloaded and in PATH
chmod +x cx-cli
```

## Basic Scan
```bash
cx scan create \
  --project-name 'MyApp' \
  --sast-preset 'Checkmarx Default' \
  --source ./src \
  --report-pdf=report.pdf
```

## Report Generation
```bash
# Report is generated as part of the scan command above (--report-pdf).
```
