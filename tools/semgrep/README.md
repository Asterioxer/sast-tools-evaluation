# Semgrep

## Overview
Semgrep is a modern, lightweight static analysis tool designed to provide fast and developer-friendly security feedback by scanning source code without requiring compilation.

## Detection Approach
Semgrep uses syntactic pattern matching that resembles source code. Rules are written in YAML and matched against Abstract Syntax Trees (ASTs), allowing precise pattern detection.

## Supported Languages
Go, Java, JavaScript, TypeScript, Python, Ruby, JSON, Terraform, and others.

## Strengths
- Extremely fast execution
- Open-source core
- Easy-to-write custom rules
- Excellent CI/CD and pre-commit support

## Limitations
- Limited deep data flow analysis compared to enterprise tools
- Complex logic flaws may require Semgrep Pro

## Ideal Use Case
Modern DevSecOps pipelines requiring fast, shift-left security feedback during pull requests and CI builds.
