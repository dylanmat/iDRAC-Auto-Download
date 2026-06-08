# STANDARDS

## Coding Standards
- Use Bash for the downloader unless project scope grows beyond a simple cron utility.
- Keep scripts compatible with standard Ubuntu command-line tools.
- Use clear variable names and quote paths because output directories may contain spaces.
- Prefer atomic replacement of generated files over in-place writes.
- Keep downloaded catalog files out of source control unless an explicit fixture is needed later.

## Testing Standards
- Run `bash -n scripts/download_idrac_catalog.sh` after script changes.
- Test successful downloads against a temporary directory before deploying cron changes.
- Verify repeated runs handle unchanged remote metadata without rewriting files.
- Review failure behavior for network errors and invalid gzip data so existing files remain untouched.
- Use `shellcheck` when available, but do not require it for routine operation.

## Documentation Standards
- Keep root docs current when behavior, deployment assumptions, or operational responsibilities change.
- Record major implementation choices in `DECISIONS.md`.
- Keep `README.md` focused on operator usage.
- Put deeper data-flow and failure-mode details in `ARCHITECTURE.md`.

## Review Standards
- Changes should include a summary, rationale, and verification evidence.
- Reviewers should prioritize file replacement safety, cron behavior, logging clarity, and security boundaries.
- Documentation should be updated with code changes that affect operation.

## Operational Standards
- Run via cron as a least-privilege user.
- Redirect cron output to a monitored log destination or rely on cron mail.
- Keep the output directory writable by the cron user and readable by the FTP service.
- Roll back by restoring the previous script version; existing catalog files are preserved across failed runs.
