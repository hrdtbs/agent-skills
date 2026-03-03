---
name: plan-self-review
description: After a plan is created or updated with CreatePlan, self-evaluates it on a 100-point scale, lists deficiencies as a task list, improves the plan and any project design documents, and performs a final check for contradictions and omissions. Must be run in the same response immediately after CreatePlan; do not skip. Use when you have just called CreatePlan or updated a plan.
---
* Score Plan (100pt): Evaluate based on clarity (25), comprehensiveness (25), feasibility (25), and consistency (25).
* List Deficiencies: Create a prioritized task list (`- [ ]`) of gaps, omissions, or ambiguities.
* Improve: Edit the Plan and any other design documents (`DESIGN.md`, `docs/design.md`) to resolve deficiencies.
* Final Check: Confirm no logical contradictions or missing elements (scope, risks, dependencies).
