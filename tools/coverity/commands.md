# Synopsys Coverity – Linux Commands

## Installation
```bash
./cov-analysis-linux64.sh # Enterprise installer
```

## Basic Scan
```bash
# Capture Build
cov-build --dir cov-int make
# Analyze
cov-analyze --dir cov-int
```

## Report Generation
```bash
# Commit Defects
cov-commit-defects --dir cov-int --stream my_stream --url http://coverity_server:8080
```