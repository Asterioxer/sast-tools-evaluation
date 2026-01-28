# SAST Evaluation and Implementation

This repository provides a comprehensive, structured evaluation of Static Application
Security Testing (SAST) tools and demonstrates how they are integrated into standardized
DevSecOps workflows.

It combines:
- Academic-grade tool evaluation
- Practical Linux-based usage
- CI/CD workflow examples
- SAST enforcement standardization

This project serves as a reference architecture for organizations adopting SAST at scale.

---

## Scope

The repository covers the full SAST lifecycle:
- Tool evaluation and comparison
- Tool-specific usage and commands
- CI/CD workflow integration
- Pipeline enforcement strategy
- SDLC placement and governance

---

## Tools Covered

Developer-centric and open-source tools:
- Semgrep
- Trivy (Container Security)

Each tool is documented using a standardized structure to ensure consistency and
comparability.

---

## Repository Structure

docs/report/  
→ Official submitted SAST evaluation report  

tools/  
→ Tool-level documentation, commands, and integration rationale  

workflows/  
→ Reference CI/CD pipelines demonstrating SAST execution  

references/  
→ SAST standardization and enforcement mappings  

---

## SAST Standardization Model

This repository defines **why** and **where** each SAST tool is used within the SDLC.

Implementation-level enforcement is handled in the companion repository:

🔗 [infrastructure-sast-standardization](https://github.com/Asterioxer/infrastructure-sast-standardization)

That repository focuses on **how** SAST is enforced at the infrastructure and pipeline
level, while this project focuses on **evaluation, selection rationale, and usage guidance**.

Together, both repositories form a complete SAST governance and implementation framework.

---

## How to Navigate This Repository

1. Start with the evaluation report  
   `docs/report/SAST_Tools_Evaluation_Report.pdf`

2. Explore individual tools  
   `tools/<tool-name>/`

3. Review CI/CD reference workflows  
   `workflows/ci-sast-examples/` (includes GitHub Actions `.yml` and Nomad `.hcl`)

4. Understand enforcement strategy  
   `references/sast-standardization-mapping.md`

5. Explore Tool Implementation Demo  
   `demo/` (contains vulnerable code, configs, and tool outputs)

---

## Intended Audience

- Security engineers
- DevSecOps engineers
- Platform teams
- Security-focused interns and researchers

---

## Status

This repository represents a **completed reference implementation** and may be extended
to include DAST, SCA, and secrets scanning in future iterations.
