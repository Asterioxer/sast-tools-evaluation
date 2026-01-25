# Bandit

## Overview
A tool designed specifically to find common security issues in Python code.

## Detection Approach
AST-based static analysis that processes each file to build an AST and runs plugins against it. Configurable through profiles and exclusion lists (baseline).

## Supported Languages
Python only.

## Strengths
- Lightweight, Python-native, easy to use, free and open source
- Integrates easily into tox, pre-commit, and CI pipelines

## Limitations
- Limited to Python; relatively simple analysis (no deep taint tracking)

## Ideal Use Case
Python projects needing a quick, baseline security check.
