# Testing in Go

Go's built-in testing framework is powerful and emphasizes simplicity. It encourages developers to write tests as part of the daily workflow rather than an afterthought.

## Test Structure

- **File Naming**: Test files must end with `_test.go` and be located in the same directory as the package they test. This ensures they only compile when running `go test`.
- **Function Naming**: Test functions must begin with `Test` followed by a capitalized letter (e.g., `TestCalculateTotal`).
- **Signature**: The function signature must be `func(t *testing.T)`.
- **Subtests (`t.Run`)**: Use `t.Run("name", func(t *testing.T) { ... })` to group related tests or iterations within table-driven tests. This provides granular reporting and allows running specific subtests via the command line.
- **Failures**: Use `t.Errorf(...)` or `t.Fatalf(...)`. `Errorf` continues execution of the test function, useful for reporting multiple errors. `Fatalf` stops the test function immediately.

## Table-Driven Tests

Table-driven testing is the standard Go idiom for unit tests. It allows for concise and comprehensive coverage by separating test logic from test data.

- **Structure**: Define an anonymous struct inside the test function containing input and expected output fields, plus a name for the subtest.
- **Iteration**: Iterate over a slice of these structs, running `t.Run` for each.
- **Why**: It makes adding new edge cases trivial without copying and pasting test setup logic.

### Table-Driven Test Example

```go
func TestAdd(t *testing.T) {
    tests := []struct {
        name     string
        a, b     int
        expected int
    }{
        {"positive numbers", 2, 3, 5},
        {"negative numbers", -2, -3, -5},
        {"mixed numbers", -2, 3, 1},
        {"zero", 0, 5, 5},
    }

    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            result := Add(tt.a, tt.b)
            if result != tt.expected {
                t.Errorf("Add(%d, %d) = %d; want %d", tt.a, tt.b, result, tt.expected)
            }
        })
    }
}
```

## Test Coverage

- **`go test -cover`**: Use this command to see the percentage of code covered by tests.
- **`go test -coverprofile=coverage.out`**: Generates a coverage report.
- **`go tool cover -html=coverage.out`**: Opens the report in a browser, highlighting exactly which lines were executed during the tests.

## Mocking and Dependencies

- **Interfaces for Mocking**: Instead of relying on heavy mocking frameworks, design your code using interfaces. This makes substituting real implementations with mock ones for testing straightforward.
- **Mock Implementations**: Create concrete structs in your `_test.go` files that implement the required interfaces.
- **`httptest` Package**: Use the standard library `net/http/httptest` package to test HTTP handlers and clients without spinning up real network listeners.
  - `httptest.NewServer`: Starts a local HTTP server for testing clients.
  - `httptest.NewRecorder`: Records HTTP responses for testing handlers.

## Test Setup and Teardown

- **`t.Cleanup`**: Use `t.Cleanup(func() { ... })` instead of `defer` inside tests for teardown logic. `t.Cleanup` runs even if `t.Fatalf` or `panic` occurs, ensuring resources (like temporary files or database connections) are reliably cleaned up.
- **TestMain**: For package-level setup (like initializing a test database), define a `TestMain(m *testing.M)` function. It allows you to run setup code before any tests and teardown code after all tests finish. Call `os.Exit(m.Run())` to execute the tests.
