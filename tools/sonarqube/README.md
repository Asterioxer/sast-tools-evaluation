# SonarQube

## Overview
A widely used open-source platform for continuous inspection of code quality, which includes basic to intermediate security scanning capabilities.

## Detection Approach
Combines pattern matching and data flow analysis to detect bugs, code smells, and security vulnerabilities. Uses Quality Profiles where users can activate/deactivate rules. Supports custom rules via plugins.

## Supported Languages
29+ languages including Java, C#, Python, JavaScript, TypeScript, C++, and Go.

## Strengths
- Great UI/UX, combines quality and security, massive community support, easy setup
- Excellent integration with Jenkins, Azure DevOps, GitLab CI
- IDE integration via SonarLint

## Limitations
- Security analysis is not as deep as specialized SAST tools; higher false negative rate for complex taint analysis

## Ideal Use Case
General-purpose development teams needing a balance of code quality and security.
