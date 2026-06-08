# ROADMAP

## Purpose
Track project development priorities, sequencing, and delivery status.

## Now
### Baseline Template Hardening
- Goal: finalize required root documentation and workflow consistency.
- Status: In Progress
- Owner: Project Maintainers
- Dependencies: None
- Target Window: Current sprint
- Success Criteria: All required docs exist with aligned ownership and update triggers.
- Links: `AGENTS.md`, `CONTEXT.md`, `ARCHITECTURE.md`, `SECURITY.md`, `STANDARDS.md`

### Quality Automation Foundation
- Goal: add CI checks for lint and tests.
- Status: Planned
- Owner: Project Maintainers
- Dependencies: baseline scripts and test entry points
- Target Window: Next sprint
- Success Criteria: CI runs `ruff check` and `pytest` on pull requests.
- Links: `STANDARDS.md`, `CHANGELOG.md`

## Next
### Evaluation Harness
- Goal: provide reusable eval execution and reporting baseline.
- Status: Planned
- Owner: Project Maintainers
- Dependencies: stable prompt/versioning conventions
- Target Window: Near term
- Success Criteria: template includes eval runner pattern and result reporting guidance.
- Links: `ARCHITECTURE.md`, `STANDARDS.md`

### Deployment and Runbook Baseline
- Goal: define deployment/runbook scaffolding for downstream projects.
- Status: Planned
- Owner: Project Maintainers
- Dependencies: quality automation foundation
- Target Window: Near term
- Success Criteria: templates include runbook expectations and operational handoff guidance.
- Links: `SECURITY.md`, `STANDARDS.md`

## Later
### Project Scaffolding Automation
- Goal: automate setup for new projects from this template.
- Status: Planned
- Owner: Project Maintainers
- Dependencies: stable documentation and workflow contract
- Target Window: Longer term
- Success Criteria: one-command bootstrap for docs, structure, and baseline scripts.
- Links: `README.md`, `AGENTS.md`, `CHANGELOG.md`
