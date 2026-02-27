---
name: error-handling
description: Best practices for robust error handling. Use this to design error flows, review exception handling, and improve system reliability.
---

# Error Handling

Design robust error handling strategies to ensure system stability and debuggability.

## Core Principles

*   **Fail Fast**: Detect and report errors as early as possible.
*   **Context is King**: Include *What*, *Why*, *Where*, and *Who* in error details.
*   **Recover or Crash**: Recover if possible; otherwise, crash safely.
*   **User vs. System**: Distinguish between client errors (4xx) and server errors (5xx).

## Best Practices

### Raising Errors
*   **Use Specific Exceptions**: Define custom domain exceptions (e.g., `InsufficientFundsError`).
*   **No Control Flow via Exceptions**: Use exceptions only for exceptional circumstances.
*   **Validate Boundaries**: Check inputs at public API edges.

### Catching & Handling
*   **Catch Narrowly**: Handle specific exceptions; let others bubble up.
*   **Resource Cleanup**: Always use `finally`, `try-with-resources`, or `defer`.
*   **Preserve Stack Traces**: Retain original cause when wrapping exceptions.

### Logging
*   **Log Levels**: Strict adherence to `ERROR` (intervention needed), `WARN` (recoverable), `INFO` (milestones), `DEBUG` (internals).
*   **No Sensitive Data**: Sanitize logs (PII, secrets).

## Checklist

- [ ]  Custom exception types used for domain errors.
- [ ]  Error messages explain *why* it failed.
- [ ]  Resources (DB, File, Network) released in failure scenarios.
- [ ]  Original stack trace preserved when re-throwing.
- [ ]  No "swallowed" exceptions (empty catch blocks).
- [ ]  PII excluded from error logs.
- [ ]  Global error handler configured.

## Common Pitfalls

*   **Swallowing Errors**: `catch (e) { log(e); }` without re-throwing.
*   **Leaking Implementation**: Exposing internal details (SQL, paths) in API responses.
*   **Alert Fatigue**: Overusing `ERROR` level.
*   **Broad Catch**: `catch (Exception e)` handling unintended signals.
