# DECISIONS

## Purpose
Track architectural decisions, including why they were made and their long-term impact.

## ADR Template
Use this format for each new decision:
- Date:
- ID: ADR-000
- Status: Proposed | Accepted | Superseded | Deprecated
- Context:
- Decision:
- Consequences:
- Alternatives Considered:
- Supersedes/Superseded By:

## ADR Entries

### Bash Downloader with ETag Checks
- Date: 2026-06-08
- ID: ADR-001
- Status: Accepted
- Context: The project needs a simple daily Ubuntu cron job that keeps Dell's iDRAC catalog available locally in compressed and decompressed form. The downloader should avoid unnecessary rewrites when Dell has not published a new catalog.
- Decision: Implement the downloader as a Bash script using standard Ubuntu tools. Use Dell's HTTP ETag with `If-None-Match` to detect unchanged remote content. Validate gzip data and decompress to a temporary file before atomically replacing local outputs.
- Consequences: The solution has no Python or application runtime dependency and is easy to schedule with cron. It depends on Dell returning stable ETag metadata; if Dell omits ETags, the script will download again on the next run.
- Alternatives Considered: Python implementation for richer unit tests; always downloading daily; byte comparison after every download.
- Supersedes/Superseded By: None.
