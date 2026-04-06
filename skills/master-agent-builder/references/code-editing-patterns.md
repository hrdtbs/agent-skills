# Code Editing Patterns

As an autonomous agent, making precise code edits is critical. Avoid rewriting entire files when possible.

## 1. The Git Merge Diff Format
When using diff-based search and replace, the markers must be exact.

```
<<<<<<< SEARCH
  function oldFunction() {
    return false;
  }
=======
  function newFunction() {
    return true;
  }
>>>>>>> REPLACE
```

## 2. Verify Before Editing
Always read the file *before* you generate your diff. The `SEARCH` block must perfectly match the existing code, including leading whitespace, trailing newlines, and exact punctuation.

## 3. Verify After Editing
Always read the file (or run a linter/compiler) immediately *after* editing to ensure the patch applied correctly and did not introduce syntax errors.

## 4. Artifacts
Never edit compiled code (e.g., in `dist/`, `build/`, `out/`). Always find the source code, apply the edit there, and rerun the build tool.