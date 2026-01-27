# SonarQube Evaluation

## Vulnerabilities Detected
- **SQL Injection**: No. Missed in both Java (`App.java`) and Python (`app.py`).
- **XSS**: No. Missed in JavaScript (`app.js`).
- **Resource Leaks**: **Yes**. Detected `java:S2095` (unclosed resources) in `App.java`.

## False Positives Observed
- None (but low detection rate).

## Missed Issues
- **SQL Injection (Critical)**: The `java:S3649` (Injection) rule failed to trigger. This is likely because SonarQube's Java analyzer requires compiled `.class` files to reconstruct the AST/Control Flow Graph accurately for taint analysis, and we scanned raw source files.
- **Python SQLi**: Missed standard `.format()` injection.
- **JavaScript XSS**: Missed `eval()` and `res.send()` XSS.

## Platform Features
- **Dashboard**: Excellent. Visualizes trends, "New Code" definitions, and Quality Gates.
- **Categorization**: Distinguishes well between "Bugs", "Vulnerabilities", and "Code Smells".
- **Quality Gates**: Powerful feature to block builds (not tested here, but visible in UI).

## Setup & Usability
- **Ease of Setup**: **Medium/Hard**. Required:
    - Docker container.
    - Token generation (Manual or API).
    - `sonar-project.properties` configuration.
    - Scanner installation (or Docker wrapper).
- **CI/CD Readiness**: High (official actions/pipes available), but requires a running server instance.

## Summary
SonarQube is a robust **Platform** for code quality, but out-of-the-box using the "Sonar Way" profile on **raw source code** (without build integration) yields **poor security findings**. It completely missed the specific vulnerable patterns that lightweight tools like Semgrep and Bandit found immediately. SonarQube excels when deeply integrated into the build process (providing classpaths, binaries) but struggles as a standalone "file scanner" for security.
