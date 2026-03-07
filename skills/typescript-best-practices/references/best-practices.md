# TypeScript Best Practices

This document outlines key principles and guidelines for writing robust, type-safe, and maintainable TypeScript code.

## Types over Interfaces

When defining simple data structures, prefer using `type` aliases over `interface` for consistency and flexibility, especially when utilizing unions and intersections. However, use `interface` when defining contracts for objects and classes, or if you specifically need declaration merging.

## Strict Null Checks

Ensure `strictNullChecks` is enabled in your `tsconfig.json`. Always explicitly check for `null` or `undefined` before accessing properties or calling methods on potentially null values. Use optional chaining (`?.`) and nullish coalescing (`??`) to handle these cases safely and concisely.

## Avoid `any`

The `any` type completely disables type checking. Avoid using it whenever possible. If you truly don't know the type, use `unknown` instead. `unknown` forces you to perform type narrowing before you can perform operations on the value.

## Exhaustive Switch Statements

When using `switch` statements over discriminated unions or enums, ensure that all possible cases are handled. You can enforce this by using an exhaustive check.

```typescript
type Action = { type: 'START' } | { type: 'STOP' };

function reducer(action: Action) {
  switch (action.type) {
    case 'START':
      // Handle start
      break;
    case 'STOP':
      // Handle stop
      break;
    default:
      // This will cause a compile error if a new action type is added
      const _exhaustiveCheck: never = action;
      return _exhaustiveCheck;
  }
}
```

## Utility Types

Familiarize yourself with TypeScript's built-in utility types like `Partial<T>`, `Required<T>`, `Readonly<T>`, `Pick<T, K>`, and `Omit<T, K>`. These types can help reduce boilerplate and make your code more expressive.

## Type Inference

Let TypeScript infer types whenever possible. Redundant type annotations can clutter your code and make it harder to read. Annotate types only when necessary, such as function return types or when initializing complex objects.

## Generic Constraints

When using generics, restrict the acceptable types using constraints (`<T extends SomeType>`). This provides better type checking and allows you to access properties of the constrained type.
