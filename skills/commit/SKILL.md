---
name: commit
description: Enforces Conventional Commits format when creating git commits. Use this skill whenever you need to create a commit message. Triggers on "commit", "git commit", "コミット", "変更をコミット".
---
* Format: Use Conventional Commits (`<type>[optional scope][optional !]: <description>`).
* Scope: Check recent commits (`git log --oneline -10`) for scope patterns.
* Breaking Changes: Add `!` before the colon or `BREAKING CHANGE:` in the footer.
* No Emojis: Do NOT use emojis in commit messages.
* Validation: Run `bash /mnt/skills/user/conventional-commit/scripts/validate-commit.sh "message"` before committing.
