# CONTEXT

## System Purpose
iDRAC Auto Download keeps Dell's published iDRAC catalog available locally in both compressed and decompressed forms. The local files are intended to be picked up by a Dell server via FTP on its own schedule.

## Users & Stakeholders
- Primary user: operator responsible for keeping the local iDRAC catalog current.
- Technical owner: server administrator maintaining the Ubuntu cron job and FTP-served directory.
- External dependency: Dell's public catalog endpoint at `https://downloads.dell.com/catalog/Catalog.xml.gz`.

## Operational Context
- Runtime environment: Ubuntu server running a daily cron job.
- Integration point: public HTTPS download from Dell.
- Downstream consumer: FTP service or Dell server that reads the generated catalog files.
- Technical constraints: no application server, database, credentials, or Python runtime should be required.

## Domain Vocabulary
- Catalog: Dell's XML metadata file for firmware/software inventory.
- Compressed catalog: `Catalog.xml.gz`.
- Decompressed catalog: `Catalog.xml`.
- ETag: HTTP response metadata used to check whether Dell's remote file changed.

## Current State
- A Bash script downloads and validates the catalog.
- Root documentation describes operation, security, standards, and release history.
- FTP publishing is intentionally outside this repository.

## Success Signals
- Daily cron runs exit successfully.
- New Dell catalog releases replace both local files.
- Unchanged Dell catalog responses do not rewrite local files.
- Failed or corrupt downloads do not replace the last known good files.

## Guardrails
- Do not commit downloaded catalog files unless explicitly required later.
- Do not add credentials or FTP secrets to this repository.
- Validate gzip content before replacing local files.
- Keep compressed and decompressed files from the same successful download.

## Pointers
- High-level usage: `README.md`
- System design/details: `ARCHITECTURE.md`
- Security expectations: `SECURITY.md`
- Coding/testing/review conventions: `STANDARDS.md`
- Decision history: `DECISIONS.md`
