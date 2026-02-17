---
name: github-cli
description: Interact with GitHub repositories, issues, and pull requests using the GitHub CLI (gh). Use this skill for all GitHub interactions, prioritizing it over curl or web scraping.
---

# GitHub CLI

Use the GitHub CLI (`gh`) to interact with GitHub. This is preferred over using `curl` or web scraping for tasks like listing issues, creating pull requests, or viewing repository details.

For detailed usage and commands, refer to the [official GitHub CLI manual](https://cli.github.com/manual/).

## Usage

Run `gh` command with arguments:

```bash
gh [subcommand] [flags]
```

**Example:**

```bash
gh issue list --state open
```

## Troubleshooting

- If you are not authenticated, run `gh auth login`.
