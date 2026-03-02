---
name: code-review-excellence
description: Refined code review practices focusing on actionable, collaborative feedback over gatekeeping.
---

* Feedback Structure: Use `[severity]` prefixes (`🔴 [blocking]`, `🟡 [important]`, `🟢 [nit]`, `💡 [suggestion]`, `📚 [learning]`, `🎉 [praise]`).
* Suggesting Changes: Provide explicit code examples (`Suggestion: ... What do you think?`).
* Architecture First: Review design docs or core abstractions before implementation details.
* Test Reviews: Verify tests describe behavior, cover edge cases, and are independent.
* Scope Restraint: Ignore automated linting/formatting issues. Do not rewrite code to personal preference.
