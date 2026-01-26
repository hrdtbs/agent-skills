#!/bin/bash
set -e

# Conventional Commit Validator
# Validates commit messages against Conventional Commits specification

COMMIT_MSG="$1"

if [ -z "$COMMIT_MSG" ]; then
    echo "Usage: validate-commit.sh <commit-message>" >&2
    exit 1
fi

# Valid types
TYPES="feat|fix|docs|style|refactor|perf|test|build|ci|chore|revert"

# Pattern: type(optional-scope)optional-!: description
PATTERN="^($TYPES)(\([a-zA-Z0-9_-]+\))?\!?: .+"

# Extract first line (header)
HEADER=$(echo "$COMMIT_MSG" | head -n 1)

# Validate header
if ! echo "$HEADER" | grep -Eq "$PATTERN"; then
    echo "ERROR: Invalid commit message format" >&2
    echo "" >&2
    echo "Expected format: <type>[scope][!]: <description>" >&2
    echo "" >&2
    echo "Valid types: feat, fix, docs, style, refactor, perf, test, build, ci, chore, revert" >&2
    echo "" >&2
    echo "Examples:" >&2
    echo "  feat: add user authentication" >&2
    echo "  fix(api): resolve timeout issue" >&2
    echo "  feat(auth)!: change login flow" >&2
    echo "" >&2
    echo "Your message: $HEADER" >&2
    exit 1
fi

# Check description length (should be reasonable, not too long)
DESCRIPTION=$(echo "$HEADER" | sed -E "s/^($TYPES)(\([a-zA-Z0-9_-]+\))?\!?: //")
DESC_LENGTH=${#DESCRIPTION}

if [ $DESC_LENGTH -gt 100 ]; then
    echo "WARNING: Description is longer than 100 characters ($DESC_LENGTH chars)" >&2
    echo "Consider moving details to the body" >&2
fi

# Check for empty description
if [ -z "$DESCRIPTION" ] || [ "$DESCRIPTION" = " " ]; then
    echo "ERROR: Description cannot be empty" >&2
    exit 1
fi

# Extract type for output
TYPE=$(echo "$HEADER" | sed -E "s/^($TYPES).*/\1/")

# Output result as JSON
echo "{"
echo "  \"valid\": true,"
echo "  \"type\": \"$TYPE\","
echo "  \"header\": \"$HEADER\""
echo "}"
