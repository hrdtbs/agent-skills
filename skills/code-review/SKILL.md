---
name: code-review
description: Perform a comprehensive and constructive code review. Use this skill when reviewing a pull request, file, or code snippet.
---

* Too Large PR: Explicitly suggest splitting if >400 lines.
* Be Specific: Provide explicit code examples (`Suggestion: ...`).

## Output Format
Present the review using the exact template with sections: `## Code Review Summary`, `## Key Findings` (categorized by `### 🔴 Blocking / Critical`, `### 🟡 Major / Important`, `### 🟢 Minor / Nitpicks`), and `## Verdict`.
