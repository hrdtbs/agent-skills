---
name: code-review
description: Perform a comprehensive and constructive code review. Use this skill when reviewing a pull request, file, or code snippet.
---
* Understand Context: Read the PR description, linked issues, and related documentation.
* Be Specific: Provide code snippets.
* Too Large PR: Explicitly suggest splitting if >400 lines.

## Output Format
Present the review using the exact template with sections: `## Code Review Summary`, `## Key Findings` (categorized by `### 🔴 Blocking / Critical`, `### 🟡 Major / Important`, `### 🟢 Minor / Nitpicks`), and `## Verdict`.
