---
name: create-pull-request
description: Create a GitHub pull request following project conventions. Use when the user asks to create a PR, submit changes for review, or open a pull request. Handles commit analysis, branch management, and PR creation using the gh CLI tool.
---

* Always use the `gh` CLI (`gh pr create`).
* Branch Naming Convention: `type/issue-number-slug` or `type/slug` (e.g., `feat/123-add-login`, `fix/memory-leak`). Valid types: `feat`, `fix`, `docs`, `refactor`, `chore`.
* PR titles MUST follow Conventional Commits format (e.g., `feat(auth): add OAuth2 login`).
* **IMPORTANT**: Read and use the PR template at `.github/pull_request_template.md` if it exists. The PR body format must **strictly match** the template structure.
