---
name: master-agent-builder
description: The ultimate guide for autonomous execution and coding. Make sure to use this skill whenever the user asks you to write code autonomously, set up an agentic loop, or asks you to explore, analyze, or execute a complex programming or refactoring task. It provides the definitive workflow for planning, executing, verifying, and delivering software engineering tasks safely and effectively.
---

# Master Agent Builder

This skill provides a definitive, "masterpiece" workflow for autonomous AI agents. It incorporates best practices for understanding requirements, interacting with the file system, planning, verifying work, and communicating effectively with the user. It is built to maximize autonomy while ensuring safe, predictable, and robust code generation.

## 1. Initial Assessment and Exploration
Before writing a single line of code, you must build a comprehensive context of the task.

- **Understand Intent**: Analyze the user's request. What is the final goal? Are there any unstated constraints?
- **Codebase Exploration**: Use `list_files`, `read_file`, and search commands (e.g. `grep`) to map out relevant parts of the codebase. Pay special attention to `README.md`, `AGENTS.md`, and project configuration files (e.g., `package.json`, `requirements.txt`).
- **Research**: If external tools, libraries, or frameworks are mentioned, use `google_search` or `view_text_website` to find the most up-to-date documentation if you are unsure.

## 2. Planning
A robust plan is the foundation of successful autonomous execution.

- **Drafting a Plan**: Break the task down into discrete, numbered steps. Each step must be actionable and testable.
- **Pre-commit Step**: Always include a step near the end of your plan to "Complete pre-commit steps to ensure proper testing, verification, review, and reflection are done."
- **Plan Review**: Propose your plan and use `request_plan_review` or equivalent tools to get feedback before finalizing it with `set_plan`.

## 3. Execution and Verification (The Agentic Loop)
Execute your plan step by step. **Never assume a command or file change worked without checking.**

- **Read before Write**: Always read a file before modifying it to understand its current state.
- **Targeted Edits**: Use targeted replace operations (like Git merge diffs) instead of overwriting entire files, to minimize context loss and errors.
- **Immediate Verification**: After EVERY file modification, use `read_file`, `list_files`, or a run script to verify that your changes were applied exactly as intended. Do not mark a plan step as complete until you have verified the outcome.
- **Build from Source**: If you need to edit an artifact (e.g., files in `dist/` or `build/`), DO NOT edit it directly. Find the source code, modify it, and run the build command.
- **Handling Long-Running Processes**: For servers or watchers, run them in the background (e.g., `npm start > output.log 2>&1 &`). Manage processes properly, killing existing ones before restarting (e.g., `kill $(lsof -t -i :3000)`).

## 4. Troubleshooting and Diagnosis
When things go wrong, slow down and analyze.

- **Diagnose First**: If a test or build fails, read the error logs carefully. Do not immediately install or uninstall dependencies.
- **Iterative Fixes**: Make one logical change at a time, verify it, and see if it resolves the issue.
- **Knowledgebase**: If you're stuck, use `knowledgebase_lookup` (or equivalent external knowledge tools) for hints or documentation.

## 5. Communication
Keep the user informed, but do not overwhelm them.

- **Progress Updates**: When providing a summary or using `message_user`, be concise about what was accomplished and what the next step is.
- **Asking for Help**: Solve problems autonomously when possible. Only use `request_user_input` if:
  1. The request is genuinely ambiguous.
  2. You are stuck after multiple varied attempts.
  3. A decision significantly alters the scope of the project.

## 6. Delivery
Before finalizing the task:

- Run all relevant tests and linters.
- Follow the instructions provided by `pre_commit_instructions`.
- Submit the changes using the appropriate submission tool, ensuring descriptive commit messages and branch names.

## Further Reading
For deeper dives into specific behaviors, consult the supplementary reference materials provided in this skill:
- `references/bash-patterns.md` (Common shell idioms for agents)
- `references/code-editing-patterns.md` (How to write targeted, safe diffs)
