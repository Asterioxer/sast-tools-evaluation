# SAST Standardization & Enforcement Mapping

This document defines how different Static Application Security Testing (SAST) tools are
strategically positioned within the software development lifecycle (SDLC) to balance
security depth, developer experience, and pipeline performance.

---

## Enforcement Philosophy

Not all SAST tools serve the same purpose. Effective DevSecOps requires a layered approach:

- Fast, lightweight tools provide immediate developer feedback
- Deep analysis tools enforce security at controlled pipeline stages
- Enterprise tools act as release gates and compliance validators

---

## Tool-to-Pipeline Mapping

### 1. Pre-Commit / Local Development
**Objective:** Immediate feedback, zero friction

**Tools:**
- Semgrep
- ESLint Security
- Bandit
- Brakeman

**Enforcement Level:** Informational

**Rationale:**  
These tools run in seconds and integrate easily with local workflows, preventing basic
security issues from reaching version control.

---

### 2. Pull Request (PR) Stage
**Objective:** Prevent vulnerable code from being merged

**Tools:**
- Semgrep
- SonarQube

**Enforcement Level:** Warning or Blocking (severity-based)

**Rationale:**  
PR-level enforcement ensures that security findings are visible, reviewable, and actionable
before code enters the main branch.

---

### 3. CI Build Stage
**Objective:** Baseline security assurance

**Tools:**
- SonarQube
- CodeQL

**Enforcement Level:** Blocking for high and critical issues

**Rationale:**  
At this stage, deeper analysis is acceptable, and findings can be used to enforce quality
gates without slowing individual developers.

---

### 4. Nightly / Scheduled Scans
**Objective:** Deep security analysis and compliance

**Tools:**
- Checkmarx
- Veracode
- Fortify
- Coverity
- Klocwork

**Enforcement Level:** Blocking (Release Gate)

**Rationale:**  
These tools perform resource-intensive analysis and are best suited for scheduled scans,
release validation, and compliance reporting.

---

## Integration with Infrastructure SAST Standardization

This mapping aligns directly with the enforcement mechanisms defined in the
[`infrastructure-sast-standardization`](https://github.com/Asterioxer/infrastructure-sast-standardization) repository.

That repository focuses on **how** SAST is enforced, while this project defines **why**
specific tools are chosen and **where** they are applied within the pipeline.

Together, both repositories form a complete SAST governance and implementation model.
