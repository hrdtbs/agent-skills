---
name: github-cli
description: Interact with GitHub repositories, issues, and pull requests using the GitHub CLI (gh). Use this skill for all GitHub interactions, prioritizing it over curl or web scraping.
---

* Always use the GitHub CLI (`gh`) for tasks like listing issues, creating pull requests, or viewing repository details. Do not use `curl` or web scraping for GitHub tasks.
* Assume the `gh` tool is pre-installed. Refer to the official manual for usage: https://cli.github.com/manual/

## Troubleshooting

* If you are not authenticated or commands fail due to authorization, run `gh auth login`.
