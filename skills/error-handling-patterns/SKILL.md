---
name: error-handling-patterns
description: Use this skill to implement robust error handling strategies that gracefully handle failures and provide excellent debugging experiences.
---

# Error Handling Patterns

Build resilient applications by failing fast, logging context, and returning actionable error types.

## When to Use

- Implementing new API endpoints or critical pathways.
- Debugging unexpected crashes or blank screens in production.
- Refactoring `try-catch` blocks that silently swallow exceptions.
- Designing system boundaries (e.g., database, external services).

## Core Concepts

- **Exceptions vs. Result Types:** Use exceptions for truly unexpected, unrecoverable states (e.g., OOM). Use explicit Result Types (or idiomatic equivalents like Go's `(value, err)`) for expected failures (e.g., validation, missing records).
- **Categorization:** Distinguish between *Recoverable* (network timeouts) and *Unrecoverable* (programming bugs).

## Guiding Principles

1. **Fail Fast:** Validate inputs at system boundaries. Do not pass malformed data deeper.
2. **Never Swallow Errors:** Empty `catch` blocks or `except Exception: pass` are prohibited. If an error is truly benign, log it at `DEBUG` or `INFO` level with explicit comments.
3. **Preserve Context:** When wrapping or re-throwing errors, maintain the original stack trace and attach business context (e.g., user ID, request ID).
4. **Actionable Messages:** Error messages must answer: What failed? Why did it fail? How can it be fixed?
5. **Clean Up Resources:** Always use `try-finally`, context managers (Python), or `defer` (Go) to release locks, connections, or file handles.

## Common Pitfalls

- **Catching `Exception` Broadly:** Hides underlying bugs. Catch specific error types.
- **Log and Re-throw:** Causes duplicate, noisy log entries. Pick one: handle/log, or re-throw.
- **Returning Generic Codes:** Avoid returning raw `500` without internal telemetry or returning plain `-1` instead of typed errors.

## Checklist

- [ ] Inputs are validated early, and invalid inputs fail immediately.
- [ ] No empty catch blocks exist.
- [ ] Original error context/stack trace is preserved if the error is re-thrown.
- [ ] Resources (files, DB connections) are guaranteed to be released (e.g., `finally`).
- [ ] Error logs include actionable context (request IDs, IDs involved, but no PII).
- [ ] Boundary errors (e.g., DB failure) are mapped to appropriate domain errors before leaking to the user.
