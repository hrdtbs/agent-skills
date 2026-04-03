---
name: comprehensive-python-expert
description: Comprehensive Python development guidelines and best practices. Make sure to use this skill whenever the user mentions writing Python code, optimizing Python performance, setting up Python environments, working with typing, packaging, or debugging Python scripts, even if they don't explicitly ask for 'best practices'.
---

# Python Expert Guide

This skill provides comprehensive guidelines for writing modern, idiomatic, and maintainable Python code.

## Guiding Principles

- **Readability counts**: Write code that is easy for humans to read. Code is read much more often than it is written.
- **Explicit is better than implicit**: Avoid magic behavior. Make the flow of data and control obvious.
- **Use the standard library**: Python comes with "batteries included". Before reaching for an external dependency, check if the standard library provides a robust solution.

## Core Directives

### Type Hinting
Modern Python heavily leverages type hinting to prevent runtime errors and improve developer experience.
- Use built-in generic types (Python 3.9+) or the `typing` module to annotate function arguments and return types.
- *Why:* Type hints provide self-documenting code and allow static type checkers like `mypy` or `pyright` to catch bugs before execution.
- **Example**:
  ```python
  def process_items(items: list[str]) -> dict[str, int]:
      return {item: len(item) for item in items}
  ```

### Virtual Environments and Dependency Management
Always isolate project dependencies.
- Use modern tools like `venv`, `poetry`, or `uv` to manage environments and dependencies.
- *Why:* System-wide package installations can lead to version conflicts across different projects. Isolating them ensures reproducibility and stability.

### Exception Handling
Handle errors gracefully and specifically.
- Catch specific exceptions rather than using a bare `except:`.
- *Why:* Catching all exceptions (including `SystemExit` or `KeyboardInterrupt`) can hide unrelated bugs, making it harder to debug issues and sometimes making the program unkillable.
- **Example**:
  ```python
  try:
      with open("data.json") as f:
          data = json.load(f)
  except FileNotFoundError:
      logger.error("Data file is missing.")
  except json.JSONDecodeError:
      logger.error("Data file is corrupted.")
  ```

### Modern Formatting and Linting
Adopt consistent code formatting.
- Use `black` or `ruff` for formatting, and `isort` (or `ruff`) for import sorting.
- *Why:* Automated formatting ends debates over code style and ensures a uniform codebase, allowing developers to focus on logic rather than syntax.

## Anti-Patterns (What to Avoid)

- **NEVER use mutable default arguments (like `def foo(items=[])`)**:
  - *Reason:* Default arguments are evaluated once when the function is defined. Subsequent calls will share the same mutable object, leading to unexpected state leakage and hard-to-track bugs.
  - *Instead:* Use `None` as the default and initialize the mutable object inside the function.
- **NEVER use `from module import *`**:
  - *Reason:* Star imports pollute the local namespace and make it impossible to track where functions or variables are coming from, making refactoring a nightmare.
  - *Instead:* Import specific functions or the module itself.
- **NEVER use bare `except:` clauses**:
  - *Reason:* It catches everything, obscuring the root cause of unexpected failures.
  - *Instead:* Catch `Exception` at most, or better yet, catch the specific anticipated exceptions.

## Testing
Test your logic thoroughly.
- Prefer `pytest` over `unittest` for its concise syntax and powerful fixture system.
- *Why:* Writing tests using plain `assert` statements lowers the cognitive load compared to remembering `unittest.TestCase` methods, and `pytest` fixtures provide a clean, modular way to manage test state setup and teardown.
