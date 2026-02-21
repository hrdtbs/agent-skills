---
name: systematic-debugging
description: A rigorous debugging protocol to find root causes before attempting fixes. Use this when encountering bugs, test failures, or unexpected behavior to avoid "thrashing" and random guessing.
---

# Systematic Debugging

A disciplined approach to debugging that prevents wasted time and new bugs. Use this skill when you encounter a test failure, a runtime error, or unexpected behavior.

## The Iron Law

**NO FIXES WITHOUT ROOT CAUSE INVESTIGATION FIRST.**

If you do not know *exactly* why it broke, you cannot fix it. Guessing is failure.

## The Process

### Phase 1: Investigation (Root Cause)

Before touching any code to "fix" it:

1.  **Read Error Messages:** Do not skim. Read the stack trace. Note file paths and line numbers.
2.  **Reproduce:** Can you trigger it reliably? If not, add logging until you can.
3.  **Check Changes:** What changed recently? (Git diff, dependencies).
4.  **Gather Evidence:** Add `print` statements or logs to trace data flow.
    - *Input:* What data entered the failing component?
    - *State:* What was the internal state?
    - *Output:* What data exited?

### Phase 2: Hypothesis

Formulate a specific hypothesis based on evidence.

- **Bad:** "Maybe it's the variable."
- **Good:** "I believe the `user_id` is null because the `auth` middleware was skipped."

### Phase 3: Testing the Hypothesis

Verify your hypothesis *without* fixing the bug yet, if possible.

- **Predict:** "If I log `user_id` here, it should be null."
- **Test:** Run the code and confirm.
- **Refine:** If the prediction was wrong, go back to Phase 1.

### Phase 4: Implementation (The Fix)

Only now do you write the fix.

1.  **Write a Failing Test:** Create a test case that reproduces the bug (Red).
2.  **Implement the Fix:** Make the minimal change required (Green).
3.  **Verify:** Run the test. Ensure no regressions.

## Red Flags (Stop Immediately)

If you find yourself thinking these thoughts, **STOP** and return to Phase 1:

- "I'll just try this and see if it works."
- "This is a quick fix, I'll investigate later."
- "I'll change X, Y, and Z at the same time."
- "I don't know why this works, but it does."

## Troubleshooting

- **"I can't reproduce it":** You need more logging. Do not guess.
- **"I fixed it but it broke something else":** You didn't understand the root cause. Revert and investigate.
