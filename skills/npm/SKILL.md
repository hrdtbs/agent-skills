---
name: npm
description: Best practices for managing Node.js dependencies. Use this skill when installing, updating, or auditing packages.
---

# npm Package Management

Guidelines for managing Node.js dependencies using `npm`.

## Core Principles

1.  **Respect the Lockfile**: `package-lock.json` is the source of truth for reproducible builds. Never delete it unless absolutely necessary.
2.  **Separate Dependencies**: Distinguish between runtime dependencies (`dependencies`) and development tools (`devDependencies`).
3.  **Security First**: Regularly audit dependencies, but review fixes carefully.

## Installation Commands

### Adding Dependencies

-   **Runtime**: Libraries required for the application to run in production (e.g., `react`, `express`, `lodash`).
    ```bash
    npm install <package-name>
    ```

-   **Development**: Tools needed only for development, testing, or building (e.g., `typescript`, `eslint`, `jest`, `@types/*`).
    ```bash
    npm install -D <package-name>
    ```
    *Note: Always use `-D` (or `--save-dev`) for types and build tools.*

### CI / Clean Install

When setting up a project in a new environment (CI pipeline, Docker build, or a fresh clone), use `ci` instead of `install`.

```bash
npm ci
```

-   **Why?**: `npm ci` strictly installs dependencies from `package-lock.json` without modifying it. If `package.json` and `package-lock.json` are out of sync, it will error instead of silently updating the lockfile.

## Security Audits

Check for vulnerabilities:

```bash
npm audit
```

### Fixing Vulnerabilities

-   **Safe Fix**:
    ```bash
    npm audit fix
    ```
    This updates compatible versions (semver-minor/patch).

-   **Dangerous Fix**:
    **Avoid** `npm audit fix --force` unless you have manually verified the breaking changes. It upgrades major versions which can break your application.

## Common Pitfalls

-   **Do NOT** use `sudo npm install`. If you need sudo, your permissions are configured incorrectly.
-   **Do NOT** install packages globally (`-g`) if they can be run with `npx`.
    -   *Bad*: `npm install -g create-react-app`
    -   *Good*: `npx create-react-app my-app`
-   **Do NOT** commit `node_modules`. Ensure it is in `.gitignore`.

## Scripts

Use `npm run` to execute scripts defined in `package.json`.

```bash
npm run <script-name>
```

Common scripts:
-   `npm start`: Start the application.
-   `npm test`: Run tests.
-   `npm run build`: Build for production.
-   `npm run lint`: Run linters.
