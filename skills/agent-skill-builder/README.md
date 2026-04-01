# agent-skill-builder

An Agent Skill that instructs coding agents (like Claude, Cursor, and Gemini) on how to build, refine, and structure robust Agent Skills.

This skill is a meta-skill. It enforces the official specifications, progressive disclosure, and knowledge delta philosophy for creating effective `SKILL.md` files.

## Usage

When an AI agent equipped with this skill is asked to create or modify an Agent Skill (`SKILL.md`), it will automatically:
1.  Focus on the **Knowledge Delta** (excluding generic tutorials).
2.  Craft a robust, pushy `description` to ensure proper triggering.
3.  Structure the skill for **Progressive Disclosure** (using `references/` for deep dives).
4.  Include explicit **Anti-Patterns** with reasoning.

## Example Triggers

*   "Create a new skill for Next.js 14 App Router."
*   "Refactor this SKILL.md to be more effective and follow best practices."
*   "Build a Python API skill, utilizing progressive disclosure for the database schema references."
