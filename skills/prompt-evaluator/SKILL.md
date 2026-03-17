---
name: prompt-evaluator
description: Evaluate and score user-written LLM prompts on a 100-point scale across 5 axes (Clarity, Structure, Information Content, Specificity, Context), providing specific improvement suggestions and a revised prompt. Use when the user asks to evaluate, review, score, or improve a prompt, or when they say things like "このプロンプトどう？", "プロンプトを評価して", "rate my prompt", "review this prompt", or "is this prompt good enough?". This skill focuses on scoring existing prompts, not writing new ones from scratch.
---

# Prompt Evaluator

Evaluate LLM prompts on a 100-point scale based on research findings from Thorgeirsson et al. (2026), which demonstrated that writing quality—specifically coherence, instructional clarity, and information content—significantly predicts LLM-assisted programming performance.

## Key Research Insights

- **Information content > vocabulary**: Adding missing information improves results; rewording without adding information rarely helps (Lucchetti et al.)
- **Structure matters**: Unorganized, vague prompts lead to failure cycles
- **Declarative > interrogative**: Declarative statements outperform questions (Chen et al.)
- **Ambiguity kills**: Unclear pronouns, implicit assumptions, and missing constraints are top failure causes

## Evaluation Workflow

1. Receive the user's prompt
2. Read [references/evaluation-rubric.md](references/evaluation-rubric.md) for detailed scoring criteria
3. Score each of the 5 axes (4 sub-items × 5pt = 20pt per axis, 100pt total)
4. For common issues, consult [references/improvement-patterns.md](references/improvement-patterns.md) for Before/After examples
5. Output the evaluation result using the template below
6. Provide a revised prompt

## 5 Evaluation Axes

| # | Axis | Points | Focus |
|---|------|--------|-------|
| 1 | Clarity (明確性) | 20 | Unambiguous intent, no unclear references |
| 2 | Structure (構造) | 20 | Logical organization, appropriate segmentation |
| 3 | Information Content (情報量) | 20 | Sufficient detail for task completion |
| 4 | Specificity (特定性) | 20 | Concrete requirements, constraints, formats |
| 5 | Context (文脈提供) | 20 | Background, audience, purpose clearly stated |

## Output Template

ALWAYS use this format:

```
## プロンプト評価結果 / Prompt Evaluation

### 対象プロンプト
> [quote the evaluated prompt here]

### スコア

| 軸 / Axis | スコア | 主な所見 |
|-----------|--------|----------|
| 明確性 (Clarity) | __/20 | ... |
| 構造 (Structure) | __/20 | ... |
| 情報量 (Info Content) | __/20 | ... |
| 特定性 (Specificity) | __/20 | ... |
| 文脈提供 (Context) | __/20 | ... |
| **合計 / Total** | **__/100** | |

### 評価の概要
[1-2 paragraph summary of strengths and weaknesses]

### 改善提案
1. [specific, actionable suggestion]
2. [specific, actionable suggestion]
...

### 改善版プロンプト
[the improved prompt in a code block]
```

## Scoring Guidelines

- **0pt**: Sub-item is completely absent or counterproductive
- **1pt**: Minimal attempt, mostly insufficient
- **2-3pt**: Partially addressed, room for improvement
- **4pt**: Well addressed with minor gaps
- **5pt**: Excellent, no meaningful improvement needed

## Language Handling

- Evaluate prompts in any language (Japanese, English, etc.)
- Output the evaluation in the same language as the user's prompt
- Scoring criteria apply universally regardless of language
