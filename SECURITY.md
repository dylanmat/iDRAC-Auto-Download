# SECURITY

## Security Scope and Ownership
This policy covers the catalog downloader script, its documentation, and the files it creates. The server administrator owns deployment security, cron configuration, filesystem permissions, and downstream FTP exposure.

## Credential Handling Policy
- The downloader does not require credentials.
- Do not add FTP usernames, passwords, API keys, or private tokens to this repository.
- If downstream FTP requires credentials, store and manage them in the FTP service configuration, not in this project.

## Data Access and Classification Policy
- Dell's catalog is public data downloaded from a public HTTPS endpoint.
- Local output files may become operationally sensitive if the FTP directory layout exposes internal server details; limit directory permissions accordingly.
- Logs should include operational status only and should not include secrets or private infrastructure details.

## Environment and Deployment Controls
- Run the cron job as a least-privilege user that can write only to the intended output directory and log destination.
- Serve only the intended catalog directory through FTP.
- Keep the script and cron entry under normal change control.
- Monitor failures through cron mail, log review, or existing server monitoring.

## Supply Chain and Network Controls
- Download only from Dell's HTTPS catalog URL unless a documented operational exception is needed.
- Keep system packages such as `curl` and `gzip` updated through the server's normal patching process.
- Failed validation must not replace the last known good catalog files.

## Incident Reporting and Response
- Treat repeated download failures, unexpected output changes, or unauthorized FTP exposure as operational incidents.
- Remove any exposed secrets from logs or documentation immediately and rotate affected credentials outside this repo.
