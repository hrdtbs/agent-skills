#!/bin/bash
set -e

# Detect environment and output JSON
echo "Detecting environment..." >&2

if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
    echo '{"environment": "git-bash", "os_type": "msys", "message": "Running in Git Bash / MSYS."}'
elif grep -q Microsoft /proc/version 2>/dev/null; then
    echo '{"environment": "wsl", "os_type": "linux-gnu", "message": "Running in WSL."}'
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo '{"environment": "linux", "os_type": "linux-gnu", "message": "Running in Linux."}'
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo '{"environment": "macos", "os_type": "darwin", "message": "Running in macOS."}'
else
    echo '{"environment": "unknown", "os_type": "unknown", "message": "Unknown environment."}'
fi
