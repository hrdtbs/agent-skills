---
name: test-driven-development
description: Guidelines and procedures for Test-Driven Development (TDD). Use this when writing new features, fixing bugs, or refactoring code.
---

# Test-Driven Development (TDD)

## Overview

Test-Driven Development (TDD) is a software development process where you write a test before writing the actual code. The cycle is: **Red-Green-Refactor**.

1.  **Red**: Write a failing test.
2.  **Green**: Write the minimal code to pass the test.
3.  **Refactor**: Improve the code while keeping the test green.

## The Iron Law

**NO PRODUCTION CODE WITHOUT A FAILING TEST FIRST.**

*   If you write code before the test, delete it and start over.
*   Exceptions: Throwaway prototypes, generated code, configuration files (ask for permission).

## The TDD Cycle

### 1. RED - Write Failing Test
*   Write one minimal test that defines the expected behavior.
*   Ensure the test name is clear and describes the behavior, not the implementation.
*   Example: `test('rejects empty email', ...)`

### 2. Verify RED - Watch It Fail
*   Run the test.
*   **Confirm it fails**.
*   Confirm it fails for the **expected reason** (e.g., "Email required" vs "undefined").
*   If it passes or errors out (compilation error, etc.), fix the test/setup until it fails correctly.

### 3. GREEN - Minimal Code
*   Write the simplest code to make the test pass.
*   Do not add extra features or future-proofing.
*   Do not refactor yet.

### 4. Verify GREEN - Watch It Pass
*   Run the test.
*   **Confirm it passes**.
*   Ensure all other tests also pass.

### 5. REFACTOR - Clean Up
*   Remove duplication.
*   Improve variable/function names.
*   Extract helper functions.
*   **Keep tests green** throughout this process.

## Common Rationalizations to Avoid

*   "It's too simple to test": Simple code breaks too.
*   "I'll write tests later": You won't, or they will be biased by the implementation.
*   "I already manually tested it": Manual testing is ad-hoc and not repeatable.
*   "Deleting code is wasteful": Keeping unverified code is technical debt.

## Verification Checklist

Before marking work as complete:
- [ ] Every new function/method has a corresponding test.
- [ ] You watched each test fail before implementing the code.
- [ ] Each test failed for the expected reason.
- [ ] You wrote only the minimal code to pass the test.
- [ ] All tests pass (green).
- [ ] Code was refactored after passing tests.
- [ ] Edge cases are covered.
