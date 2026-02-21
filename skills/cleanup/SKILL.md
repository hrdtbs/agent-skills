---
name: cleanup
description: Investigate and remove unused code, files, and dependencies to keep the codebase clean and maintainable. Use this when you want to "remove unused code", "clean up dependencies", "find dead code", or "optimize project size".
---

# Cleanup

A skill for identifying and removing unused code, dead files, and unnecessary dependencies. This helps reduce technical debt, improve build times, and make the codebase easier to navigate.

## Workflow

### Phase 1: Investigation
Identify potential candidates for removal using automated tools or manual inspection.

#### Unused Dependencies
Check for packages listed in project metadata (e.g., `package.json`, `requirements.txt`, `go.mod`) that are not actually imported or used in the source code.

- **Node.js**: Use `depcheck` or `knip`.
- **Python**: Use `pip-check-reqs` or `deptry`.
- **Go**: Use `go mod tidy`.

#### Unused Code & Files
Check for functions, classes, variables, or entire files that are defined but never referenced.

- **Node.js/TypeScript**: Use `knip` or `ts-prune`.
- **Python**: Use `vulture`.
- **Go**: Use `unused` (from `staticcheck`).
- **General**: Use `grep` or `ripgrep` to search for references across the project.

### Phase 2: Verification
Before deleting anything, perform a thorough check to avoid breaking the application.

1.  **Check Dynamic Usage**: Look for strings used in reflection, dynamic imports, or runtime lookups that might not be caught by static analysis tools.
2.  **Check Configuration**: Ensure the item is not used by build tools, CI/CD pipelines, or configuration files (e.g., ESLint plugins, Tailwind CSS content paths).
3.  **Public API Check**: If the repository is a library, verify if the "unused" code is part of the public API intended for external users.

### Phase 3: Removal & Testing
1.  **Minimal Removal**: Remove one component at a time if possible.
2.  **Run Tests**: Execute the test suite to ensure no functional regressions.
3.  **Run Build**: Perform a full build to verify that dependencies are still intact and no compilation errors were introduced.

## Usage Examples

### Finding unused Node.js dependencies
```bash
npx depcheck
```

### Finding dead Python code
```bash
pip install vulture
vulture .
```

### Cleaning up Go modules
```bash
go mod tidy
```

### Searching for references manually
```bash
grep -r "my_function_name" .
```

## Presentation to User

When presenting findings to the user, use the following format:

### Candidates for Removal
- **Type**: [Dependency | Code | File]
- **Item**: [Name or Path]
- **Evidence**: [Tool output or reason why it's believed to be unused]
- **Proposed Action**: [Remove | Investigate further]

## Troubleshooting

- **False Positives**: Automated tools often miss dynamic references. Always verify with `grep` before removal.
- **Hidden Dependencies**: Some dependencies are used implicitly by frameworks or tools. Check configuration files if a tool breaks after removing a "unused" dependency.
- **Peer Dependencies**: Be careful when removing packages that might be required by other packages but not directly imported.
