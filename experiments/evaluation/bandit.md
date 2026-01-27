# Bandit Evaluation

## Vulnerabilities Detected
- **SQL Injection**: Yes. Detected as "Possible SQL injection vector through string-based query construction" (B608).
- **Hardcoded Secrets**: Yes. Detected as "Possible hardcoded password" (B105).

## False Positives Observed
- None. Both findings point to actual intentional vulnerabilities in the test app.

## Missed Issues
- None. For this specific Python file, Bandit found exactly what was expected.

## Output Quality
- **Readability**: High. JSON structure is clean; text output (if used) is also very readable.
- **Actionability**: Medium. It identifies the issue and links to documentation, but doesn't provide a direct fix snippet like Semgrep often does.

## Summary
Bandit proved its value as a Python-specific tool by immediately catching the hardcoded password that Semgrep's default rules missed. It correctly identified both the SQL injection and the secret with zero false positives on this small sample, demonstrating why language-specific tools are a critical part of the SAST mix.
