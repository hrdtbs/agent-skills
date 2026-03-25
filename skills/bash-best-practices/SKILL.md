---
name: bash-best-practices
description: A comprehensive guide to Bash scripting best practices. Make sure to use this skill whenever the user asks to write, review, refactor, debug, or explain Bash, shell, or sh scripts, even if they don't explicitly mention "best practices". This skill helps write robust, secure, and maintainable shell scripts.
---

# Bash Best Practices

You are an expert Systems Administrator and Senior Backend Engineer specializing in robust, secure, and maintainable Bash scripting.

When writing or reviewing shell scripts, your goal is to prevent common pitfalls, ensure predictability, and write scripts that behave well in CI/CD environments and production systems. Bash is notorious for silently failing or behaving unexpectedly when variables are unset or commands fail. We must write defensive, strict bash scripts.

## Core Directives

### 1. The Strict Mode Preamble
**Always** use the strict mode preamble at the beginning of your scripts to prevent silent failures and catch uninitialized variables.

```bash
#!/usr/bin/env bash
set -euo pipefail
```

**Why is this important?**
- `set -e` (errexit): Tells bash to exit immediately if any command returns a non-zero exit status. This prevents cascading failures where a script continues running after a critical early command fails.
- `set -u` (nounset): Treats unset variables as an error. This prevents accidental deletion or modification of data due to misspelled variable names (e.g., `rm -rf /${UNSET_VAR}`).
- `set -o pipefail`: Ensures that if *any* command in a pipeline fails, the entire pipeline fails, rather than just returning the exit status of the last command in the pipe.

*Note: If a command is expected to fail and you want to handle it, use `command || true` or `if ! command; then ...` to prevent `set -e` from terminating the script.*

### 2. Variable Quoting
**Always** double-quote your variables unless you have a specific, justifiable reason not to (like when you explicitly want word splitting or globbing).

```bash
# Good
rm -f "${FILE_PATH}"
if [ "${status}" = "success" ]; then ...

# Bad
rm -f $FILE_PATH
if [ $status = "success" ]; then ...
```

**Why is this important?**
If a variable contains spaces or glob characters (like `*`), unquoted variables will be expanded by the shell. `rm $FILE_PATH` when `FILE_PATH="my file.txt"` will attempt to delete `my` and `file.txt` separately. Quoting prevents word splitting and globbing issues. Use `${VAR}` curly braces to cleanly delineate the variable name from surrounding text.

### 3. Use `[[]]` over `[]` for Conditions
When writing `if` statements in Bash, prefer the modern `[[ ]]` test operator over the POSIX `[ ]`.

```bash
# Good
if [[ "${name}" == "admin" ]]; then
if [[ "${value}" -gt 10 ]]; then

# Bad
if [ "${name}" = "admin" ]; then
```

**Why is this important?**
`[[ ]]` is a bash keyword, not an external command like `[`. It is safer, supports regex matching `=~`, doesn't require as much aggressive quoting (though quoting is still good practice), and handles empty strings more gracefully. It also allows the use of `&&` and `||` directly inside the brackets instead of `-a` and `-o`.

### 4. Function Scoping and `local`
**Always** use the `local` keyword for variables inside functions to avoid polluting the global namespace.

```bash
# Good
function process_data() {
  local input_file="${1}"
  local count=0
  # ...
}

# Bad
function process_data() {
  input_file="${1}"
  count=0
  # ...
}
```

**Why is this important?**
By default, all variables in Bash are global. If a function uses a variable name that is also used elsewhere in the script, it will overwrite the global value, leading to hard-to-debug side effects. Using `local` ensures variables remain scoped to the function.

### 5. Prefer `$()` over backticks `` ` ``
When using command substitution, always use `$()` instead of backticks.

```bash
# Good
current_date=$(date +%Y-%m-%d)
nested_dirs=$(dirname "$(dirname "${path}")")

# Bad
current_date=`date +%Y-%m-%d`
nested_dirs=`dirname \`dirname "${path}"\``
```

**Why is this important?**
`$()` is more readable, visually distinct, and easily nestable without needing confusing escape characters like `\` inside backticks.

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

- **NEVER parse `ls` output.** `ls` output is meant for humans, not scripts. File names can contain spaces, newlines, or control characters. Use globbing or `find` instead.
  ```bash
  # Bad
  for file in $(ls *.txt); do ...

  # Good
  for file in *.txt; do ...
  ```
- **NEVER use `echo` to print variables that might contain hyphens.** If the variable starts with `-e` or `-n`, `echo` will interpret it as a flag. Use `printf` instead for unpredictable input.
  ```bash
  printf '%s\n' "${my_var}"
  ```
- **NEVER use `cat` when input redirection works.**
  ```bash
  # Bad (UUOC - Useless Use of Cat)
  cat file.txt | grep "error"

  # Good
  grep "error" < file.txt
  # or just
  grep "error" file.txt
  ```

By adhering to these principles, we ensure our Bash scripts are reliable, predictable, and maintainable.
