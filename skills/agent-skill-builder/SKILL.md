---
name: agent-skill-builder
description: Build and design robust Agent Skills by following official specifications, leveraging progressive disclosure, and maximizing the knowledge delta. Use this skill whenever you need to create, modify, or evaluate an Agent Skill (`SKILL.md`) for Claude, Cursor, Gemini, or other AI coding assistants.
---

# Agent Skill Builder

You are an expert in designing Agent Skills (sometimes referred to as custom commands, instructions, or knowledge externalization mechanisms for AI agents). Your goal is to create `SKILL.md` files that perfectly bridge the gap between what an AI already knows and the domain-specific expertise required for a task.

## The Core Philosophy: The Knowledge Delta

The value of an Agent Skill is its **Knowledge Delta**: the gap between what the skill provides and what the model already knows.
*   **DO NOT** write tutorials or explain basic concepts (e.g., "What is a for loop?", "How to use `git commit`").
*   **DO** provide expert-only knowledge: decision trees, edge cases, trade-offs, anti-patterns, and domain-specific thinking frameworks.

## Core Directives for Skill Creation

### 1. Master the Description (The Trigger)
The frontmatter `description` is the most critical part of the skill. It is the *only* thing the agent sees before deciding whether to load the skill.
*   **Must include WHAT:** What the skill does.
*   **Must include WHEN:** Specific trigger scenarios ("Use when the user asks for...", "When you need to...").
*   **Must include KEYWORDS:** Searchable terms (e.g., `.docx`, `frontend`, `React`, `database schema`).
*   **BE PUSHY:** Use strong language like "Make sure to use this skill whenever..." to overcome the AI's tendency to undertrigger.

### 2. Implement Progressive Disclosure
Do not dump everything into a massive `SKILL.md` file.
*   **Layer 1 (Metadata):** Frontmatter name and description (~100 tokens, always in context).
*   **Layer 2 (SKILL.md):** The main body. Keep it concise (ideal < 300-500 lines). Put core routing, mindsets, and decision trees here.
*   **Layer 3 (Resources):** Use `references/` for detailed docs and `scripts/` for executable code.
*   **Explicit Loading:** When using references, explicitly tell the agent *when* and *how* to load them (e.g., "**MANDATORY**: Before proceeding, read `references/advanced-patterns.md`").

### 3. Curate a Strong "NEVER" List (Anti-Patterns)
Half of expertise is knowing what *not* to do. Include an explicit list of anti-patterns.
*   **Specifics, not platitudes:** Don't say "Write good code." Say "NEVER use `var` for variable declaration; always use `const` or `let`."
*   **Explain the WHY:** Always explain *why* something is an anti-pattern. AI models have strong theory of mind and perform better when they understand the reasoning.

### 4. Calibrate Freedom to Fragility
*   **Creative Tasks (High Freedom):** Provide principles, aesthetic guidelines, and "how to think" frameworks. Let the agent make choices.
*   **Fragile Tasks (Low Freedom):** For operations where one wrong byte corrupts a file (e.g., modifying DOCX, PDF, binary protocols), provide exact, rigid procedures, scripts, and decision trees.

## Structure of a Great `SKILL.md`

```markdown
---
name: [skill-name]
description: [Strong, keyword-rich description of WHAT it does and EXACTLY WHEN to trigger it. E.g., "Make sure to use this skill whenever..."]
---

# [Skill Name]

[1-2 sentence summary of the expert mindset required]

## Mindset & Philosophy
[How the expert thinks about the problem. e.g., "Think mobile-first", "Assume the network will fail"]

## Decision Tree & Workflows
[Step-by-step procedures OR a table/tree of decisions. e.g., "If X happens, do Y. If Z, do W."]

## Anti-Patterns (NEVER Do These)
- **NEVER** [Specific action] because [Expert reasoning].
- **NEVER** [Specific action] because [Expert reasoning].

## Examples (Optional but Recommended)
[Concrete examples of input/output or good/bad code]

## Reference Loading (If using progressive disclosure)
**MANDATORY**: If you encounter [Condition], you MUST read `references/deep-dive.md` before proceeding.
```

## Anti-Patterns for Skill Building (NEVER do these)
- **NEVER** write generic descriptions like "A helpful skill for coding." It will never trigger.
- **NEVER** include generic tutorials ("How to use React"). You are wasting context tokens.
- **NEVER** use soft language for constraints (e.g., "Please try to avoid"). Use strong imperatives ("Do NOT use", "NEVER use").
- **NEVER** dump a 1000-line document into `SKILL.md`. Use the `references/` directory for progressive disclosure.
