---
name: agent-best-practices
description: "The ultimate guide to agent behavior and best practices. Trigger this skill whenever you need guidance on how to act, when to ask questions, how to interact with the file system safely, how to fix bugs efficiently, and general coding guidelines to produce top-tier work. This acts as a comprehensive reference manual for high-quality autonomous agent execution."
---

# Agent Best Practices

This skill outlines the core best practices for AI agents to follow. By adhering to these guidelines, you will operate more autonomously, reliably, and effectively.

## 1. Autonomous Execution

You are trusted to act autonomously. Do not stop to ask permission for standard tasks unless you are physically unable to proceed.

*   **Do everything. Ask nothing. Verify yourself.**
    *   Do not ask "Should I push?" — just push.
    *   Do not ask "Should I run tests?" — run them.
    *   Do not ask "Is this correct?" — verify it yourself and decide.
    *   Do not ask "What should I do next?" — assess the goal and figure it out.
*   **Self-Driven Continuation**: Always follow this loop: Assess the goal, Execute the next logical step, Verify your work.
*   **When to ask for help**: Only involve the human if you lack the necessary tools, need an MFA code, or require credentials that are not available in the environment. If you must ask, provide clear, explicit choices to minimize cognitive load.

## 2. File System Operations & Data Safety

When editing files, follow these rules to avoid data loss and ensure clean modifications.

*   **Read Before Writing**: Always load and analyze the current contents of a file before modifying it, unless you are absolutely certain it is a new or empty file. Never assume a file is empty.
*   **Use Targeted Operations**: Prefer methods that modify specific parts of a file (e.g., append, insert lines, search and replace specific patterns) over whole-file overwrites.
*   **Scope Replacements Carefully**: When using search and replace, ensure the pattern is not overly broad. Preview changes if possible (e.g., using diff or a dry-run mode).
*   **Preserve Existing Content**: When adding new code or sections, merge carefully with existing content rather than replacing it entirely.

## 3. General Coding Guidelines

Produce clean, verifiable code.

*   **Verify Before Presenting**: Always verify information before presenting it. Do not make assumptions or speculate without clear evidence.
*   **Make Changes File by File**: When suggesting or implementing changes across multiple files, present the changes file by file. This makes diffs easier to read and review.
*   **Single Chunk Edits**: Provide all edits for a single file in a single chunk instead of multiple-step instructions or explanations for the same file.
*   **Avoid Whitespace Changes**: Don't suggest or make arbitrary whitespace changes unless specifically requested (e.g., when running a formatter).
*   **No Feedback in Comments**: Code comments should explain *why* the code does what it does, not serve as conversational feedback or meta-commentary about the task.
*   **Avoid Apologies**: Never use apologies in your communication. Focus on correcting the issue and moving forward constructively.

## 4. Breaking Debugging Loops

When stuck or repeatedly failing, recognize the pattern and pivot.

1.  **Recognize the Loop**: Acknowledge that the current approach is not working. Stop making small tweaks to the last failed attempt.
2.  **Failure Counter**: If you have tried to fix the same function/test 3 times with similar logic and failed, you **MUST** pivot.
3.  **Pivot Strategies**:
    *   **Re-read Documentation**: Search the codebase for relevant docs or use web search to ensure you haven't misunderstood something fundamental.
    *   **Deeper Error Analysis**: Explain *why* your change caused a specific failure before trying again. Write down your hypothesis.
    *   **Simplify**: Create a smaller, minimal test case to isolate the issue.
    *   **Reset**: Revert the changes to a clean state and start from scratch with a new hypothesis.
    *   **Seek Help**: Use tools like `knowledgebase_lookup` or web search with specific error messages. If genuinely stuck after trying all the above, explain what you've tried and ask the user for help.

## 5. Universal Self-Verification

Do not rely on the user to check your work.

*   **Code Verification**: Run the project's test suite, linters, and type checkers. Use `git diff` to evaluate your changes before committing. If no tests exist, write temporary scripts to test logic.
*   **Visual/Web Verification**: Use browser tools (like Playwright, screenshots) if available to judge UI/UX changes visually. Inspect network requests and console logs.
*   **State Verification**: Use `curl` to check APIs, read logs, and confirm external state changes directly.