# SECURITY

## Security Scope and Ownership
- Define who owns security decisions and policy maintenance.
- State which environments, services, and contributors this policy covers.

## Credential Handling Policy
- Store secrets only in approved secret stores or local `.env` files (never commit credentials).
- Use least-privilege credentials and separate keys by environment.
- Rotate credentials on schedule and immediately after suspected exposure.
- Do not place tokens, API keys, or private credentials in logs, prompts, screenshots, or tickets.

## Data Access and Classification Policy
- Define data classes (public, internal, sensitive, restricted) and handling rules for each.
- Grant data access by role and minimum required scope.
- Restrict direct production data access; prefer audited access paths.
- Define retention/deletion expectations for logs, prompts, and model outputs.

## AI Restrictions and Safety Boundaries
- Define disallowed AI use cases and prohibited output categories.
- Define allowed model/provider list and escalation path for exceptions.
- Require validation/guardrails for model outputs before high-impact actions.
- Define when human review is mandatory (for example legal, financial, safety-critical outputs).

## Environment and Deployment Controls
- Separate dev/stage/prod credentials, data, and access controls.
- Require auditable change history for security-sensitive configuration.
- Document baseline controls for network access, dependency updates, and runtime hardening.

## Incident Reporting and Response
- Define vulnerability reporting channel and response ownership.
- Define triage priorities and containment expectations.
- Document communication and remediation follow-up requirements.

## Compliance Notes
List applicable regulatory, contractual, or internal compliance requirements.
