---
name: search-code
description: Efficiently search for code patterns in the current directory using grep. Use this skill when you need to find where a function, variable, or string is defined or used. Triggers on "find code", "search for", "grep".
---

# Search Code

This skill provides a powerful code search capability using `grep`. It allows agents to quickly locate code definitions, usages, and string occurrences within the project, excluding common non-source directories like `node_modules` and `.git`.

## How It Works

1. The agent invokes the skill with a search pattern (string or regex).
2. The skill executes a `grep` command recursively in the current directory.
3. It excludes `node_modules`, `.git`, `dist`, and `build` directories to keep results relevant.
4. It outputs the file path, line number, and matching content for each occurrence.

## Usage

```bash
bash /mnt/skills/user/search-code/scripts/search-code.sh "pattern" [path]
```

**Arguments:**
- `pattern` - The string or regular expression to search for. Required.
- `path` - The directory or file to search in. Defaults to `.` (current directory).

**Examples:**

Search for "function main" in the current directory:
```bash
bash /mnt/skills/user/search-code/scripts/search-code.sh "function main"
```

Search for "TODO" in the `src` directory:
```bash
bash /mnt/skills/user/search-code/scripts/search-code.sh "TODO" src
```

## Output

The output is a JSON array of objects, each representing a match.

```json
[
  {
    "file": "src/main.ts",
    "line": 10,
    "content": "function main() {"
  },
  {
    "file": "src/utils.ts",
    "line": 5,
    "content": "export function helper() {"
  }
]
```

## Present Results to User

When presenting results, format them as a list or table depending on the number of matches.

**Example:**

Found 2 matches for "main":

- `src/main.ts:10`: `function main() {`
- `src/utils.ts:5`: `export function helper() {` (Note: this example content might not match the query, just illustrating format)

## Troubleshooting

- **No results found**: Try a broader search pattern or check if the path is correct.
- **Permission denied**: Ensure the script has execution permissions (`chmod +x`).
- **Pattern errors**: If using regex, ensure special characters are escaped properly.
