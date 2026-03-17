# Evaluation Rubric

Detailed scoring criteria for the 5 evaluation axes. Each axis has 4 sub-items scored 0-5pt (max 20pt per axis, 100pt total).

## Table of Contents

1. [Clarity (明確性)](#1-clarity-明確性)
2. [Structure (構造)](#2-structure-構造)
3. [Information Content (情報量)](#3-information-content-情報量)
4. [Specificity (特定性)](#4-specificity-特定性)
5. [Context (文脈提供)](#5-context-文脈提供)

---

## 1. Clarity (明確性) — 20pt

Based on the finding that "miswordings that affected the semantics of a prompt did affect pass rates" and that prompts should be "stated simply" and "easy to understand" (IEEE Standard).

| Sub-item | 0-1pt | 2-3pt | 4-5pt |
|----------|-------|-------|-------|
| **1a. Intent uniqueness** — The prompt's goal can be interpreted in only one way | Multiple plausible interpretations exist | Some ambiguity remains but main intent is discernible | Single, unambiguous interpretation |
| **1b. Reference clarity** — No unclear pronouns, vague references, or dangling modifiers | Contains "it/this/that" with unclear antecedents | Most references are clear; one or two minor ambiguities | All references point to clearly identified entities |
| **1c. Terminology precision** — Word choices convey exact meaning without room for misinterpretation | Key terms are vague or used inconsistently | Most terms are appropriate; minor imprecision | All terms are precise and consistently used |
| **1d. Instruction directness** — Uses imperative/declarative statements rather than hedged or interrogative forms | Primarily questions or hedged language ("maybe you could...") | Mix of direct and indirect; mostly declarative | Clear, direct imperatives or declarative statements |

---

## 2. Structure (構造) — 20pt

Based on the finding that prompts are often "unorganized" and that structured writing predicts vibe-coding success.

| Sub-item | 0-1pt | 2-3pt | 4-5pt |
|----------|-------|-------|-------|
| **2a. Logical ordering** — Steps, requirements, or topics are arranged in a coherent sequence | Random or contradictory ordering | Mostly logical with some jumps | Clear, intuitive progression |
| **2b. Segmentation** — Related information is grouped; distinct topics are separated | Wall of text with no separation | Some grouping but inconsistent | Well-organized sections or paragraphs with clear boundaries |
| **2c. Hierarchy** — Main instruction is distinguishable from supporting details | All items presented at same level of importance | Some distinction but unclear priority | Clear primary objective with supporting details clearly subordinated |
| **2d. Formatting aids** — Uses lists, headings, markers, or line breaks to improve parsability | No formatting; dense prose | Some formatting but incomplete or inconsistent | Effective use of structural formatting to aid comprehension |

---

## 3. Information Content (情報量) — 20pt

Based on Lucchetti et al.'s finding that "information content, not technical vocabulary, best predicts success" and that "rewording without adding information rarely helps."

| Sub-item | 0-1pt | 2-3pt | 4-5pt |
|----------|-------|-------|-------|
| **3a. Completeness** — All information necessary for the LLM to fulfill the task is explicitly provided | Critical information is missing; LLM must guess | Most necessary info is present; some gaps | All task-critical information is included |
| **3b. Sufficiency of detail** — The level of detail matches the complexity of the task | Far too brief or far too verbose for the task | Roughly appropriate but uneven detail across parts | Detail level is calibrated to task complexity throughout |
| **3c. Example/evidence provision** — Includes examples, sample inputs/outputs, or reference material where helpful | No examples where they would significantly help | One example but more would clarify edge cases | Appropriate examples or references that cover typical and edge cases |
| **3d. Constraint coverage** — Explicitly states what to include AND what to exclude/avoid | No boundaries defined | Some constraints stated but key omissions remain | Both positive requirements and negative constraints are clearly specified |

---

## 4. Specificity (特定性) — 20pt

Based on the paper's emphasis that IEEE requires requirements to be "stated simply" with specific language guidance (NASA Handbook) to avoid "indefinite pronouns that could lead to misinterpretation."

| Sub-item | 0-1pt | 2-3pt | 4-5pt |
|----------|-------|-------|-------|
| **4a. Output format definition** — Specifies the expected format, structure, or shape of the response | No format guidance | Partial format guidance (e.g., "as a list" without detail) | Fully defined output format (structure, length, style, delimiters, etc.) |
| **4b. Quantitative criteria** — Uses measurable values instead of vague qualifiers | "Make it short/good/fast" with no numbers | Some quantification but key dimensions undefined | Concrete numbers, ranges, or thresholds where applicable |
| **4c. Scope boundaries** — Defines what is in scope and out of scope | Scope is unstated or unbounded | General scope stated but boundaries are fuzzy | Clear, explicit in-scope/out-of-scope definition |
| **4d. Success criteria** — Defines how to judge whether the output is correct or satisfactory | No acceptance criteria | Implicit or partial criteria | Explicit, verifiable success criteria |

---

## 5. Context (文脈提供) — 20pt

Based on the finding that "many non-experts lack robust strategies" and "import misleading assumptions from everyday conversation," highlighting the need for explicit context.

| Sub-item | 0-1pt | 2-3pt | 4-5pt |
|----------|-------|-------|-------|
| **5a. Background/purpose** — Explains WHY the task is needed or what problem it solves | No background provided | Some context but purpose remains unclear | Clear purpose statement that frames the task |
| **5b. Audience/persona** — Defines who will use the output or what role the LLM should assume | No audience or role specified | General audience implied but not explicit | Specific audience or LLM role clearly defined |
| **5c. Domain situation** — Provides relevant domain knowledge, technical environment, or prior state | Assumes the LLM shares unstated tacit knowledge | Some domain context but key assumptions remain implicit | All relevant domain context is explicitly provided |
| **5d. Constraints/preferences** — States any limitations, preferences, or standards to follow | No constraints mentioned | Some preferences stated loosely | Clear constraints (tone, style, technology, compliance, etc.) |
