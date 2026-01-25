# Brakeman

## Overview
A static analysis tool which checks Ruby on Rails applications for security vulnerabilities.

## Detection Approach
Scans the Rails application flow to identify dangerous method calls and mass assignment issues. Specific checks for Rails versions; allows ignoring false positives via configuration files.

## Supported Languages
Ruby on Rails.

## Strengths
- Zero-configuration; specialized knowledge of Rails internals; very fast
- Fast enough to run on every commit

## Limitations
- Limited to Ruby on Rails; cannot scan generic Ruby scripts effectively

## Ideal Use Case
Any Ruby on Rails web application.
