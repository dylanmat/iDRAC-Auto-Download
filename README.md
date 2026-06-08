# iDRAC Auto Download

## Overview
This project provides a small Ubuntu cron utility that keeps a local copy of Dell's iDRAC catalog current.

The script checks `https://downloads.dell.com/catalog/Catalog.xml.gz` using HTTP ETag metadata. When Dell publishes a new catalog, it downloads the compressed file, validates it, writes the decompressed XML, and atomically replaces the local files.

## Output Files
By default, files are written to `./data`:

- `Catalog.xml.gz`: compressed Dell catalog
- `Catalog.xml`: decompressed Dell catalog
- `Catalog.xml.gz.etag`: saved HTTP ETag used to detect updates

The output directory can be set with the first script argument or `IDRAC_CATALOG_DIR`.

## Requirements
Target runtime is Ubuntu with standard command-line tools:

- `bash`
- `curl`
- `gzip`
- `mktemp`
- GNU coreutils

No credentials are required. FTP pickup is handled outside this project by the Dell server or FTP service that reads the output directory.

## Usage
Run with the default `./data` output directory:

```bash
./scripts/download_idrac_catalog.sh
```

Run with an explicit FTP-served directory:

```bash
./scripts/download_idrac_catalog.sh /srv/ftp/idrac-catalog
```

Run with environment overrides:

```bash
IDRAC_CATALOG_DIR=/srv/ftp/idrac-catalog ./scripts/download_idrac_catalog.sh
```

## Cron Example
Run daily at 2:15 AM and append logs to `/var/log/idrac-catalog-download.log`:

```cron
15 2 * * * /opt/idrac-auto-download/scripts/download_idrac_catalog.sh /srv/ftp/idrac-catalog >> /var/log/idrac-catalog-download.log 2>&1
```

## Verification
Syntax check:

```bash
bash -n scripts/download_idrac_catalog.sh
```

Functional check against a temporary directory:

```bash
tmpdir="$(mktemp -d)"
./scripts/download_idrac_catalog.sh "$tmpdir"
ls -lh "$tmpdir"/Catalog.xml.gz "$tmpdir"/Catalog.xml
```

## Documentation Map
- System context and goals: `CONTEXT.md`
- Architecture and data flow: `ARCHITECTURE.md`
- Security expectations: `SECURITY.md`
- Coding/testing/review standards: `STANDARDS.md`
- Decision history: `DECISIONS.md`
- Planned work: `ROADMAP.md`
- Release notes: `CHANGELOG.md`
