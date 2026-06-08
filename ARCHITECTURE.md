# ARCHITECTURE

## Architecture Principles
- Keep the downloader cron-friendly and dependency-light.
- Preserve the last known good catalog on failed downloads.
- Make the output directory configurable so the FTP pickup path can be chosen by deployment.
- Use Dell's HTTP metadata to avoid unnecessary daily rewrites.

## Component Model
- `scripts/download_idrac_catalog.sh`: command-line entry point for cron and manual runs.
- Output directory: stores `Catalog.xml.gz`, `Catalog.xml`, and the saved ETag metadata.
- Downstream FTP service: reads the output files; not managed by this project.

## Data Flow
1. Cron starts `scripts/download_idrac_catalog.sh`.
2. The script creates the configured output directory if needed.
3. A directory lock prevents overlapping runs for the same output directory.
4. The script sends Dell the saved ETag with `If-None-Match` when available.
5. `304 Not Modified` exits without changing files.
6. `200 OK` downloads to temporary files in the output directory.
7. The script validates gzip integrity, decompresses XML, then atomically replaces both catalog files.
8. The saved ETag is updated only after a successful replacement.

## Failure Handling
- Missing required commands produce a non-zero exit code.
- Network, HTTP, gzip, or decompression failures leave existing catalog files untouched.
- Temporary files are removed on exit.
- A stale lock directory may need manual removal if the process is forcibly killed in a way that bypasses shell cleanup.

## Operational Integration Points
- Source URL: `https://downloads.dell.com/catalog/Catalog.xml.gz`.
- Default output directory: `./data`.
- Deployment override: first script argument or `IDRAC_CATALOG_DIR`.
- Optional URL override for testing or emergency use: `IDRAC_CATALOG_URL`.
