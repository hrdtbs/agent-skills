# TypeScript Guidelines

These guidelines define the gold standard for writing modern, strictly-typed TypeScript code. You must adhere to these rules whenever you write or refactor TypeScript code.

## 1. Type Safety & Primitives

### Never Use `any`
`any` completely disables type checking, negating the purpose of using TypeScript.
*   **Do not** use `any`.
*   If the shape of the data is truly unknown, use `unknown` and rely on type guards, validation libraries, or the `in` operator to safely narrow the type.

```typescript
// BAD
function process(data: any) {
  console.log(data.value); // No error, but can crash at runtime
}

// GOOD
function process(data: unknown) {
  if (data && typeof data === "object" && "value" in data) {
    console.log(data.value); // Safely narrowed
  }
}
```

### Avoid Type Assertions (`as`)
Using `as Type` overrides the compiler and hides potential type errors when the underlying code changes.
*   Avoid asserting types unless absolutely necessary (e.g., specific DOM element selections).
*   Prefer type guards, type predicates (`value is Type`), and the `satisfies` operator to validate types without hiding errors.

### Use the `satisfies` Operator
When you want to ensure an object matches a specific type but want to retain its exact literal type information, use `satisfies`.

```typescript
type Config = Record<string, string | number>;

// BAD: Type is widened to Config, losing the literal shape
const config1: Config = { timeout: 1000, host: "localhost" };
// config1.timeout is string | number

// GOOD: Type is checked against Config, but exact literal types are retained
const config2 = { timeout: 1000, host: "localhost" } satisfies Config;
// config2.timeout is strictly number
```

### Literal Unions over Enums
Enums in TypeScript come with historical baggage, non-standard JavaScript output, and confusing behavior (e.g., numeric enums).
*   **Always prefer** String Literal Unions for defining sets of permitted values.
*   If you need to iterate over the values or use them as a source of truth, define a constant array `as const` and infer the type from it.

```typescript
// BAD
enum Status { Idle, Loading, Error }

// GOOD
type Status = "idle" | "loading" | "error";

// ALSO GOOD (if you need the values at runtime)
const STATUSES = ["idle", "loading", "error"] as const;
type Status = typeof STATUSES[number];
```

## 2. Advanced Types & Flow Control

### Discriminated Unions
When a value can be one of several different shapes, use a Discriminated Union. This relies on a shared literal property (usually `type` or `kind`) to allow TypeScript to narrow the union to the specific branch.

```typescript
type Result<T, E = Error> =
  | { success: true; data: T }
  | { success: false; error: E };

function handleResult(result: Result<string>) {
  if (result.success) {
    // TypeScript knows this is the success branch
    console.log(result.data.toUpperCase());
  } else {
    // TypeScript knows this is the error branch
    console.error(result.error.message);
  }
}
```

### Exhaustive Pattern Matching
When using discriminated unions (or literal unions), always use exhaustiveness checking to ensure every case is handled. This prevents bugs when a new type is added to the union later.
*   Use a `never` assignment in the `default` case of a `switch` statement or at the end of an `if/else` chain.

```typescript
type Shape =
  | { kind: "circle"; radius: number }
  | { kind: "square"; sideLength: number };

function getArea(shape: Shape) {
  switch (shape.kind) {
    case "circle":
      return Math.PI * shape.radius ** 2;
    case "square":
      return shape.sideLength ** 2;
    default:
      // This will cause a compile-time error if a new shape is added
      // but not handled in this switch statement.
      const _exhaustiveCheck: never = shape;
      return _exhaustiveCheck;
  }
}
```

### Type Narrowing and Predicates
When checking if an `unknown` or union type is a specific type, encapsulate the logic in a Custom Type Predicate function.

```typescript
function isString(value: unknown): value is string {
  return typeof value === "string";
}

const values = ["a", 1, "b", 2];
// TypeScript correctly infers `strings` as `string[]` instead of `(string | number)[]`
const strings = values.filter(isString);
```

## 3. Data Boundaries and Runtime Validation

TypeScript only exists at compile time. It provides **zero** protection against malicious or malformed data arriving at runtime (from API responses, form inputs, local storage, etc.).

*   **Always** validate data at the edges of your application using a runtime schema validation library like **Zod** or **Valibot**.
*   Derive your TypeScript types from the runtime schemas to ensure a single source of truth.

```typescript
import { z } from "zod";

// 1. Define the runtime schema
const UserSchema = z.object({
  id: z.string().uuid(),
  name: z.string().min(1),
  email: z.string().email(),
  role: z.enum(["admin", "user"]).default("user"),
});

// 2. Derive the TypeScript type from the schema
type User = z.infer<typeof UserSchema>;

// 3. Validate external data safely
async function fetchUser(id: string): Promise<User> {
  const response = await fetch(`/api/users/${id}`);
  const data = await response.json();

  // parse() will throw if the data is invalid.
  // safeParse() returns a result object you can check instead of throwing.
  return UserSchema.parse(data);
}
```

## 4. Modern Configuration (tsconfig.json)

For modern Node.js or browser applications, ensure your `tsconfig.json` enforces strictness to catch bugs early.

```json
{
  "compilerOptions": {
    /* Base Options */
    "target": "ES2022",
    "module": "NodeNext",
    "moduleResolution": "NodeNext",
    "lib": ["ES2022", "DOM", "DOM.Iterable"],

    /* Strictness */
    "strict": true,
    "noImplicitAny": true,
    "strictNullChecks": true,
    "strictFunctionTypes": true,
    "strictBindCallApply": true,
    "strictPropertyInitialization": true,
    "noImplicitThis": true,
    "useUnknownInCatchVariables": true,

    /* Advanced Strictness */
    "exactOptionalPropertyTypes": true,
    "noUncheckedIndexedAccess": true,
    "noImplicitOverride": true,
    "noFallthroughCasesInSwitch": true,
    "noImplicitReturns": true,

    /* Interop & Emit */
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true
  }
}
```

*   `"strict": true` is non-negotiable.
*   `"noUncheckedIndexedAccess": true` is highly recommended. It forces you to handle `undefined` when accessing arrays or records (`Record<string, T>`), which prevents a massive category of runtime errors.

## 5. Generics

Use Generics to build reusable, type-safe functions and components. Ensure you provide proper constraints to your generic type parameters.

```typescript
// The constraint `extends { id: string }` ensures that only objects
// with an `id` string property can be passed to this function.
function getById<T extends { id: string }>(items: T[], id: string): T | undefined {
  return items.find(item => item.id === id);
}
```
