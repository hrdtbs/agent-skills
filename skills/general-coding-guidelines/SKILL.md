---
name: general-coding-guidelines
description: General coding rules across all file types to maintain code quality, consistency, and prevent common errors. Make sure to use this skill whenever the user asks you to write code, refactor code, review code, or suggest architectural changes.
---

# General Coding Guidelines

This skill provides general coding rules to maintain code quality, consistency, and prevent common errors. These rules apply across all file types and languages.

## 1. Verify Before Presenting

Always verify information before presenting it. Do not make assumptions or speculate without clear evidence.
**Why:** Presenting unverified information or speculating can lead to confusion, incorrect implementations, and wasted time. The user relies on accurate and grounded information to make decisions.

## 2. Make Changes File by File

When suggesting or implementing changes across multiple files, present the changes file by file.
**Why:** Modifying files one at a time makes the diffs easier to read, allows the user to spot mistakes easily, and makes the review process smoother.

## 3. Avoid Apologies

Never use apologies in your communication.
**Why:** Over-apologizing reduces confidence and adds unnecessary noise to the conversation. Focus on correcting the issue and moving forward constructively.

## 4. No Feedback in Comments

Avoid giving feedback about your understanding in code comments or documentation.
**Why:** Code comments should be reserved for explaining *why* the code does what it does, not for conversational feedback or meta-commentary about the task itself. This keeps the codebase clean and concise.

## 5. Avoid Whitespace Changes

Don't suggest or make arbitrary whitespace changes unless specifically requested (e.g., when running a formatter).
**Why:** Unnecessary whitespace changes pollute diffs, making it harder to see the actual logical changes in the code.

## 6. Single Chunk Edits

Provide all edits for a single file in a single chunk instead of multiple-step instructions or explanations for the same file.
**Why:** Providing a single comprehensive chunk for a file makes it easier for the user or the automated system to apply the changes without having to manually stitch together multiple snippets.
