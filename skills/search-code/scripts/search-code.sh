#!/bin/bash
set -e

PATTERN="$1"
SEARCH_PATH="${2:-.}"

if [ -z "$PATTERN" ]; then
  echo "Error: Search pattern is required." >&2
  exit 1
fi

if [ ! -e "$SEARCH_PATH" ]; then
  echo "Error: Path '$SEARCH_PATH' does not exist." >&2
  exit 1
fi

TMP_FILE=$(mktemp)
trap 'rm -f "$TMP_FILE"' EXIT

# Run grep. If it returns 0 (found) or 1 (not found), we handle it.
# If it returns >1 (error), we let set -e fail the script? No, we want to catch it.
set +e
grep -rHnIZ --exclude-dir={node_modules,.git,dist,build,coverage} -e "$PATTERN" "$SEARCH_PATH" > "$TMP_FILE"
GREP_EXIT_CODE=$?
set -e

if [ $GREP_EXIT_CODE -eq 0 ]; then
  # Matches found
  # Use jq to format. We read from TMP_FILE.
  # We construct JSON array.
  # We use split("\u0000") to separate filename from line:content (grep -Z output).
  # Then we split the rest by colon to separate line number from content.
  # We use tonumber? to safely convert line number, though it should be numeric.
  jq -R -s 'split("\n") | map(select(length > 0)) | map(split("\u0000")) | map({file: .[0], rest: (.[1]|split(":"))}) | map({file: .file, line: (.rest[0]|tonumber), content: (.rest[1:]|join(":"))})' "$TMP_FILE"
elif [ $GREP_EXIT_CODE -eq 1 ]; then
  # No matches found
  echo "[]"
else
  # Error
  echo "Error running grep. Exit code: $GREP_EXIT_CODE" >&2
  exit $GREP_EXIT_CODE
fi
