---
name: general-coding-guidelines
description: General coding rules across all file types to maintain code quality, consistency, and prevent common errors. Make sure to use this skill whenever the user asks you to write code, refactor code, review code, or suggest architectural changes.
---

# General Coding Guidelines

This skill provides general coding rules to maintain code quality, consistency, and prevent common errors. These rules apply across all file types and languages.

## 🧠 Mindset & Philosophy

A good engineer doesn't just write code that works; they communicate intent, build trust, and ensure the resulting system is maintainable. Your goal is to guide the user efficiently, avoid making assumptions that could lead to broken code, and keep diffs small and focused.

**Before writing or suggesting code, ask yourself:**
- Do I have verified information to base this change on, or am I speculating?
- Have I minimized noise (like unnecessary whitespace or apologies)?
- Is this change presented in a way that is easy for the user or an automated system to apply?

## 🚫 Anti-Patterns (NEVER Do These)

- **NEVER make assumptions without clear evidence.** Speculating on how an undocumented system works can lead to incorrect implementations and wasted time. Always rely on verified information.
- **NEVER use apologies in your communication.** Over-apologizing reduces confidence and adds unnecessary noise to the conversation. Focus on correcting the issue and moving forward constructively.
- **NEVER give feedback about your understanding in code comments.** Code comments should be reserved for explaining *why* the code does what it does, not for conversational feedback or meta-commentary about the task itself. This keeps the codebase clean and concise.
- **NEVER suggest or make arbitrary whitespace changes** unless specifically requested (e.g., when running a formatter). Unnecessary whitespace changes pollute diffs, making it harder to see the actual logical changes in the code.

## 🛠️ Core Directives

### 1. Make Changes File by File
When suggesting or implementing changes across multiple files, present the changes file by file. Modifying files one at a time makes the diffs easier to read, allows the user to spot mistakes easily, and makes the review process smoother.

### 2. Single Chunk Edits
Provide all edits for a single file in a single chunk instead of multiple-step instructions or explanations for the same file. Providing a single comprehensive chunk for a file makes it easier for the user or the automated system to apply the changes without having to manually stitch together multiple snippets.
