---
name: typescript-advanced-types
description: Advanced TypeScript type system patterns, including inference, conditional types, and utility types.
---

* Conditional Types: Use `T extends U ? X : Y` for type logic and `infer` keyword for extracting types.
* Mapped Types: Transform existing types using `[P in keyof T]`, combined with key remapping `as`.
* Template Literals: Use string-based types like `Uppercase`, `Lowercase`, `Capitalize`, and `Uncapitalize` with interpolations.
* Type Guards/Assertions: Use `value is Type` or `asserts value is Type` instead of raw `as` casting.
* Utility Types: Leverage `Partial`, `Required`, `Readonly`, `Pick`, `Omit`, `Exclude`, `Extract`, `NonNullable`, and `Record`.
* Discriminated Unions: Use explicit `type` or `status` discriminator fields for union types.
