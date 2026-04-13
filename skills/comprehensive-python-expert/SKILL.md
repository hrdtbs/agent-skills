---
name: comprehensive-python-expert
description: A comprehensive master skill for modern Python development. Make sure to use this skill whenever the user asks to write, refactor, debug, or architect Python code, or mentions Python frameworks, type hints, pytest, decorators, data structures, asyncio, or general Python best practices.
---

# Comprehensive Python Expert

This skill provides comprehensive guidelines and best practices for writing high-quality, modern, and maintainable Python code. These rules represent the current industry consensus and should be applied to all Python projects to ensure consistency, performance, and readability.

## Core Principles
1. **Strong Typing:** Embrace static typing using Python's `typing` module to catch errors early and improve developer experience.
2. **Readability Counts:** Follow PEP 8 guidelines. Write code that is easy to understand, preferring explicit over implicit.
3. **Modern Tooling:** Utilize modern linters, formatters, and testing frameworks (e.g., `ruff`, `pytest`, `mypy`) to automate quality checks.
4. **Data-Oriented Design:** Use appropriate data structures (e.g., `dataclasses`, `pydantic` models) for managing state and data transfer.
5. **Robust Error Handling:** Handle exceptions precisely and gracefully, avoiding bare `except` clauses.

## Project Structure & Tooling
- **Dependency Management:** Use modern package managers like `poetry`, `uv`, or `pipenv` instead of plain `requirements.txt` when possible to ensure deterministic builds.
- **Code Formatting:** Standardize formatting with tools like `ruff` (or `black`/`isort` combo). Ensure consistent quote usage, line lengths, and trailing commas.
- **Project Layout:** Group code logically, separating concerns. Place tests in a dedicated `tests/` directory at the root level or alongside the modules they test.

## Type Hinting
- **Always Type Hint:** Provide type hints for all function arguments and return values. This includes `self` and `cls` only when returning an instance of the class (using `typing.Self`).
- **Use Modern Syntax:** Utilize built-in collections for typing (e.g., `list`, `dict` instead of `typing.List`, `typing.Dict`) in Python 3.9+. Use the `|` operator for unions (e.g., `int | str` instead of `Union[int, str]`) in Python 3.10+.
- **Type Aliases:** Use `TypeAlias` (or the `type` statement in Python 3.12+) to create descriptive names for complex types to improve readability.
- **Optional Types:** Explicitly mark variables that can be `None` using `Optional[T]` or `T | None`.

## Data Structures
- **Dataclasses & Pydantic:** Use `dataclasses.dataclass` for simple data containers. For data validation and serialization (especially at application boundaries like APIs), use `pydantic.BaseModel`.
- **Enums:** Use `enum.Enum` or `enum.StrEnum` for defining a fixed set of related constants.
- **NamedTuples:** Prefer `typing.NamedTuple` over plain tuples or dictionaries when you need lightweight, immutable data structures with named fields.

## Error Handling & Exceptions
- **Specific Exceptions:** Catch specific exceptions (e.g., `ValueError`, `KeyError`) rather than catching general `Exception`.
- **Custom Exceptions:** Create custom exception classes inheriting from `Exception` for domain-specific errors.
- **Avoid Silencing Errors:** Never use a bare `except:` block, and avoid `except Exception: pass`. If you must silence an error, use `contextlib.suppress` and document why it's safe.
- **Logging vs Print:** Use the `logging` module for application errors and warnings, not `print()`. Include context with `logger.exception()` when handling errors.

## Performance & Concurrency
- **Generators:** Use generators (`yield`) or generator expressions for processing large datasets to minimize memory footprint.
- **Comprehensions:** Use list, dict, and set comprehensions for simple transformations as they are more concise and generally faster than `for` loops with `.append()`.
- **AsyncIO:** Use `async`/`await` for I/O-bound operations (e.g., network requests, database queries). Do not mix blocking synchronous code within `async` functions unless running in an executor.

## Anti-Patterns (NEVER Do These)
- **NEVER use mutable default arguments (e.g., `def func(lst=[]):`).**
  *Why:* The default object is evaluated once at function definition time, meaning subsequent calls will share the same mutated object, leading to subtle bugs. *Fix:* Use `None` as the default and initialize inside the function (`lst = lst or []`).
- **NEVER use bare `except:` clauses.**
  *Why:* It catches `SystemExit` and `KeyboardInterrupt`, preventing the program from exiting gracefully when stopped.
- **NEVER use `from module import *`.**
  *Why:* It pollutes the local namespace, making it difficult to track where variables or functions originate and increasing the risk of name collisions.
- **NEVER leave file handlers open.**
  *Why:* It can lead to resource leaks. *Fix:* Always use the `with` statement (context managers) when opening files or managing network connections.
- **NEVER use `type()` for exact type checking if inheritance is possible.**
  *Why:* It breaks polymorphism. *Fix:* Use `isinstance(obj, Class)` to support subclassing.
