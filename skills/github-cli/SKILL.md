---
name: github-cli
description: "Comprehensive interaction with GitHub repositories, issues, pull requests, and releases using the GitHub CLI (gh). Use this skill whenever the user mentions 'GitHub', 'issues', 'pull requests', 'PRs', 'repositories', 'forks', or needs any interaction with GitHub data, even if they don't explicitly mention 'gh' or 'cli'. This skill MUST be used for all GitHub interactions instead of web scraping or raw API calls."
---

# GitHub CLI Guidelines

You are an expert at interacting with GitHub through the official `gh` command-line interface.

## 🧠 Mindset & Philosophy

The GitHub CLI (`gh`) is your primary and ONLY interface for GitHub. The mindset here is **reliability and native integration**.
- **Context Awareness:** The CLI automatically knows which repository you are in based on `.git/config`. You don't need to specify `--repo` unless you are operating outside the current directory's context.
- **Authentication First:** Always ensure you are authenticated before attempting complex operations. If a command fails with an auth error, immediately run `gh auth status` to check your connection.
- **JSON Outputs:** `gh` commands support `--json` which is infinitely easier for you to parse than human-readable text. When you need to read data for further processing, ALWAYS use `--json`.

## 🚫 Anti-Patterns (NEVER Do These)

- **NEVER use `curl` to fetch from the GitHub API.** `gh` handles authentication, pagination, and rate-limiting automatically.
- **NEVER attempt to web scrape GitHub.** Do not use `lynx`, `curl`, or python scripts to read `github.com` URLs. Always translate the URL into the corresponding `gh` command (e.g., `gh issue view <url>`).
- **NEVER parse human-readable `gh` output when you need structured data.** If you need to extract specific fields (like the body of a PR, or the labels), use `--json` (e.g., `gh pr view 123 --json title,body,state`).
- **NEVER forget to handle pagination.** If you need more than the default limit (usually 30), explicitly use the `--limit` flag (e.g., `--limit 100`).
- **NEVER use interactive commands.** Commands that prompt for input (like `gh pr create` without arguments) will hang your session. Always provide all required arguments upfront.

## 🌳 Decision Tree & Workflows

Before taking action, identify the user's intent:

### 1. Reading Data (Issues, PRs, Repos)
* **Need an overview?** Use `gh issue list` or `gh pr list`.
  * *Expert tip:* Use `--state all` if you need closed items, as the default is `open`.
* **Need details on a specific item?** Use `gh issue view <number>` or `gh pr view <number>`.
  * *Expert tip:* To read comments, use `gh issue view <number> --comments`.
* **Need structured data to process programmatically?**
  * *Expert tip:* Use `gh pr view 123 --json title,body,author,commits` to get machine-readable output.

### 2. Creating/Modifying Data
* **Creating a PR?** Use `gh pr create`.
  * *Expert tip:* You must provide `--title` and `--body` or it will open an interactive prompt which will hang your session.
* **Adding a comment?** Use `gh pr comment <number> --body "My comment"`.
* **Reviewing a PR?** Use `gh pr review <number> --approve --body "LGTM"` or `--request-changes`.

### 3. Repository Management
* **Cloning?** Use `gh repo clone <owner>/<repo>`.
* **Checking checks/CI status?** Use `gh pr checks <number>`. This is crucial before merging.

## 📝 Concrete Examples

**Example 1: The Safe Data Extraction**
When asked: "What is the status of PR 45?"
**DO:** `gh pr view 45 --json state,isDraft,mergeable`
**DON'T:** `gh pr view 45` (and try to grep the text output)

**Example 2: Creating a Non-Interactive PR**
When asked: "Open a PR for my current branch"
**DO:** `gh pr create --title "feat: add new widget" --body "Implements widget API."`
**DON'T:** `gh pr create` (This will hang waiting for user input in nano/vim).

**Example 3: Reading a GitHub URL**
When the user says: "Can you summarize https://github.com/owner/repo/pull/123?"
**DO:** Extract the PR number and use `gh pr view 123 --comments`.
**DON'T:** Run `curl https://github.com/owner/repo/pull/123`.
