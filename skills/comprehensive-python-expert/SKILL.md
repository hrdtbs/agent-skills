---
name: comprehensive-python-expert
description: A comprehensive master skill for modern Python development. Trigger this skill whenever the user asks to build, refactor, review, or debug Python applications, APIs (FastAPI), CLIs, or mentions modern Python practices like type hints, async/await, or modern tooling like uv, Ruff, and pytest.
---

# Comprehensive Python Expert

This skill provides comprehensive guidelines and best practices for developing high-quality, scalable, and modern applications using Python. It is designed to enforce consistency, performance, and maintainability across all Python projects, with a special emphasis on FastAPI and Pydantic for APIs.

## Core Principles

1. **Modern Python Versions:** Target Python 3.10+ (preferably 3.12+). Leverage modern features like structural pattern matching (`match`/`case`), union types (`X | Y`), and modern standard libraries.
2. **Type Hinting Everywhere:** Use strict static typing for all function signatures, return types, and complex variables. Use `mypy` or `pyright` to enforce type safety.
3. **Modern Tooling:** Prefer modern, fast tools. Use `uv` for dependency management and virtual environments. Use `ruff` for linting and formatting (replacing flake8, black, isort). Use `pytest` for testing.
4. **Clean Code & Functional Patterns:** Write modular, declarative, and readable code. Favor pure functions and immutable data structures where appropriate. Avoid unnecessary object-oriented overhead (e.g., classes with only static methods). Use the Receive an Object, Return an Object (RORO) pattern.

## Project Structure & Naming

- Use lowercase with underscores (`snake_case`) for modules, variables, function names, and directories (e.g., `routers/user_routes.py`).
- Use `PascalCase` for class names and Pydantic models.
- Use `UPPER_SNAKE_CASE` for constants.
- Organize projects by feature/domain. A standard layout might include:
  - `src/domain_name/` for the main code.
  - `routers/`, `services/`, `models/`, `schemas/` sub-directories per domain.
  - `tests/` for the test suite.
  - `pyproject.toml` for configuration and dependencies.

## Data and State

- Use `dataclasses` or `pydantic` v2 models for structured data, input validation, and configuration. Prefer Pydantic over raw dictionaries.
- Avoid global mutable state.
- Handle state and configuration explicitly by passing objects, rather than relying on hidden global variables.

## Error Handling

- Use specific, built-in exception types (`ValueError`, `TypeError`) or define custom exceptions subclassing `Exception`.
- Use `try/except` blocks tightly wrapped around the code that can actually raise the exception.
- Use context managers (`with` statement) for managing resources like files, network connections, and database sessions.
- In FastAPI, model expected errors as specific HTTP responses and use `HTTPException` for them. Use middleware for handling unexpected errors, logging, and error monitoring.

## Async and Concurrency

- Use `asyncio` for all I/O-bound tasks (network requests, database queries).
- Use `async`/`await` syntax correctly. Use `def` for synchronous, pure functions and `async def` for asynchronous operations.
- Minimize blocking I/O operations. Avoid mixing synchronous and asynchronous code without explicit bridges (like `asyncio.to_thread` or `run_in_executor`).
- For CPU-bound tasks, use `concurrent.futures.ProcessPoolExecutor` or `multiprocessing`.

## API Development with FastAPI

- **Declarative Routes:** Use declarative route definitions with clear return type annotations.
- **Dependency Injection:** Leverage FastAPI's dependency injection system for database sessions, authentication, and shared logic.
- **Lifespan Events:** Minimize `@app.on_event("startup")` and `@app.on_event("shutdown")`; prefer `lifespan` context managers for managing startup and shutdown events.
- **Caching & Serialization:** Implement caching for static/frequently accessed data. Optimize data serialization and deserialization with Pydantic. Use lazy loading techniques for large datasets.

## Anti-Patterns (NEVER Do These)

- **NEVER use bare `except:` blocks.**
  *Why:* It catches `SystemExit` and `KeyboardInterrupt`, making it difficult to stop the program, and hides real bugs like `NameError` or `SyntaxError`. Always catch specific exceptions.
- **NEVER use mutable default arguments (like `def func(lst=[]):`).**
  *Why:* The default list is instantiated only once when the function is defined, causing it to be shared across all calls that use the default, leading to subtle bugs. Always use `None` and initialize inside the function (e.g., `lst = lst or []`).
- **NEVER ignore type checking.**
  *Why:* Static types provide invaluable documentation, catch bugs early, and improve IDE support. Avoid using `Any` where a stricter type can be inferred.
- **NEVER manually format strings using `%` or `.format()` if you can use f-strings.**
  *Why:* F-strings (`f"Hello {name}"`) are faster, more readable, and standard practice in modern Python.
- **NEVER use blocking functions in an `async def` route without offloading to a thread.**
  *Why:* It blocks the entire event loop, destroying the concurrency and performance benefits of asynchronous frameworks like FastAPI.
