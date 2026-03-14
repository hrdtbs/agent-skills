---
name: rust-best-practices
description: "Expert guidance for writing modern, idiomatic Rust code. Make sure to use this skill whenever the user asks to write, refactor, or debug Rust code, Cargo configurations, or when discussing ownership, borrowing, lifetimes, traits, generics, or async Rust."
---

# Rust Best Practices

This skill provides expert guidance for writing modern, idiomatic, and performant Rust code. You must adhere to the rules in this document and the accompanying guidelines whenever you are writing, refactoring, or debugging Rust code.

## Flow Control

When applying Rust best practices, you MUST follow this sequence:

1. **Read Domain Guidelines**: Before modifying or creating any Rust code, read `references/rust-guidelines.md` for specific rules on idiomatic Rust, error handling, traits, async, and project structure.
   - Use the `read_file` tool to load `skills/rust-best-practices/references/rust-guidelines.md`.

2. **Diagnose and Plan**:
   - Analyze the current code or request against the guidelines.
   - Plan your changes (e.g., using `Result` instead of `Option` for errors, leveraging `impl Trait`, or fixing borrow checker issues).

3. **Apply Guidelines**:
   - Write or refactor code according strictly to the guidelines.
   - Ensure the code follows the ownership model without over-cloning (e.g., avoid `clone()` unless explicitly justified).

4. **Verify**:
   - Run `cargo check` and `cargo fmt` to verify your changes. If there are clippy warnings, run `cargo clippy` and fix them.

## Core Directives

- **Idiomatic Code**: Always use standard Rust idioms (e.g., `?` operator, iterators over manual loops, `enum` for state).
- **Safety First**: Never use `unsafe` unless it is absolutely necessary and explicitly requested by the user. If you use it, you must add a `// SAFETY: ...` comment.
- **Error Handling**: Use `Result` and `Option` properly. Never use `.unwrap()` or `.expect()` in production code unless the invariant is mathematically guaranteed and explicitly documented with a comment.
- **Testing**: Follow idiomatic Rust testing patterns (`#[cfg(test)]` modules, `#[test]` attributes).

Always start by reading the guidelines in `references/rust-guidelines.md`!
