#!/usr/bin/env bash
set -Eeuo pipefail

CATALOG_URL="${IDRAC_CATALOG_URL:-https://downloads.dell.com/catalog/Catalog.xml.gz}"
OUTPUT_DIR="${1:-${IDRAC_CATALOG_DIR:-./data}}"

GZ_FILE="${OUTPUT_DIR}/Catalog.xml.gz"
XML_FILE="${OUTPUT_DIR}/Catalog.xml"
ETAG_FILE="${OUTPUT_DIR}/Catalog.xml.gz.etag"
LOCK_DIR="${OUTPUT_DIR}/.download_idrac_catalog.lock"

log() {
  printf '%s %s\n' "$(date -u '+%Y-%m-%dT%H:%M:%SZ')" "$*"
}

cleanup() {
  local exit_code=$?
  rm -f "${TMP_GZ:-}" "${TMP_XML:-}" "${TMP_HEADERS:-}"
  if [[ "${LOCK_HELD:-0}" == "1" ]]; then
    rmdir "$LOCK_DIR" 2>/dev/null || true
  fi
  exit "$exit_code"
}
trap cleanup EXIT

require_command() {
  if ! command -v "$1" >/dev/null 2>&1; then
    log "missing required command: $1"
    exit 127
  fi
}

require_command curl
require_command gzip
require_command mktemp

mkdir -p "$OUTPUT_DIR"

if ! mkdir "$LOCK_DIR" 2>/dev/null; then
  log "another download run is already active for ${OUTPUT_DIR}"
  exit 0
fi
LOCK_HELD=1

TMP_GZ="$(mktemp "${OUTPUT_DIR}/Catalog.xml.gz.tmp.XXXXXX")"
TMP_XML="$(mktemp "${OUTPUT_DIR}/Catalog.xml.tmp.XXXXXX")"
TMP_HEADERS="$(mktemp "${OUTPUT_DIR}/Catalog.headers.tmp.XXXXXX")"

CURL_ARGS=(
  --location
  --silent
  --show-error
  --fail-with-body
  --dump-header "$TMP_HEADERS"
  --output "$TMP_GZ"
  --write-out '%{http_code}'
)

if [[ -s "$ETAG_FILE" ]]; then
  SAVED_ETAG="$(<"$ETAG_FILE")"
  if [[ -n "$SAVED_ETAG" ]]; then
    CURL_ARGS+=(--header "If-None-Match: ${SAVED_ETAG}")
  fi
fi

log "checking ${CATALOG_URL}"
HTTP_CODE="$(curl "${CURL_ARGS[@]}" "$CATALOG_URL")"

if [[ "$HTTP_CODE" == "304" ]]; then
  log "catalog has not changed"
  exit 0
fi

if [[ "$HTTP_CODE" != "200" ]]; then
  log "unexpected HTTP status: ${HTTP_CODE}"
  exit 1
fi

gzip -t "$TMP_GZ"
gzip -dc "$TMP_GZ" > "$TMP_XML"

mv -f "$TMP_GZ" "$GZ_FILE"
TMP_GZ=""
mv -f "$TMP_XML" "$XML_FILE"
TMP_XML=""

NEW_ETAG="$(grep -i '^etag:' "$TMP_HEADERS" | tail -n 1 | sed -e 's/^[Ee][Tt][Aa][Gg]:[[:space:]]*//' -e 's/[[:space:]]*$//' -e $'s/\r$//' || true)"
if [[ -n "$NEW_ETAG" ]]; then
  printf '%s\n' "$NEW_ETAG" > "$ETAG_FILE"
else
  log "download succeeded, but no ETag was returned; next run will download again"
  rm -f "$ETAG_FILE"
fi

log "updated ${GZ_FILE} and ${XML_FILE}"
