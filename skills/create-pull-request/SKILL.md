---
name: create-pull-request
description: Create a GitHub pull request safely and reliably using project conventions. Make sure to use this skill whenever the user asks to create a PR, submit changes for review, open a pull request, or mentions "PR", "プルリク", or "pull request". It handles commit verification, branch validation, and PR creation using the gh CLI.
---

# Create Pull Request

This skill ensures pull requests are created correctly using the `gh` CLI, adhering to branch naming, commit formatting, and PR templates.

## Before Creating a PR (Pre-flight Checklist)

Before running `gh pr create`, please verify the state of the repository. Explain to the user why these checks are important for a clean Git history and smooth review process:
1. **Check uncommitted changes:** Are there uncommitted changes? (Run `git status`). If yes, ask the user if they want them committed or stashed.
2. **Review your own diff:** Do the changes match the PR intent? (Run `git diff main...HEAD` or similar). Avoid creating a PR without reviewing the diff so you can catch accidental inclusions like secrets or debug statements.
3. **Check the branch:** Are you on the correct branch? Ensure you are opening a PR from a feature branch rather than directly from `main` or `master` to prevent accidental merges of incomplete work.
4. **Push the branch:** Ensure the branch is pushed to the remote (`git push -u origin <branch-name>`) before creating the PR, otherwise the `gh` CLI will fail.

## Expected Output

When a user asks to create a PR, clearly state the steps you are taking to verify the state of the repository and the branch. Once checks are complete, provide the exact `gh pr create` command that will be executed, and wait for the user to confirm before proceeding.

## Branch & Title Conventions

- **Branch Naming**: Use `type/issue-number-slug` or `type/slug`.
  - *Valid Types*: `feat`, `fix`, `docs`, `refactor`, `chore`.
  - *Examples*: `feat/123-add-login`, `fix/memory-leak`.
- **PR Titles**: Follow the Conventional Commits format to ensure changelogs are accurate.
  - *Format*: `<type>[optional scope][optional !]: <description>`
  - *Example 1*: `feat(auth): add OAuth2 login`
  - *Example 2*: `fix(api): resolve race condition in user fetch`

## PR Body & Templates

**Important**: Please read and apply the PR template at `.github/pull_request_template.md` if it exists in the repository. Structuring the PR body to align with the template makes it easier for reviewers to understand your changes.

If no template exists, provide a clear, concise summary of:
1. What the PR does.
2. Why the change was made (the problem it solves).
3. Any testing steps or considerations for the reviewer.

## Common Pitfalls

- **Avoid vague PR titles** (e.g., "Update files", "Fix bug"). Reviewers and automated changelog generators need context immediately from the title. Follow Conventional Commits (e.g., `fix(auth): resolve token expiration issue`) so the intent is clear at a glance. This ensures maintainers quickly understand the scope of the change.
- **Do not skip or delete the PR template**. The template at `.github/pull_request_template.md` exists to capture required compliance, test coverage, or review checklists. Fill it out completely to reduce cognitive load for maintainers and speed up the review process.
- **Do not create a PR without reviewing the diff first** (e.g., via `git diff main...HEAD`). You must double-check the diff to avoid accidentally including debug statements (`console.log`, `print`), secrets (`.env` files), or completely unrelated files. This ensures your code is clean and safe.
- **Do not assume the target branch is `main` or `master` without checking**. Verify the base branch before opening a PR. Opening a PR against the wrong branch (e.g., a release branch instead of an integration branch) can cause confusing merge conflicts or accidental deployments. Ensure you are targeting the correct branch.

## Examples

**Example 1: Creating a pull request for a feature**
Input: I want to create a PR for my branch "feat/login" that adds the login page.
Output: First, check if there are uncommitted changes and push the branch if needed. Then run:
```bash
gh pr create --title "feat(auth): add login page" --body "## What the PR does\nAdds a new login page component to handle user authentication.\n\n## Why\nResolves issue #123 where users couldn't log in."
```

**Example 2: Creating a PR for a bug fix without a template**
Input: Open a PR for the memory leak fix.
Output:
```bash
gh pr create --title "fix(core): resolve memory leak in event listener" --body "Fixes a memory leak caused by not removing event listeners in the core module. Ensure to test by monitoring memory usage while spamming events."
```

## Command Reference

Use the `gh` CLI to create the PR:
```bash
gh pr create --title "feat(scope): your descriptive title" --body "Your descriptive body following the template"
```
