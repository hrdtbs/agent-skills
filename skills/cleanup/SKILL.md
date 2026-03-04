---
name: cleanup
description: Investigate and remove unused code, files, and dependencies to keep the codebase clean and maintainable. Use this when you want to "remove unused code", "clean up dependencies", "find dead code", or "optimize project size".
---

* **Verification (CRITICAL):** Before removing anything, manually check for dynamic usage (strings, reflection, dynamic imports), framework/configuration usage (e.g., Tailwind config, ESLint plugins), and public API requirements. Always double-check automated tool findings with `grep` to avoid false positives.

## Output Format

Present your findings to the user using the exact following format before taking destructive action (if user confirmation is needed) or to summarize actions taken:

### Candidates for Removal
- **Type**: [Dependency | Code | File]
- **Item**: [Name or Path]
- **Evidence**: [Tool output or reason why it's believed to be unused]
- **Proposed Action**: [Remove | Investigate further]
