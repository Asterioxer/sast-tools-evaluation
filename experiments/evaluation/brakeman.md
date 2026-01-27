# Brakeman Evaluation

## Vulnerabilities Detected
- **SQL Injection**: Yes. Detected as "Possible SQL injection" (Check: SQL).
- **XSS**: Yes. Detected as "Unescaped parameter value rendered inline" (Check: RenderInline).

## False Positives Observed
- None. Both warnings map directly to the intentional vulnerabilities in the test app.

## Missed Issues
- None. Brakeman correctly parsed the partial Rails app and identified the high-risk patterns.

## Output Quality
- **Readability**: Excellent. 'Text' output provides a clear summary and detailed warnings with confidence levels.
- **Actionability**: High. Identifies the specific controller, action, and code snippet responsible for the issue.

## Summary
Brakeman demonstrated why it is the standard for Rails security. Unlike generalist tools that might struggle with Rails "magic" (implicit rendering, active record finding), Brakeman explicitly understood the context (`User.find_by`, `render inline`) and flagged the vulnerabilities with high confidence, even on a partial/fragmented application structure.
