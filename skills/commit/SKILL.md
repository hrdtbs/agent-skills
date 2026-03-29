---
name: commit
description: "Expert-level commit creation and formatting following Conventional Commits. Make sure to use this skill whenever you need to create a commit message, save changes to git, structure a logical commit history, or when the user mentions 'commit', 'git commit', 'コミット', '変更をコミット', or asks you to push their code."
---

# Commit Best Practices

This skill ensures your commits are logical, atomic, and structured perfectly. A commit is not just a save point; it is a communication tool for future developers (and AI agents) to understand the *history* and *intent* of a codebase.

## 🧠 Mindset & Philosophy

- **Communicate Intent, Not Just Mechanics:** The code already tells us *what* changed. The commit message must tell us *why* it changed.
- **Atomic Commits:** A commit should do exactly one thing. If a commit fixes a bug AND adds a feature, it should be two commits. This makes reverting, rebasing, and reviewing significantly easier.
- **The Audience is the Future:** Write commit messages as if you are explaining the change to someone debugging an issue at 3 AM six months from now.

## 🚫 Anti-Patterns

- **Avoid describing what the code does in the body.** Do not write "I added an if statement on line 42." Write "Added a null check to prevent a crash when the user profile is missing."
- **Avoid using emojis in commit messages.** This ensures compatibility across all terminal environments and maintains a uniform, professional, greppable git history.
- **Avoid using vague subjects.** "Fix bug", "Update files", "WIP" are useless. They provide zero context when looking at `git log --oneline`.
- **Avoid bundling unrelated changes.** If you noticed a typo in `README.md` while working on the `auth` system, commit the typo fix separately from the `auth` feature.
- **Avoid committing without reviewing your own diff first.** Always run `git diff --cached` or review the staged changes to ensure no debugging statements (`console.log`, `print`) or secrets are accidentally included.

## 📝 Procedures & Workflow

Before creating a commit, follow these steps:

1. **Review the Diff:** What exactly are you committing? Are there unrelated changes?
2. **Determine the Type:** Select the most appropriate Conventional Commit type.
3. **Draft the Message:** Write the subject line, and if necessary, a detailed body explaining the *why*.
4. **Co-Authors:** Append `Co-authored-by:` for the AI Agent and the user at the end of the commit message body.
5. **Validate:** Verify your drafted message format against the requirements.

## 🏷️ Conventional Commits Format

**Format:** `<type>[optional scope][optional !]: <description>`

### Valid Types
- `feat`: A new feature
- `fix`: A bug fix
- `docs`: Documentation only changes
- `style`: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- `refactor`: A code change that neither fixes a bug nor adds a feature
- `perf`: A code change that improves performance
- `test`: Adding missing tests or correcting existing tests
- `build`: Changes that affect the build system or external dependencies
- `ci`: Changes to CI configuration files and scripts
- `chore`: Other changes that don't modify src or test files
- `revert`: Reverts a previous commit

### Subject Line Rules
- Keep the subject line to 50 characters or less to ensure it displays well in git tools.
- Use the imperative, present tense: "change" not "changed" nor "changes".
- Avoid capitalizing the first letter.
- Avoid placing a period at the end.

### Body Rules (Optional but Recommended for Complex Changes)
- Separate from the subject line by a single blank line.
- Wrap lines at 72 characters.
- Explain *what* and *why* vs. *how*.

### Breaking Changes
- Add `!` before the colon in the subject line (e.g., `feat(api)!: remove v1 endpoints`).
- Include `BREAKING CHANGE: <description>` at the very end of the body.

## 💡 Examples

**Example 1: New feature**
Input: Added user authentication with JWT tokens
Output:
```
feat(auth): implement JWT-based authentication
```

**Example 2: Bug fix with context**
Input: Fixed the crash that happens when the user clicks the login button twice
Output:
```
fix(login): resolve crash on double click

The login button was missing a debounce handler, allowing users to
submit multiple network requests. Added a 500ms debounce to prevent
race conditions during authentication.
```

**Example 3: Breaking change**
Input: Changed the API response for the `/users` endpoint to return an array of objects instead of a single object
Output:
```
feat(api)!: return array of objects from /users endpoint

BREAKING CHANGE: The `/users` endpoint now returns an array of user
objects instead of a single user object. Clients will need to update
their parsing logic.
```

## ✅ Validation

Before committing, validate your message format by running the included validation script. Ensure you locate it relative to the `SKILL.md` path or use `find` if unsure.

```bash
# Example assuming you are in the repo root:
bash skills/commit/scripts/validate-commit.sh "your commit message"
```