---
name: python-expert
description: A comprehensive master skill for modern Python development. Make sure to use this skill whenever the user asks to build, refactor, or debug Python applications, or mentions pytest, Ruff, uv, or standard Python best practices.
---

# Comprehensive Python Expert

This skill provides comprehensive guidelines and best practices for developing high-quality applications using Python. It emphasizes clear structure, modern tooling, and robust design patterns.

## Core Principles
1. **Explicit Typing:** Always use type annotations for function signatures (arguments and return types) and class attributes. Include explicit return types, even for `None`.
2. **Modular Design:** Keep the codebase organized by separating concerns into distinct modules (e.g., models, services, controllers, utilities).
3. **Comprehensive Testing:** Treat tests as first-class citizens. Write meaningful automated tests using `pytest` to ensure correctness and prevent regressions.
4. **Clean Code & Consistency:** Follow established Python styling rules (PEP 8) and use modern linters/formatters like `ruff` to enforce consistency.

## Project Structure & Naming
- Maintain a clean and logical directory structure:
  - `src/` for all source code.
  - `tests/` for all test cases.
  - `docs/` for project documentation.
  - `config/` for configuration files.
- Group related functionality into well-named directories (e.g., `src/models`, `src/services`, `src/utils`).
- Follow Python naming conventions: `snake_case` for variables, functions, and modules; `PascalCase` for classes; `UPPER_SNAKE_CASE` for constants.
- Include `__init__.py` in packages to make them importable, even in tests.

## Documentation & Comments
- Add descriptive docstrings to all Python functions, classes, and modules following PEP 257 conventions.
- Keep any existing comments that explain the *why* of the code.
- Ensure the root directory has a detailed `README.md` explaining the project, setup, and usage.

## Error Handling & Logging
- Implement robust error handling using `try/except` blocks.
- Use early returns (guard clauses) to handle error conditions at the beginning of functions, avoiding deeply nested conditional statements. Place the happy path last for readability.
- Avoid generic exceptions; use custom error types and structured error responses where appropriate (e.g., for APIs).
- Capture context in logs to aid debugging. Prefer structured logging libraries like `structlog`.

## Dependency & Configuration Management
- Manage dependencies and virtual environments using modern tools like `uv` (or `rye`). Avoid manual `pip` installs when a dedicated package manager is available.
- Isolate dependencies using virtual environments.
- Manage configuration using environment variables. Store sensitive information in `.env` files and load them using libraries like `python-dotenv` or `pydantic-settings`.

## Testing Rules
- **ONLY use `pytest`** or its plugins. Do not use the built-in `unittest` module.
- All tests should reside in the `./tests` directory and mirror the structure of the `src/` directory.
- Test functions must include typing annotations and docstrings.
- Ensure test coverage is high (aim for >80%). Use fixtures and parameterized tests to improve coverage and reduce boilerplate.
- For type checking in tests, ensure necessary types are imported appropriately (e.g., `from _pytest.capture import CaptureFixture`, `from pytest_mock.plugin import MockerFixture`).

## Anti-Patterns (NEVER Do These)
- **NEVER omit type hints or return types.**
  *Why:* It reduces code clarity and prevents static analysis tools from catching potential bugs early.
- **NEVER use deeply nested conditionals (`if/else` ladders) for error handling.**
  *Why:* It makes the code harder to read and maintain. Use guard clauses and early returns instead.
- **NEVER use `unittest` for writing new tests.**
  *Why:* `pytest` is the standard, offering more features, better assertion introspection, and less boilerplate.
- **NEVER hardcode sensitive configuration or credentials.**
  *Why:* It is a security risk and makes the application harder to deploy across different environments. Use environment variables.
