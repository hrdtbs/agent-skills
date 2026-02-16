---
name: github-cli
description: Interact with GitHub repositories, issues, and pull requests using the GitHub CLI (gh). Use this skill for all GitHub interactions, prioritizing it over curl or web scraping.
---

# GitHub CLI

Use the GitHub CLI (`gh`) to interact with GitHub. This is preferred over using `curl` or web scraping for tasks like listing issues, creating pull requests, or viewing repository details.

## How It Works

1.  The agent invokes the `gh.sh` script with standard `gh` arguments.
2.  The script executes the `gh` command and returns the output.

## Usage

```bash
bash /mnt/skills/user/github-cli/scripts/gh.sh [subcommand] [flags]
```

**Arguments:**
- `subcommand` - The `gh` subcommand (e.g., `issue list`, `pr create`, `repo view`).
- `flags` - Any flags or arguments for the subcommand.

**Examples:**

List open issues:
```bash
bash /mnt/skills/user/github-cli/scripts/gh.sh issue list --state open
```

View a specific issue:
```bash
bash /mnt/skills/user/github-cli/scripts/gh.sh issue view 1
```

Create a pull request:
```bash
bash /mnt/skills/user/github-cli/scripts/gh.sh pr create --title "My PR" --body "Description"
```

## Output

The output will be the standard stdout/stderr from the `gh` command.

## Troubleshooting

- If `gh` is not installed, the script will fail.
- Ensure authentication is set up (usually via `GITHUB_TOKEN` environment variable).
