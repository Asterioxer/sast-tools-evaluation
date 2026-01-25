# GitHub CodeQL – Linux Commands

## Installation
```bash
gh extension install github/gh-codeql # via GitHub CLI
```

## Basic Scan
```bash
# 1. Create Database
codeql database create ./qldb --language=python
# 2. Analyze
codeql database analyze ./qldb --format=sarif-latest --output=results.sarif
```

## Report Generation
```bash
# Analysis command outputs results.sarif by default.
```
