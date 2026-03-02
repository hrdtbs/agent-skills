---
name: systematic-debugging
description: A rigorous debugging protocol to find root causes before attempting fixes. Use when encountering bugs or test failures.
---

* Do not attempt a fix without finding the exact root cause first. Guessing is failure.
* Always formulate a specific hypothesis based on evidence before modifying code (e.g., "I believe X is null because Y failed").
* Verify your hypothesis *before* implementing a fix, if possible, by adding logging or temporary assertions to confirm your understanding of the state.
* Write a failing test that reproduces the bug before writing the fix.
* Keep fixes minimal. Do not change X, Y, and Z at the same time to solve a single bug.
