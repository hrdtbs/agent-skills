---
name: go-best-practices
description: Apply comprehensive Go (Golang) best practices, idiomatic patterns, and project structure guidelines. Make sure to use this skill whenever the user asks for help with Go code, wants to write a new Go service, structure a Go repository, review Go code, implement concurrency, or generally mentions Go/Golang best practices.
---

# Go (Golang) Best Practices

When writing or reviewing Go code, adhere to these comprehensive best practices. Go is a language that values simplicity, readability, and explicitness. Following idiomatic Go patterns ensures your code is maintainable and accessible to other Go developers.

## 1. Code Formatting and Style

The Go community strongly favors a single, unified coding style.

- **gofmt**: All Go code MUST be formatted using `gofmt` (or `goimports`). Never deviate from the standard formatting. It eliminates formatting debates and makes all Go code look familiar.
- **Naming Conventions**:
  - Use `camelCase` for unexported variables and functions.
  - Use `PascalCase` for exported variables, functions, and types.
  - Keep variable names short and descriptive, especially for local variables (e.g., `i` for index, `r` for reader, `err` for error). Only use longer names for variables with a large scope.
  - Interface names should ideally end in `-er` (e.g., `Reader`, `Writer`, `Formatter`) if they contain a single method.
- **Package Names**: Short, concise, lowercase, and no `_` or `camelCase`. Package names should reflect their purpose (e.g., `http`, `fmt`, `json`).

## 2. Error Handling

Error handling in Go is explicit. It forces the developer to think about failure states.

- **Check Errors Immediately**: Always check errors where they occur. Do not silently ignore them using `_` unless you are absolutely certain it's safe and you document *why*.
  ```go
  // Good
  f, err := os.Open("file.txt")
  if err != nil {
      return fmt.Errorf("opening file: %w", err)
  }
  defer f.Close()
  ```
- **Contextual Errors**: Use `fmt.Errorf("...: %w", err)` to add context to errors as they bubble up the stack. This makes debugging much easier by providing a trace of what happened.
- **Don't Panic**: Avoid `panic` in normal application flow. Panics should only be used for truly unrecoverable errors (like out of memory or programmer error, e.g., accessing an out-of-bounds array index). Use `error` for normal error conditions.

## 3. Concurrency

Go's concurrency primitives (`goroutines` and `channels`) are powerful but must be used carefully to avoid leaks and race conditions.

- **See `references/concurrency.md`** for detailed rules on goroutine lifecycles, channel usage, and the `context` package.
- **Rule of Thumb**: "Don't communicate by sharing memory, share memory by communicating." Prefer channels over mutexes when coordinating data between goroutines, unless performance testing shows a mutex is required.

## 4. Testing

Testing is a first-class citizen in Go.

- **See `references/testing.md`** for guidance on table-driven tests, mocking, and the `testing` package.
- Write tests alongside your code (e.g., `calculator_test.go` for `calculator.go`).
- Use table-driven tests to cover multiple scenarios efficiently.

## 5. Project Structure

Go doesn't enforce a specific directory structure, but the community has settled on common patterns.

- **See `references/project-layout.md`** for the standard Go project layout.
- Use `cmd/` for executables, `internal/` for private application and library code, and `pkg/` (sparingly) for public library code.

## 6. Interfaces

- **Accept Interfaces, Return Structs**: Functions should accept interfaces to be more flexible, but return concrete structs. This prevents unnecessary abstraction and makes the code easier to use.
- **Define Interfaces Where Used**: Define the interface next to the code that *consumes* it, not the code that implements it. This keeps packages decoupled.

## 7. Pointers vs. Values

- Pass by value (structs) by default. It's safer and often faster due to how the Go compiler optimizes memory allocation (stack vs. heap).
- Use pointers when you need to mutate the receiver, or when the struct is very large and copying it would be a significant performance hit.
- Never return a pointer to an interface.

## Examples

### Good Error Handling

```go
func processFile(filename string) error {
    data, err := os.ReadFile(filename)
    if err != nil {
        return fmt.Errorf("failed to read input file %q: %w", filename, err)
    }

    if err := processData(data); err != nil {
        return fmt.Errorf("failed to process data from %q: %w", filename, err)
    }

    return nil
}
```

### Table-Driven Test Example

```go
func TestIsPrime(t *testing.T) {
    tests := []struct {
        name     string
        n        int
        expected bool
    }{
        {"negative", -1, false},
        {"zero", 0, false},
        {"one", 1, false},
        {"two", 2, true},
        {"prime", 7, true},
        {"non-prime", 10, false},
    }

    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            if got := IsPrime(tt.n); got != tt.expected {
                t.Errorf("IsPrime(%d) = %v; want %v", tt.n, got, tt.expected)
            }
        })
    }
}
```
