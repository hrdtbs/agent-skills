#!/bin/bash
set -e

# Check if gh is installed
if ! command -v gh &> /dev/null; then
    echo "Error: gh command not found. Please install GitHub CLI." >&2
    exit 1
fi

# Execute gh with provided arguments
gh "$@"
