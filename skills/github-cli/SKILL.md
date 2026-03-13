---
name: github-cli
description: "Interact with GitHub repositories, issues, and pull requests using the GitHub CLI (gh). Make sure to use this skill whenever the user mentions GitHub, issues, pull requests, PRs, repositories, or any GitHub-specific feature, even if they don't explicitly mention 'gh' or 'cli'. Use this skill for all GitHub interactions, prioritizing it over curl or web scraping."
---

# GitHub CLI Guidelines

* **Use the GitHub CLI (`gh`)** for tasks like listing issues, creating pull requests, or viewing repository details.
* **Prefer `gh` over `curl` or web scraping.** The CLI is more robust and handles authentication natively.
* **If you are not authenticated, run `gh auth login`.**

## Examples

**Example 1: Listing issues**
Instead of using `curl` to fetch issues from the GitHub API, use the `gh` CLI:
```bash
gh issue list --state open --limit 10
```

**Example 2: Creating a pull request**
Instead of manually creating a PR via the web interface or API, use the `gh` CLI:
```bash
gh pr create --title "feat: add new feature" --body "This PR adds a new feature."
```

**Example 3: Viewing a specific issue or PR**
Instead of navigating to the GitHub URL or scraping the page, use the `gh` CLI to view the issue/PR details:
```bash
gh pr view 123
gh issue view 456
```
