---
name: cleanup
description: Investigate and remove unused code, files, and dependencies to keep the codebase clean and maintainable. Use this when you want to "remove unused code", "clean up dependencies", "find dead code", or "optimize project size".
---

* **Investigation:** Identify unused dependencies or code using automated tools for the relevant language (e.g. `depcheck`/`knip` for Node.js, `vulture` for Python, `go mod tidy` for Go) or manual `grep`.
* **Verification (CRITICAL):** Before removing anything, manually check for dynamic usage (strings, reflection, dynamic imports), framework/configuration usage (e.g., Tailwind config, ESLint plugins), and public API requirements.
* **Avoid False Positives:** Automated tools miss dynamic references. Always double-check with `grep`.
* **Removal:** Remove items minimally and incrementally.
* **Testing:** Run the test suite and a full build after removal to ensure no functional regressions or compilation errors.

## Output Format

Present your findings to the user using the exact following format before taking destructive action (if user confirmation is needed) or to summarize actions taken:

### Candidates for Removal
- **Type**: [Dependency | Code | File]
- **Item**: [Name or Path]
- **Evidence**: [Tool output or reason why it's believed to be unused]
- **Proposed Action**: [Remove | Investigate further]
