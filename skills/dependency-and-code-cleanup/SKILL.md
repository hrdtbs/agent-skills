---
name: dependency-and-code-cleanup
description: Helps find and securely remove unused dependencies, dead code, and exports from projects. Use this skill when users ask to clean up the codebase, find dead code, or refactor unused packages and variables.
---

# Dependency and Code Cleanup

A comprehensive skill to analyze, identify, and securely remove unused dependencies, unused variables, dead code, and unused exports across the project codebase. It helps in maintaining a cleaner project architecture, optimizing builds, and reducing security vulnerabilities associated with unmaintained and unneeded packages.

## When to use this skill

Trigger this skill whenever the user asks to:
- Find and remove unused dependencies, packages, or libraries in their project.
- Find and remove dead code, unused variables, and unused exports.
- Clean up, refactor, or audit the project to eliminate stale parts.

## High-Level Workflow

Cleaning up a codebase properly requires precision and verification. Follow this structured approach:

1. **Analyze:** Identify the technology stack (e.g., Node.js/TypeScript, Python) and read the appropriate `references/` file to select the correct diagnostic tool.
2. **Execute Diagnostic:** Run the specific CLI tool configured to find unused code and dependencies.
3. **Verify:** Check the tool's output. **Always double-check manually** by grepping or searching across the codebase before deciding a dependency or code block is entirely unused. Certain tools may miss dynamically imported code, alias paths, or specific reflection patterns.
4. **Remove:** Proceed with removing the unused components:
    - Remove dependencies using the appropriate package manager (e.g., `npm uninstall`, `pip uninstall`).
    - Remove dead code or unused exports by editing the files.
5. **Test & Validation:** Run project builds, type checks, and test suites to verify that the removals did not break any functionality. **Never skip this step.**

## Environment Specific Guidance

This skill bundles specialized instructions for different technology stacks. Choose the one that matches the current project and read it immediately:

- **Node.js/TypeScript/JavaScript:** Read `references/nodejs.md`
- **Python:** Read `references/python.md`

*(If the project's language isn't supported by the included reference files, fallback to utilizing standard IDE-like tools or robust grep/find searches before manual removals).*
