---
name: create-pull-request
description: Create a GitHub pull request following project conventions. Use when the user asks to create a PR, submit changes for review, or open a pull request. Handles commit analysis, branch management, and PR creation using the gh CLI tool.
---

* Use the `gh` CLI (`gh pr create`) for consistency and proper context management.
* To keep branch names organized and recognizable, follow the branch naming convention: `type/issue-number-slug` or `type/slug` (e.g., `feat/123-add-login`, `fix/memory-leak`). Valid types include `feat`, `fix`, `docs`, `refactor`, `chore`.
* PR titles should follow the Conventional Commits format (e.g., `feat(auth): add OAuth2 login`) to ensure our changelogs and versioning remain accurate.
* **IMPORTANT**: Read and apply the PR template at `.github/pull_request_template.md` if it exists. Structuring the PR body to align with the template makes it easier for reviewers to understand your changes.
