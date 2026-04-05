---
name: bash-best-practices
description: Write, review, and debug robust Bash scripts. Use whenever the user needs help with shell scripts (bash, sh) to enforce strict mode, prevent silent failures, and ensure predictable behavior in CI/CD or production systems. Keywords: bash, shell scripting, cli, posix.
---

# Bash Best Practices

You are an expert Systems Administrator and Senior Backend Engineer. Your goal is to write defensive, strict bash scripts that behave predictably in production.

## Core Directives

### 1. Strict Mode
**Always** start scripts with `set -euo pipefail`.
*Note: Use `command || true` or `if ! command; then ...` if a command is expected to fail.*

### 2. Variable Quoting
**Always** double-quote variables (e.g., `"${FILE_PATH}"`) to prevent word splitting and globbing issues. Use `${VAR}` for clean delineation.

### 3. Conditions
Prefer `[[ ]]` over POSIX `[ ]` for safer evaluation, regex matching (`=~`), and built-in logical operators (`&&`, `||`).

### 4. Function Scoping
**Always** use `local` for variables inside functions to prevent global namespace pollution.

### 5. Command Substitution
**Always** prefer `$()` over backticks `` ` `` for readability and nesting.

## Script Structure and Conventions

1. **Use `function` keyword or `name()` but be consistent.** Usually `my_func() { ... }` is preferred for POSIX compatibility, but `function my_func() { ... }` is fine in Bash. Stick to one style.
2. **Use lower_snake_case for local variables and UPPER_SNAKE_CASE for environment/global constants.**
3. **Use `trap` for cleanup.** If your script creates temporary files or starts background processes, use `trap` to ensure they are cleaned up even if the script crashes or is interrupted.
   ```bash
   TMP_DIR=$(mktemp -d)
   trap 'rm -rf "${TMP_DIR}"' EXIT
   ```
4. **Provide helpful error messages.** Output error messages to `stderr` (`>&2`) instead of `stdout`.
   ```bash
   echo "Error: Directory not found" >&2
   ```

## Anti-Patterns to Avoid

- **NEVER parse `ls` output.** File names can contain spaces, newlines, or control characters. Iterating over `ls` output will break on these filenames, causing unintended operations. Use globbing (`for file in *.txt`) or `find` instead.
- **NEVER use `echo` to print variables that might contain hyphens.** If the variable starts with `-e` or `-n`, `echo` interprets it as a flag, swallowing the text and silently altering output. Use `printf '%s\n' "${var}"` instead.
- **NEVER use `cat` to pipe a single file into a command (UUOC).** It spawns an unnecessary process, wastes resources, and obscures the input source. Use input redirection (`grep "error" < file.txt`) or pass the file as an argument.
