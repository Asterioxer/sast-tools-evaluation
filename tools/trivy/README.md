# Trivy - Container & Filesystem Security

## Overview
Trivy is a comprehensive security scanner. We use it here primarily for:
1.  **Filesystem Scanning**: Identifying vulnerabilities in dependencies (SCA) and misconfigurations.
2.  **Container Scanning**: Scanning Docker images.

## Commands

### Filesystem Scan
```bash
# Basic scan of current directory
trivy fs .

# JSON Output
trivy fs --format json --output trivy-results.json .
```

### Image Scan
```bash
trivy image python:3.9-alpine
```

## Integration
Trivy is integrated via Nomad for CI/CD workflows, but can also be run locally using the `scripts/run_tools_local.ps1` script.
