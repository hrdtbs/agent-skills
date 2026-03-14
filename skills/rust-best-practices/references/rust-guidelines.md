# Rust Guidelines

This file contains specific, actionable guidelines for writing modern, idiomatic Rust code. When the `rust-best-practices` skill is invoked, these rules strictly apply.

## 1. Error Handling

- **Use the `?` Operator**: Always propagate errors using the `?` operator instead of `match` or `unwrap` when the function returns a `Result` or `Option`.
- **Custom Error Types**: Implement custom error types for your library or application. Implement `std::error::Error`, `std::fmt::Display`, and use `thiserror` (for libraries) or `anyhow` (for applications) to simplify error handling.
- **Never panic in production**: Do not use `.unwrap()`, `.expect()`, `panic!()`, `unreachable!()`, or `todo!()` in production logic unless there is a mathematically proven invariant. Document such invariants clearly above the panic. Provide sensible fallbacks or return a `Result`.

## 2. Ownership and Borrowing

- **Avoid `.clone()` default**: Do not randomly sprinkle `.clone()` to appease the borrow checker. If the compiler complains, rethink the data flow. Use lifetimes, borrowing (e.g., `&T`, `&mut T`), or reference counting (`Rc`, `Arc`) intelligently.
- **Prefer References over Owned Values in Arguments**: Functions should take references (`&T`, `&[T]`, `&str`) instead of owned values (`T`, `Vec<T>`, `String`) unless they explicitly need to consume the value or transfer ownership.
- **Strings**: Use `&str` for function arguments instead of `&String`. Use `String` only when you need an owned, mutable, growable string.

## 3. Data Structures and Traits

- **Enums for State**: Use `enum` to represent state machines or mutually exclusive types. Leverage Rust's exhaustive pattern matching (`match`) to handle all states.
- **Derive Traits**: Aggressively derive standard traits like `Debug`, `Clone`, `PartialEq`, `Eq`, `Hash`, `Serialize`, and `Deserialize` (when using `serde`) on your `struct`s and `enum`s unless a custom implementation is required.
- **`impl Trait`**: Use `impl Trait` for arguments and return types where appropriate to keep signatures clean and avoid unnecessary dynamic dispatch (`Box<dyn Trait>`). Use dynamic dispatch only when heterogenous collections are needed.
- **`Default` trait**: Implement `Default` instead of a zero-argument `new()` method. However, providing a `new()` method for initialization is still idiomatic if it takes arguments.

## 4. Iterators and Loops

- **Prefer Iterators**: Use iterator methods (`.map()`, `.filter()`, `.fold()`, `.collect()`) over manual `for` and `while` loops whenever possible. They are often more readable and idiomatic.
- **Avoid `.clone()` in iterators**: Be mindful of `.cloned()` or `.copied()` on iterators; use them only when necessary to convert references to owned values.

## 5. Async Rust

- **Avoid blocking in async**: Never perform blocking I/O (e.g., `std::fs`, `std::thread::sleep`, blocking HTTP clients) inside an `async` block. Use the async equivalents provided by the runtime (e.g., `tokio::fs`, `tokio::time::sleep`).
- **Send + Sync**: Be aware of `Send` and `Sync` bounds for async tasks. If passing data across threads/tasks, use `Arc<T>` or `Arc<Mutex<T>>` (from the async runtime, e.g., `tokio::sync::Mutex`, not `std::sync::Mutex` across await points).
- **Spawn wisely**: Use `tokio::spawn` (or your runtime's equivalent) for background tasks, but ensure they are awaited or joined if their results or completion are required.

## 6. Project Structure and Tooling

- **Module System**: Organize code into logical modules. Use `mod name;` to declare modules, and place implementation in `name.rs` or `name/mod.rs`. Use visibility modifiers (`pub(crate)`, `pub`) carefully to encapsulate implementation details.
- **Clippy**: Code must pass `cargo clippy` without warnings. Address warnings by fixing the code, or occasionally by adding `#[allow(clippy::lint_name)]` with a comment explaining why it is a false positive.
- **Formatting**: Code must follow the standard Rust format (`cargo fmt`). Do not apply custom formatting styles.

## 7. Testing

- **Unit Tests**: Place unit tests in a `tests` module within the same file as the code they test, annotated with `#[cfg(test)]`.
- **Integration Tests**: Place integration tests in the `tests/` directory at the project root.
- **Test setup**: Use descriptive names for test functions (`fn test_user_can_login()`).
