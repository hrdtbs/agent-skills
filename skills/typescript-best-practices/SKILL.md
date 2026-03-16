---
name: typescript-best-practices
description: "Expert guidance for writing modern, strictly-typed TypeScript code. Make sure to use this skill whenever the user asks to write, refactor, or review TypeScript code, tsconfig setups, or when discussing advanced type safety, generics, discriminated unions, exhaustive checks, runtime validation, or avoiding any/as in TypeScript."
---

# TypeScript Best Practices

This skill provides expert guidance for writing modern (5.x+), scalable, and type-safe TypeScript code. Adhere strictly to these rules whenever you write, refactor, or review TypeScript code.

## Flow Control

When applying TypeScript best practices, you MUST follow this sequence:

1. **Read Domain Guidelines**: Before modifying or creating any TypeScript code, read `references/typescript-guidelines.md` for specific rules on modern TypeScript features, type safety, discriminated unions, runtime validation, and project configuration.
   - Use the `read_file` tool to load `skills/typescript-best-practices/references/typescript-guidelines.md`.

2. **Diagnose and Plan**:
   - Analyze the current code or request against the strict guidelines.
   - Plan your changes (e.g., eliminating `any`, removing unnecessary type assertions (`as`), applying `zod` for API boundaries, converting enums to literal unions, using `satisfies`, etc.).

3. **Apply Guidelines**:
   - Write or refactor code strictly according to the guidelines.
   - Ensure the code takes full advantage of advanced TS features like Discriminated Unions and Exhaustive Matching, avoiding runtime type errors.

4. **Verify**:
   - Verify that your types correctly infer what you intend.
   - If writing components or application code, ensure that strict null checks and boundary validations (e.g., `Zod`) are correctly implemented.

## Core Directives

- **Absolute Type Safety**: Never use `any`. Use `unknown` if the type is truly not known ahead of time, and properly narrow it down using type guards or runtime validation (e.g., Zod).
- **Avoid Type Assertions**: Avoid `as Type` whenever possible. Rely on type inference, type guards, and the `satisfies` operator instead of asserting types, which can hide errors.
- **Enums vs. Literal Unions**: Prefer string literal unions (`type Status = "idle" | "loading" | "error"`) over `enum`. They are simpler, result in cleaner output, and integrate perfectly with standard JS.
- **Exhaustive Matching**: Always use exhaustive checks (e.g., `never` return types) when dealing with discriminated unions to ensure all cases are handled.
- **Runtime Validation**: TypeScript only exists at compile-time. For external inputs (APIs, files, user input), always use runtime validation libraries like Zod or Valibot to guarantee type safety at runtime.

Always start by reading the guidelines in `references/typescript-guidelines.md`!
