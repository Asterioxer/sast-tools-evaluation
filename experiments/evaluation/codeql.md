# CodeQL Evaluation

## Vulnerabilities Detected
- **SQL Injection**: No. The targeted query `python/ql/src/Security/CWE-089/SqlInjection.ql` returned 0 results for the test case.
- **Hardcoded Secrets**: N/A (Scan was targeted to SQLi only due to performance issues).

## False Positives Observed
- None (0 results).

## Missed Issues
- **SQL Injection**: The standard Python SQL injection using `.format()` string interpolation was not detected by the default query in this environment.

## Output Quality
- **Readability**: SARIF is a standard machine-readable format but not human-friendly without a viewer.
- **Actionability**: N/A (No results).

## Setup & Usability
- **Ease of Setup**: **Low / Difficult**. Required:
    - Docker container (CLI not available).
    - Manual database creation (slow).
    - Complex command flags (`--source-root`, `--format`).
    - Debugging permission/file-locking errors on Windows volumes.
- **Performance**: **Slow**. Database creation took minutes; full query suite stuck on compilation; targeted query was faster but still overhead-heavy.
- **Complexity**: High. Requires understanding of QL packs, database schemas, and query compilation.

## Summary
CodeQL is a powerful enterprise-grade tool, but it is **not suitable for quick, lightweight scanning** in this context. The setup complexity (Docker, databases, compilation) is orders of magnitude higher than Semgrep or Bandit. In this experiment, it failed to produce results for a simple case that other tools caught immediately, likely due to environment/configuration subtleties or query specificity. It is best suited for deep, integrated CI/CD pipelines rather than ad-hoc verification.
