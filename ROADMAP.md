# ROADMAP

## Purpose
Track operational improvements for the iDRAC catalog downloader.

## Now
### Initial Cron Downloader
- Goal: provide a Bash script that keeps compressed and decompressed Dell catalog files current.
- Status: Complete
- Owner: Project Maintainers
- Dependencies: Dell public catalog endpoint
- Success Criteria: Script downloads, validates, decompresses, and atomically replaces catalog files only when the remote ETag changes.
- Links: `README.md`, `ARCHITECTURE.md`, `scripts/download_idrac_catalog.sh`

### Documentation Alignment
- Goal: replace template documentation with project-specific operating guidance.
- Status: Complete
- Owner: Project Maintainers
- Dependencies: Initial downloader scope
- Success Criteria: Root docs describe purpose, security boundaries, standards, architecture, and release history.
- Links: `README.md`, `CONTEXT.md`, `SECURITY.md`, `STANDARDS.md`, `CHANGELOG.md`

## Next
### Deployment Validation
- Goal: validate the cron entry and output directory permissions on the Ubuntu server.
- Status: Planned
- Owner: Server Administrator
- Dependencies: target FTP-served directory
- Success Criteria: Daily cron run succeeds and downstream FTP pickup sees both catalog files.

## Later
### Optional Monitoring
- Goal: add lightweight alerting for repeated cron failures or stale catalog age.
- Status: Backlog
- Owner: Server Administrator
- Dependencies: existing monitoring or log collection
- Success Criteria: Operators are notified when the catalog has not updated or checked in as expected.
