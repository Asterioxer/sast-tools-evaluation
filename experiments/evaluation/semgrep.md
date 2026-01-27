# Semgrep Evaluation

## Vulnerabilities Detected
- **SQL Injection**: Yes. Detected in both Java (`jdbc-sqli`) and Python (`sqlalchemy-execute-raw-query`).
- **XSS**: Yes. Detected in JavaScript (`raw-html-format` and `direct-response-write`).
- **Hardcoded Secrets**: No. The hardcoded password in Python was not flagged by the default config.
- **Eval Usage**: No. The `eval()` usage in JavaScript was not flagged by the default config.

## False Positives Observed
- **CSRF Middleware**: Detected a missing CSRF middleware in `app.js`. While technically correct (it is missing), for this tiny snippet it might be considered noise, but it is valid security feedback.

## Missed Issues
- **Hardcoded Secrets**: `password = "hardcoded_password"` in `python/app.py` was ignored.
- **Dangerous Eval**: `eval("console.log('danger')")` in `javascript/app.js` was ignored.

## Output Quality
- **Readability**: High. The JSON output provides clear "message", "lines", and "confidence" fields. The rule IDs are descriptive.
- **Actionability**: High. It explicitly suggests fixes (e.g., "Use a prepared statements", "use 'resp.render()'").

## Summary
Semgrep performed well on injection flaws (SQLi, XSS) using the `auto` config, identifying them with clear remediation advice. However, it notably missed the "easy" wins of hardcoded secrets and `eval()` usage in its default configuration, suggesting that specific rulesets (like `p/secrets` or `p/javascript`) might need to be explicitly enabled for broader coverage.
