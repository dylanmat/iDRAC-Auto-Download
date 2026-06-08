# STANDARDS

## Coding Standards
- Python: 4-space indentation, type hints on public APIs, clear naming.
- Use `snake_case` for modules/functions, `PascalCase` for classes, `UPPER_SNAKE_CASE` for constants.
- Keep provider-specific logic behind clear interfaces.

## Testing Standards
- Use deterministic tests where practical (fixed seeds, stable fixtures, mocked provider calls).
- Separate unit/integration tests from slower `evals/` runs.
- Add regression tests for prompt, parser, and safety-critical behavior changes.

## Documentation Standards
- Keep root baseline docs current: `CONTEXT.md`, `README.md`, `ARCHITECTURE.md`, `SECURITY.md`, `STANDARDS.md`, `DECISIONS.md`, `ROADMAP.md`, `CHANGELOG.md`.
- Keep `README.md` high-level; place deep technical detail in the dedicated doc.
- Record major technical and product decisions in `DECISIONS.md`.

## Frontend Standards
For plain `html/css/js`, prefer Bootstrap before custom CSS.

## Review Standards
- PRs require passing tests/lint and clear change rationale.
- Include impact notes when AI behavior, prompts, or eval outcomes change.
- Link changed code to updated docs when conventions or behavior change.

## Operational Standards
- Use structured logging; avoid logging sensitive content.
- Define basic run/rollback expectations for production-impacting changes.
- Track critical dependencies and provider configuration changes in PRs.

## AI-Specific Standards
- Version prompts intentionally (for example `feature_name.v2.md`).
- Validate behavior with targeted evals before merge.
- Document provider fallback assumptions and output validation rules.
