# Improvement Patterns

Common prompt problems and Before/After fixes. Use these patterns when suggesting improvements.

## Table of Contents

1. [Vague Instructions → Concrete Imperatives](#1-vague-instructions--concrete-imperatives)
2. [Missing Information → Context Addition](#2-missing-information--context-addition)
3. [Wall of Text → Structured Sections](#3-wall-of-text--structured-sections)
4. [Unbounded Scope → Explicit Constraints](#4-unbounded-scope--explicit-constraints)
5. [No Output Format → Format Specification](#5-no-output-format--format-specification)
6. [Implicit Assumptions → Explicit Context](#6-implicit-assumptions--explicit-context)

---

## 1. Vague Instructions → Concrete Imperatives

**Problem**: Using hedged, question-form, or abstract language.

**Before**:
```
Could you maybe help me make a good website?
```

**After**:
```
Create a single-page portfolio website with:
- A hero section with my name "Jane Doe" and tagline "UX Designer"
- A 3-column project grid showing 6 projects with thumbnail, title, and description
- A contact form with name, email, and message fields
Use a dark theme with #1a1a2e as the background color.
```

**Why it works**: Replaces vague request with concrete, enumerated requirements. Declarative statements outperform questions (Chen et al., 2025).

---

## 2. Missing Information → Context Addition

**Problem**: Expects the LLM to guess missing context. Research shows "rewording without adding information rarely helps" (Lucchetti et al.).

**Before**:
```
Write a function that processes the data.
```

**After**:
```
Write a Python function `normalize_scores(records: list[dict]) -> list[dict]` that:
- Input: list of dicts with keys "name" (str) and "score" (int, range 0-1000)
- Processing: normalize each score to a 0-100 float scale
- Output: same list with "score" replaced by "normalized_score" (float, 2 decimal places)
- Edge case: if the input list is empty, return an empty list
```

**Why it works**: Adds concrete input/output specs, types, edge cases—information the LLM needs.

---

## 3. Wall of Text → Structured Sections

**Problem**: Everything crammed into a single dense paragraph with no visual separation.

**Before**:
```
I need a meal planning app that lets users select meals for each day of the week and it should show nutritional information and also handle dietary restrictions like vegetarian and gluten-free and it should have a shopping list feature that aggregates ingredients and I want it to look nice with a modern design and be responsive on mobile too.
```

**After**:
```
Build a weekly meal planning web app.

## Core Features
1. Weekly calendar view (Mon-Sun) with meal slots (breakfast, lunch, dinner)
2. Meal selection from a predefined database
3. Nutritional summary per day (calories, protein, carbs, fat)

## Dietary Filters
- Support vegetarian, vegan, and gluten-free filters
- Apply filters globally or per-meal

## Shopping List
- Auto-generate an aggregated ingredient list from selected meals
- Group by category (produce, dairy, protein, etc.)

## Design
- Modern, responsive layout (mobile breakpoint: 768px)
- Use a clean card-based UI
```

**Why it works**: Logical grouping + hierarchy makes each requirement independently addressable.

---

## 4. Unbounded Scope → Explicit Constraints

**Problem**: No boundaries on what to produce, leaving the LLM to make arbitrary choices.

**Before**:
```
Tell me about machine learning.
```

**After**:
```
Write a 500-word introduction to supervised machine learning for a blog targeting junior developers (1-2 years experience). Cover:
1. What supervised learning is (2-3 sentences)
2. Three common algorithms (linear regression, decision trees, neural networks) with one real-world use case each
3. When NOT to use supervised learning (1 paragraph)

Do NOT cover: unsupervised learning, reinforcement learning, or mathematical derivations.
```

**Why it works**: Defines scope (what to include AND exclude), length, audience, and structure.

---

## 5. No Output Format → Format Specification

**Problem**: No indication of desired output shape, leading to unpredictable formatting.

**Before**:
```
Compare React and Vue.
```

**After**:
```
Compare React and Vue.js in a markdown table with these columns:
| Criteria | React | Vue.js | Winner |

Evaluate on these 5 criteria:
1. Learning curve
2. Performance (rendering speed)
3. Ecosystem size
4. TypeScript support
5. Community/job market

For each row, provide a 1-sentence justification in the cell. After the table, add a 2-sentence summary recommendation.
```

**Why it works**: Specifies exact format, criteria, and expected detail per cell.

---

## 6. Implicit Assumptions → Explicit Context

**Problem**: The user assumes the LLM knows their project, environment, or conventions.

**Before**:
```
Fix the login bug.
```

**After**:
```
## Context
- Tech stack: Next.js 14 (App Router), NextAuth.js v5, PostgreSQL
- The bug: After successful OAuth login via Google, users are redirected to /dashboard but see a 401 error. The session cookie IS being set (verified in DevTools).

## What I've Tried
- Cleared cookies and retried → same result
- Checked NextAuth callbacks in `auth.ts` → the `jwt` callback fires but `session` callback does not

## Expected Result
After Google OAuth login, user should land on /dashboard with their profile loaded.

## Request
Diagnose why the `session` callback isn't firing and provide the fix. Show the corrected code for `auth.ts`.
```

**Why it works**: Makes tacit knowledge explicit—tech stack, symptoms, what's been tried, and expected behavior.
