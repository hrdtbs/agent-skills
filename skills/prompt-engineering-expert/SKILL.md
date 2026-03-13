---
name: prompt-engineering-expert
description: Apply prompt engineering best practices to write, refine, and optimize system prompts, user prompts, and agent instructions. Use this skill whenever the user wants to write a prompt, optimize an existing prompt for better results, fix a prompt that is hallucinating or underperforming, or structure prompts for Large Language Models (LLMs). Even if the user just says "help me write instructions for my agent", trigger this skill.
---

# Prompt Engineering Expert

A skill to help users craft, refine, and optimize prompts for LLMs using proven prompt engineering techniques.

Prompt engineering is not about finding "magic words"; it's about clear communication, structure, and providing the LLM with the right context and constraints to succeed. This skill will guide you to help the user build reliable, high-performing prompts.

## Core Philosophy

When helping a user with a prompt, your goal is to understand *why* they need it and *what* the LLM needs to know to accomplish the task successfully.

- **Clarity over cleverness:** Ensure the instructions are unambiguous.
- **Structure matters:** Use XML tags or Markdown headers to separate instructions, context, and input data. LLMs parse structured text much better than walls of text.
- **Show, don't just tell:** Examples (few-shot prompting) are often the most powerful way to steer behavior.
- **Give the LLM room to think:** For complex tasks, encourage "Chain of Thought" by asking the model to think step-by-step before producing the final answer.

## Workflow

1.  **Analyze the Request:** Understand what the user's prompt needs to achieve. What are the inputs? What is the expected output? What are the edge cases?
2.  **Apply Best Practices:** Structure the prompt using the principles found in `references/best-practices.md`.
3.  **Draft the Prompt:** Write the draft. Make sure it uses appropriate structural tags (like `<instructions>`, `<context>`, `<input>`).
4.  **Explain the "Why":** Briefly explain to the user *why* you structured the prompt the way you did (e.g., "I added a `<thinking>` block so the model can reason before answering, which reduces hallucinations.").
5.  **Iterate:** Refine based on user feedback.

## Essential Techniques

When writing or reviewing prompts, verify they utilize the following techniques where appropriate:

-   **Role Prompting:** Give the LLM a persona (e.g., "You are an expert system administrator..."). This helps set the tone and knowledge boundary.
-   **XML Tags for Structure:** Use `<tags>` to clearly demarcate different parts of the prompt. This prevents the LLM from confusing instructions with user input.
-   **Chain of Thought (CoT):** If the task requires logic, math, or complex reasoning, explicitly instruct the model to think out loud inside `<thinking>` tags before providing the final `<answer>`.
-   **Few-Shot Examples:** Include 1-3 examples of the input and the desired output. Make sure the examples cover edge cases.
-   **Pre-filling / Prefacing:** Sometimes it helps to start the model's response for it (e.g., ending the prompt with `Here is the JSON: {`).

## Deeper Context

For a detailed breakdown of prompt engineering techniques, formatting guidelines, and troubleshooting tips (like how to fix hallucinations or dropped instructions), please read `references/best-practices.md`.

## Output Format

When providing the final prompt to the user, present it clearly in a code block so it can be easily copied:

```markdown
Here is your optimized prompt:

\`\`\`text
[Your structured prompt here]
\`\`\`
```

Always encourage the user to test the prompt and bring back the results for further tuning if it doesn't behave exactly as expected.
