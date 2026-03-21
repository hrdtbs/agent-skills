---
name: create-pull-request
description: Create a GitHub pull request safely and reliably using project conventions. Make sure to use this skill whenever the user asks to create a PR, submit changes for review, open a pull request, or mentions "PR", "プルリク", or "pull request". It handles commit verification, branch validation, and PR creation using the gh CLI.
---

# Create Pull Request

This skill ensures pull requests are created correctly using the `gh` CLI, adhering to branch naming, commit formatting, and PR templates.

## Before Creating a PR (Pre-flight Checklist)

Before running `gh pr create`, you must verify the state of the repository:
1. **Check uncommitted changes:** Are there uncommitted changes? (Run `git status`). If yes, ask the user if they want them committed or stashed.
2. **Review your own diff:** Do the changes match the PR intent? (Run `git diff main...HEAD` or similar). Never create a PR blindly.
3. **Check the branch:** Are you on the correct branch? Never open a PR from `main` or `master` to `main` or `master`.
4. **Push the branch:** Ensure the branch is pushed to the remote (`git push -u origin <branch-name>`) before creating the PR.

## Branch & Title Conventions

- **Branch Naming**: Use `type/issue-number-slug` or `type/slug`.
  - *Valid Types*: `feat`, `fix`, `docs`, `refactor`, `chore`.
  - *Examples*: `feat/123-add-login`, `fix/memory-leak`.
- **PR Titles**: Must follow the Conventional Commits format to ensure changelogs are accurate.
  - *Format*: `<type>[optional scope][optional !]: <description>`
  - *Example 1*: `feat(auth): add OAuth2 login`
  - *Example 2*: `fix(api): resolve race condition in user fetch`

## PR Body & Templates

**IMPORTANT**: You must read and apply the PR template at `.github/pull_request_template.md` if it exists in the repository. Structuring the PR body to align with the template makes it easier for reviewers to understand your changes.

If no template exists, provide a clear, concise summary of:
1. What the PR does.
2. Why the change was made (the problem it solves).
3. Any testing steps or considerations for the reviewer.

## Anti-Patterns (NEVER List)

- **NEVER create a PR with a vague title** (e.g., "Update files", "Fix bug"). Reviewers need context immediately from the title.
- **NEVER ignore the PR template**. The template is there to capture required compliance or review checklists. Skipping it annoys maintainers.
- **NEVER push and PR without reviewing the diff**. You might accidentally include debug statements, `.env` files, or unrelated changes.
- **NEVER guess the base branch**. If not `main` or `master`, confirm the target branch with the user.

## Command Reference

Use the `gh` CLI to create the PR:
```bash
gh pr create --title "feat(scope): your descriptive title" --body "Your descriptive body following the template"
```
