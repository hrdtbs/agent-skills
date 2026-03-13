# Prompt Engineering Best Practices

This document provides deeper context and specific techniques for crafting robust, production-ready LLM prompts.

## 1. Structure and Formatting

LLMs process text sequentially. A well-structured prompt makes it easier for the model's attention mechanism to focus on the right things at the right time.

### Use XML Tags

XML tags are highly recommended for separating different components of a prompt. They are universally understood by modern LLMs and provide clear boundaries.

**Example Structure:**
```text
<system_role>
You are a senior data analyst.
</system_role>

<instructions>
1. Read the provided CSV data.
2. Identify the top 3 selling products.
3. Output the results in JSON format.
</instructions>

<examples>
...
</examples>

<data>
{{USER_INPUT}}
</data>
```

## 2. Chain of Thought (CoT)

For complex tasks, forcing the model to explain its reasoning *before* outputting the final answer significantly improves accuracy and reduces hallucinations.

**How to implement:**
Instruct the model to use a scratchpad or a thinking block.

**Example:**
```text
Before providing the final JSON output, please write out your step-by-step reasoning inside <thinking> tags.
Analyze the edge cases, perform any necessary calculations, and then output your final answer inside <result> tags.
```

*Why this works:* It gives the model more "tokens" to process the logic before it commits to an answer.

## 3. Few-Shot Prompting (Examples)

Showing is better than telling. Providing examples is the most reliable way to enforce output formats and demonstrate handling of edge cases.

**Best practices for examples:**
- Provide at least 2 examples.
- Include an example of a "happy path" and an example of an "edge case" or error state.
- Format the examples exactly as you want the final output formatted.

**Example:**
```text
<examples>
<example>
<input>The sky is blue today.</input>
<sentiment>positive</sentiment>
</example>
<example>
<input>I spilled my coffee.</input>
<sentiment>negative</sentiment>
</example>
</examples>
```

## 4. Handling "Lost in the Middle"

LLMs tend to pay more attention to the beginning and the end of a long prompt.

- **Put the most critical instructions at the very end** of the prompt, right before the model is expected to generate text.
- If you have a massive block of reference text, put it in the middle, and reiterate the core task at the end.

## 5. Controlling Output Format

If you need a specific format (like JSON, YAML, or a specific Markdown structure), you must be explicit.

- Tell the model exactly what keys/fields to include.
- Provide a JSON schema if applicable.
- **Pro-tip:** Use "pre-filling" to force the model into the format. End your prompt with the opening bracket:
  ```text
  Return the result as a valid JSON object.

  {
  ```

## 6. Troubleshooting Common Issues

*   **Hallucinations:** The model is making things up.
    *   *Fix:* Add strict grounding constraints ("Only use the information provided in the `<document>`. If the answer is not present, say 'I do not know'"). Add a `<thinking>` step.
*   **Ignoring Instructions:** The model skips a step.
    *   *Fix:* Use a numbered list for instructions. Move the skipped instruction to the very end of the prompt.
*   **Formatting Errors:** The model outputs markdown when you just wanted JSON.
    *   *Fix:* Add an instruction like "Do not include any preamble or markdown formatting like ```json. Output raw JSON only."
