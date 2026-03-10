---
name: commit
description: Enforces Conventional Commits format when creating git commits. Make sure to use this skill whenever you need to create a commit message or save changes to git, such as when the user mentions "commit", "git commit", "コミット", "変更をコミット", or asks you to push their code.
---

* Format: Use Conventional Commits (`<type>[optional scope][optional !]: <description>`).
* Breaking Changes: Add `!` before the colon or `BREAKING CHANGE:` in the footer.
* No Emojis: Please avoid using emojis in commit messages. This ensures compatibility across various terminal environments and maintains a uniform, professional git history that is easy to read.
* Validation: Run `bash /mnt/skills/user/commit/scripts/validate-commit.sh "message"` before committing to verify the format.

## Commit message format

**Example 1: New feature**
Input: Added user authentication with JWT tokens
Output: feat(auth): implement JWT-based authentication

**Example 2: Bug fix**
Input: Fixed the crash that happens when the user clicks the login button twice
Output: fix(login): resolve crash on double click

**Example 3: Breaking change**
Input: Changed the API response for the `/users` endpoint to return an array of objects instead of a single object
Output: feat(api)!: return array of objects from /users endpoint

BREAKING CHANGE: The `/users` endpoint now returns an array of user objects instead of a single user object. Clients will need to update their parsing logic.
