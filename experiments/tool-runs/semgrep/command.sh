docker run --rm -v "${PWD}:/src" returntocorp/semgrep semgrep scan --config=auto /src/experiments/vulnerable-apps --json > output.json
