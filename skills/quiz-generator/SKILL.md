---
name: quiz-generator
description: Call a subagent to give the user a quiz based on the response you just gave them. Use this whenever you want to test the user's understanding of the concepts you just explained, or if the user explicitly asks for a quiz. Make sure to use this skill whenever the user mentions checking understanding, learning check, or wants to make sure they got a concept, even if they don't explicitly ask for a "quiz".
---

# Quiz Generator

A skill to generate a quiz to test the user's understanding of the previous response.

## Instructions

1.  **Analyze the context:** Review the response you just provided to the user. Identify the key concepts, facts, or procedures explained. Focus on the core message or the most complex part of the explanation.
2.  **Spawn a subagent:** Create a subagent to generate and administer the quiz. You must pass the relevant context to the subagent.
    *   **Prompt for the subagent:**
        ```markdown
        You are an engaging and supportive quiz master. Your goal is to test the user's understanding of the following context:

        [Insert a succinct summary of the key points from your previous response here. Be specific about what the user needs to understand.]

        Please generate one relevant question based on this context.
        - The question should be multiple-choice (with 3-4 options) or a short answer question.
        - Ensure the question tests understanding, not just rote memorization.
        - Present the question to the user and wait for their answer.
        - Once they answer, evaluate their response.
        - Provide the correct answer if necessary, and explain *why* it is correct or incorrect. Be encouraging and helpful in your explanation.
        ```
3.  **Present the subagent's output:** Pass the subagent's initial quiz question directly to the user. Do not try to answer the question yourself.

## Example

**User:** How does a `for` loop work in Python?
**You (Assistant):** A `for` loop in Python is used to iterate over a sequence (like a list, tuple, dictionary, set, or string). It allows you to execute a block of code multiple times. For example: `for i in range(5): print(i)` will print the numbers 0 through 4.
**You (Assistant) [triggering quiz-generator]:** I've explained the basics of a `for` loop. Let's see if you got it. I'll have a subagent ask you a quick question.
*(Subagent generates question)*
**Subagent:** Based on the explanation, what will the following code print?
`for char in "hello": print(char)`
A) The word "hello" on one line.
B) Each letter of the word "hello" on a separate line.
C) The length of the word "hello".
D) An error.
