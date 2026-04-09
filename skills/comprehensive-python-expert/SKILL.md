---
name: comprehensive-python-expert
description: A comprehensive master skill for modern Python development. Make sure to use this skill whenever the user asks to build, refactor, or debug Python applications, APIs, CLIs, or mentions modern Python practices like type hints, async/await, or modern tooling like uv, Ruff, and pytest.
---

# Comprehensive Python Expert

This skill provides comprehensive guidelines and best practices for developing high-quality, modern applications using Python. It is designed to enforce consistency, performance, and maintainability across all Python projects.

## Core Principles
1. **Modern Python Versions:** Target Python 3.10+ (preferably 3.12+). Leverage modern features like structural pattern matching (`match`/`case`), union types (`X | Y`), and modern standard libraries.
2. **Type Hinting Everywhere:** Use static typing for all function signatures and complex variables. Use `mypy` or `pyright` to enforce type safety.
3. **Modern Tooling:** Prefer modern, fast tools. Use `uv` for dependency management and virtual environments. Use `ruff` for linting and formatting (replacing flake8, black, isort). Use `pytest` for testing.
4. **Clean Code & Functional Patterns:** Write modular, readable code. Favor pure functions and immutable data structures where appropriate. Avoid unnecessary object-oriented overhead.

## Project Structure & Naming
- Use `snake_case` for modules, variables, and function names.
- Use `PascalCase` for class names.
- Use `UPPER_SNAKE_CASE` for constants.
- Organize projects clearly. A standard layout might include:
  - `src/project_name/` for the main code.
  - `tests/` for the test suite.
  - `pyproject.toml` for configuration and dependencies.

## Data and State
- Use `dataclasses` (from `dataclasses` module) or `pydantic` models for structured data and configuration.
- Avoid global mutable state.
- Handle state and configuration explicitly by passing objects, rather than relying on hidden global variables.

## Error Handling
- Use specific, built-in exception types (`ValueError`, `TypeError`, `KeyError`) or define custom exceptions subclassing `Exception`.
- Never use a bare `except:` clause. Always catch specific exceptions (e.g., `except ValueError:`).
- Use context managers (`with` statement) for managing resources like files, network connections, and database sessions.

## Async and Concurrency
- Use `asyncio` for I/O-bound tasks (network requests, database queries).
- Use `async`/`await` syntax correctly. Avoid mixing synchronous and asynchronous code without explicit bridges (like `asyncio.to_thread` or `run_in_executor`).
- For CPU-bound tasks, use `concurrent.futures.ProcessPoolExecutor` or `multiprocessing`.

## Anti-Patterns (NEVER Do These)
- **NEVER use bare `except:` blocks.**
  *Why:* It catches `SystemExit` and `KeyboardInterrupt`, making it difficult to stop the program, and hides real bugs like `NameError` or `SyntaxError`.
- **NEVER use mutable default arguments (like `def func(lst=[]):`).**
  *Why:* The default list is instantiated only once when the function is defined, causing it to be shared across all calls that use the default, leading to subtle bugs. Always use `None` and initialize inside the function (e.g., `lst = lst or []`).
- **NEVER ignore type checking.**
  *Why:* Static types provide invaluable documentation, catch bugs early, and improve IDE support.
- **NEVER manually format strings using `%` or `.format()` if you can use f-strings.**
  *Why:* F-strings (`f"Hello {name}"`) are faster, more readable, and standard practice in modern Python.
