# SAST Tool Comparison & Recommendation

## Executive Summary

For a **containerized, Nomad-based infrastructure** prioritizing lightweight integration and customizability, validating security early in the pipeline:

- **Primary Recommendation**: **Semgrep** (for Source Code) + **Trivy** (for Containers & Dependencies).
- **Secondary Option**: **SonarQube** (only if "Quality" metrics and dashboards are a higher priority than raw security speed/flexibility).

**Why?**
- **Semgrep** fits perfectly into stateless Nomad jobs, requires no central server, and allows writing custom rules for your specific environment (e.g., specific Vault usage patterns) in minutes.
- **Trivy** handles what Semgrep detects less well: Common Vulnerabilities and Exposures (CVEs) in OS packages and language dependencies, plus it scans the actual Docker images you deploy to Nomad.
- **SonarQube** requires maintaining a stateful server/database, which adds operational overhead. Its security analysis in the "Community" edition is significantly weaker than Semgrep's default ruleset.

---

## Tool Analysis

### 1. Semgrep
* **Type**: SAST (Static Analysis source-focused).
* **Strengths**:
    *   **Rule Engine**: Developer-friendly syntax. You can write a rule to find "insecure function calls" looking like code.
    *   **Nomad Fit**: Excellent. Runs as a single binary/container. No sidecars or databases needed.
    *   **Integration**: Outputs JSON/SARIF. Easy to ingest into any reporting tool.
*   **Weaknesses**:
    *   **Pro Features**: Deep taint analysis (tracking data across files) is locked behind the paid "Team" tier.
    *   **Secrets**: Default secret detection is okay, but dedicated tools (like TruffleHog) or paid Semgrep Pro are better.
*   **Vault Compatibility**: Can scan for hardcoded secrets. Does not integrate *with* Vault, but runs securely in CI environments where Vault injects secrets.

### 2. SonarQube
* **Type**: Code Quality & SAST.
* **Strengths**:
    *   **Dashboard**: Best-in-class GUI for tracking technical debt and trends over time.
    *   **Quality Gates**: Enforce "clean code" standards before merging.
*   **Weaknesses**:
    *   **Infrastructure Heavy**: Requires a hosting Server (Java) + Database (PostgreSQL). Harder to maintain in a "lightweight" Nomad setup.
    *   **False Negatives**: The Free edition lacks "Taint Analysis" (tracking data flow from user input to DB), detecting far fewer injection flaws than Semgrep/Brakeman.
    *   **Nomad Fit**: Requires running a dedicated `sonar-scanner` container that talks to the central server.

### 3. Trivy
* **Type**: Universal Scanner (SCA, Container, filesystem, IaC).
* **Strengths**:
    *   **Versatility**: Scans source code, binaries, container images, and Terraform/Nomad HCL files.
    *   **Private Registries**: Native support for auth via Docker config or env vars.
    *   **Nomad Fit**: Perfect. Can scan the image *before* the job starts or within the pipeline.
*   **Weaknesses**:
    *   **Code SAST**: Its purely code-based analysis (finding logic bugs) is newer and less mature than Semgrep.

---

## Comparison Matrix

| Feature | Semgrep | SonarQube (Community) | Trivy |
| :--- | :--- | :--- | :--- |
| **Primary Use Case** | Code Logic & Security Patterns | Code Quality & Tech Debt | Vulnerabilities (CVEs) & Images |
| **Nomad Integration** | **Native** (Stateless Job) | **Complex** (Scanner + Server) | **Native** (Stateless Job) |
| **Operational Cost** | Low (Binary only) | High (Server + DB maintenance) | Low (Binary only) |
| **Custom Rules** | **Easy** (YAML, code-like) | Difficult (Java/Plugin Application) | Medium (Rego policy) |
| **Private Registry** | N/A (Source scan) | N/A (Source scan) | **Excellent** (Built-in auth) |
| **Vault Compatible** | Yes (Env var config) | Yes (Token auth) | Yes (Env var auth) |
| **False Positives** | Low (customizable) | Medium | Low (CVE matching) |
| **License** | LGPL (Engine) / Proprietary (Pro) | LGPL (Community) / Commercial | Apache 2.0 |

---

## Detailed Recommendation

### Phase 1: The "Guardrails" (Immediate Value)
Implement **Semgrep** and **Trivy** in your Nomad CI/CD pipelines.

1.  **Semgrep Job**:
    *   Run on every Pull Request.
    *   Block on High severity security issues.
    *   Use the `p/default` and `p/security-audit` rulesets.
    *   *Why?* It stops bad code from hitting `main`.

2.  **Trivy Job**:
    *   Run on the built Docker image before pushing to the registry.
    *   Scan for OS vulnerabilities (CVEs) and secret leakage in layers.
    *   *Why?* It ensures the artifact itself is safe to run.

### Phase 2: Code Quality (Optional)
If the team misses a "Dashboard" to track code smell trends, deploy **SonarQube** as a persistent service on Nomad.
*   *Note*: Do not rely on it for blocking security vulnerabilities unless you pay for the Developer Edition. Use it purely for "Code Health" monitoring.
