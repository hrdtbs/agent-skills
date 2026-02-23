---
name: code-review
description: Perform a comprehensive and constructive code review. Use this skill when you need to review a pull request, a specific file, or a code snippet. It focuses on correctness, security, performance, maintainability, and style.
---

# Code Review

This skill guides you through performing a high-quality code review. The goal is to improve code quality, share knowledge, and prevent bugs.

## How It Works

1.  **Understand Context**: Read the PR description, linked issues, and related documentation. Understand *what* the code is supposed to do and *why*.
2.  **High-Level Check**:
    *   Does the design make sense?
    *   Is it consistent with the existing architecture?
    *   Are files organized logically?
3.  **Detailed Inspection**:
    *   **Correctness**: Does it handle edge cases? Are there logic errors?
    *   **Security**: Are there vulnerabilities (e.g., injection, sensitive data exposure)?
    *   **Performance**: Are there inefficient loops, N+1 queries, or memory leaks?
    *   **Maintainability**: Is the code readable? Are names descriptive? Is it DRY?
    *   **Tests**: Is there adequate test coverage? Are tests meaningful?
4.  **Feedback**: Provide clear, actionable, and polite feedback. Distinguish between blocking issues and nitpicks.

## Checklist

### Logic & Correctness
- [ ] Edge cases are handled (e.g., empty lists, null values).
- [ ] Error handling is robust.
- [ ] No race conditions or concurrency issues.

### Security
- [ ] Input is validated and sanitized.
- [ ] No hardcoded secrets.
- [ ] Authorization checks are present.

### Performance
- [ ] No unnecessary computations or I/O in loops.
- [ ] Database queries are optimized.
- [ ] Resources are properly released.

### Maintainability
- [ ] Variable and function names are clear and descriptive.
- [ ] Functions are small and focused (Single Responsibility Principle).
- [ ] No commented-out code.

### Testing
- [ ] New code is covered by tests.
- [ ] Tests verify behavior, not implementation details.

## Feedback Guidelines

*   **Be Specific**: specific examples or suggestions.
*   **Be Constructive**: Focus on the code, not the author.
*   **Prioritize**: Mark critical issues as "Blocking". Use "Nitpick" for minor suggestions.
*   **Suggest Code**: When possible, provide a code snippet showing the suggested change.

## Present Results to User

Use the following template when presenting the review:

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

## Troubleshooting

-   **Too large PR**: If the PR is too large (>400 lines), suggest splitting it or review it in chunks.
-   **Unclear Context**: If the PR description is missing, ask for clarification before reviewing.
-   **Disagreement**: If the author disagrees, focus on the problem and objective data, not opinions.
