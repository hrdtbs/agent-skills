# Node.js, TypeScript, and JavaScript Cleanup

When working with Node.js projects (including those using frameworks like React, Next.js, etc.), the JavaScript and TypeScript ecosystem provides several tools to help identify unused dependencies, exports, and dead code.

## 1. Finding Unused Code and Dependencies

The recommended tool for finding unused files, dependencies, and exports in JS/TS projects is **Knip**.

Knip provides advanced analysis starting from fine-grained entry points based on the actual frameworks and tooling in (mono)repos for accurate and actionable results.

### Using Knip

To run Knip using `npx` (which avoids global installations and uses the correct project context):

```bash
npx knip
```

Knip will typically output information regarding:
- Unused dependencies
- Unused devDependencies
- Unused files
- Unused exports and types

**Important Note on False Positives:** Tools like Knip may occasionally report false positives, particularly with dynamically imported modules, reflection, or certain framework-specific configurations. Always manually review the list before performing bulk removals. If Knip incorrectly flags a file or dependency, you can configure it via a `knip.json` or `knip.ts` file, or simply add `// @ts-ignore` or `// eslint-disable` style comments depending on the specific integration if necessary. However, verifying the usage directly via `grep` or `run_in_bash_session` searches is the best immediate verification strategy.

## 2. Removing Dependencies

Once you have verified that dependencies are genuinely unused, you should remove them using the project's package manager:

```bash
# If using npm
npm uninstall <package-name>

# If using yarn
yarn remove <package-name>

# If using pnpm
pnpm remove <package-name>
```

Always execute the removal via the package manager rather than manually deleting lines from `package.json`. This ensures lock files (`package-lock.json`, `yarn.lock`, etc.) and the `node_modules` directory are properly updated.

## 3. Removing Dead Code

When Knip or other tools identify unused exports or files:

1.  **Unused Files:** Verify they are not needed (e.g., aren't entry points the tool missed). If confirmed, use the system `rm` command or agent tools to delete them.
2.  **Unused Exports/Variables:** Edit the specific source code files to remove the unused code blocks. Ensure you also remove any associated imports that are no longer needed after deleting the code block.

## 4. Verification

After removing code and dependencies, **you must verify the project is not broken**.

Run the following commands based on the project's setup (usually found in `package.json` scripts):

```bash
# Example verification checks
npm run build
npm run test
npm run lint
```
If TypeScript is used, running `npx tsc --noEmit` is an excellent way to quickly check for compilation errors introduced by the cleanup.