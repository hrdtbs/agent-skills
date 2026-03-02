---
name: code-review
description: Perform a comprehensive and constructive code review. Use this skill when reviewing a pull request, file, or code snippet.
---

* Understand Context: Read the PR description, linked issues, and related documentation before reviewing.
* Be Specific: Provide code snippets when suggesting changes.
* Too Large PR: If a PR is over 400 lines, explicitly suggest splitting it up.

## Output Format

Present the review using the following exact template:

```markdown
## Code Review Summary

[Brief summary of the review]

## Key Findings

### 🔴 Blocking / Critical
*   [Issue description] - [Why it matters]
    *   Suggestion: `...`

### 🟡 Major / Important
*   [Issue description]
    *   Suggestion: `...`

### 🟢 Minor / Nitpicks
*   [Issue description]

## Verdict
[Approve / Request Changes / Comment]
```
