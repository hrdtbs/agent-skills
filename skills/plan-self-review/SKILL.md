---
name: plan-self-review
description: "Self-evaluate a plan on a 100-point scale after it is created or updated. Make sure to use this skill immediately whenever you create a plan or update a plan, even if the user does not explicitly ask for a review. This skill ensures that the plan is clear, comprehensive, feasible, and consistent before execution."
---

# Plan Self-Review

Use this skill immediately after creating or updating a plan. Do not skip this step.

## Review Steps

1. **Score Plan (100pt)**: Evaluate the plan based on the following criteria:
   - **Clarity (25)**: Are the steps clear and easy to follow?
   - **Comprehensiveness (25)**: Does the plan cover all necessary aspects of the task?
   - **Feasibility (25)**: Are the steps achievable with the available tools and context?
   - **Consistency (25)**: Are there any logical contradictions or missing elements?
2. **List Deficiencies**: Create a prioritized task list (`- [ ]`) of any gaps, omissions, or ambiguities found in the plan.
3. **Improve**: Edit the plan to resolve the identified deficiencies. Update the plan using the appropriate tool.
4. **Final Check**: Perform a final check to confirm no logical contradictions or missing elements remain.

## Output Format

Present your review using the following structure:

### Self-Evaluation Score: [Score]/100
- **Clarity**: [Score]/25
- **Comprehensiveness**: [Score]/25
- **Feasibility**: [Score]/25
- **Consistency**: [Score]/25

### Deficiencies
- [ ] [Deficiency 1]
- [ ] [Deficiency 2]

### Improvements Made
- [Briefly describe the improvements made to the plan]

### Final Check
- [Confirm that the plan is now logically sound and complete]
