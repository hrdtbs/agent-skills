---
name: better-auth-best-practices
description: Apply Better Auth integration best practices. Use when configuring or working with the Better Auth library.
---

* Setup: Define `BETTER_AUTH_SECRET` (min 32 chars) and `BETTER_AUTH_URL` in environment variables. Avoid defining `baseURL`/`secret` in `auth.ts` unless env vars are unset.
* File Location: Place `auth.ts` in `./`, `./lib`, `./utils`, or `./src`. Use `--config` flag for custom paths with the CLI.
* Schema Management: Run `npx @better-auth/cli@latest migrate` after any plugin changes.
* Health Check: Verify integration via `GET /api/auth/ok` (expected response: `{ status: "ok" }`).
