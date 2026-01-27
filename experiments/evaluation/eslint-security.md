# ESLint Security Evaluation

## Vulnerabilities Detected
- **XSS**: No. ESLint Security does not track data flow for XSS (Semgrep did).
- **eval() usage**: No. The `eval("console.log('danger')")` was ignored because the argument is a static string literal. The rule `detect-eval-with-expression` only targets variables/identifiers.

## False Positives Observed
- None.

## Missed Issues
- **XSS**: Critical vulnerability in `res.send("<h1>" + user + "</h1>")` was completely missed.
- **Dangerous Eval**: The use of `eval` was missed because it wasn't "dynamic" enough for the rule, despite being a dangerous pattern to allow in any codebase.

## Output Quality
- **Readability**: N/A (No output).
- **Actionability**: N/A.

## Summary
ESLint with `eslint-plugin-security` proved to be a "linter" rather than a SAST tool in this experiment. It failed to detect the XSS vulnerability (its expected behavior, as it lacks taint analysis) and skipped the `eval` usage due to rule specificity (ignoring literals). This reinforces the distinct roles of linting (code quality/logic) vs. SAST (security flaws). It should be used *alongside* Semgrep, not as a replacement.
