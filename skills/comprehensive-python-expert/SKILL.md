---
name: comprehensive-python-expert
description: A comprehensive master skill for modern Python development. Make sure to use this skill whenever the user asks to write, refactor, or debug Python code, scripts, or APIs, or mentions Python frameworks like FastAPI, Django, or data science libraries. This skill provides structural best practices, typing guidelines, and modern dependency management strategies.
---

# Comprehensive Python Expert

This skill provides comprehensive guidelines and best practices for developing high-quality, modern, and maintainable applications using Python. It is designed to help you generate idiomatic Python that leverages the latest language features, ensures type safety, and promotes readability.

## Core Principles

1. **Type Hinting Everywhere:** Modern Python relies heavily on type hints. Always use type hints for function arguments and return types. This acts as both documentation and a safeguard against runtime errors. Use `typing` module features like `Optional`, `Union`, `List`, `Dict` (or built-in equivalents in Python 3.9+) when appropriate.
2. **Idiomatic Python (Pythonic):** Leverage Python's built-in capabilities like list comprehensions, generator expressions, and built-in functions (`enumerate`, `zip`, `any`, `all`) instead of writing verbose loops.
3. **Environment Isolation:** Assume the use of modern dependency management and environment isolation tools like `uv`, `poetry`, or `pipenv` unless the user specifies otherwise. Do not suggest system-wide `pip install`.
4. **Readability First:** Code is read more often than it is written. Follow PEP 8 guidelines. Prefer clear, descriptive variable names over clever, terse ones.

## Project Structure & Architecture

- **Modular Design:** Break down large files into smaller, focused modules. A good rule of thumb is if a file exceeds 500 lines, consider if logically distinct parts can be separated.
- **Entry Points:** Use the standard `if __name__ == "__main__":` block to separate execution logic from definitions.
- **Configuration:** Prefer passing configurations via environment variables or dedicated config files (like `config.py` using `pydantic.BaseSettings`) over hardcoding them.

## Data Modeling & Management

- **Dataclasses & Pydantic:** For data containers, prefer `dataclasses` (for simple standard library usage) or `pydantic` (for robust validation and parsing, especially in web APIs). Avoid bare dictionaries for complex, structured data.
- **Immutability:** When passing data around, consider using `frozen=True` in dataclasses to prevent unintended side effects and make reasoning about state easier.

## Error Handling

- **Specific Exceptions:** Catch specific exceptions (e.g., `ValueError`, `KeyError`) rather than bare `except Exception:`. This prevents masking unrelated bugs.
- **Graceful Degradation:** When an error occurs, provide informative error messages and consider what fallback state makes sense.
- **Logging:** Use the built-in `logging` module or structural logging libraries (like `structlog`) instead of `print()` for production code. This allows for log levels and better tracing.

## Style & Examples

### Using Type Hints and Dataclasses

**Example 1: Refactoring a bare dictionary function to a typed dataclass approach**

*Before (Input)*
```python
def process_user(user_data):
    if user_data.get('age', 0) >= 18:
        return {"status": "adult", "name": user_data.get('name')}
    return {"status": "minor", "name": user_data.get('name')}
```

*After (Output)*
```python
from dataclasses import dataclass
from typing import Literal

@dataclass
class User:
    name: str
    age: int

@dataclass
class ProcessedUser:
    name: str
    status: Literal["adult", "minor"]

def process_user(user: User) -> ProcessedUser:
    status: Literal["adult", "minor"] = "adult" if user.age >= 18 else "minor"
    return ProcessedUser(name=user.name, status=status)
```

### Pythonic Iteration

**Example 2: Simplifying loops**

*Before (Input)*
```python
results = []
for i in range(len(items)):
    if items[i].is_active:
        results.append(items[i].name)
```

*After (Output)*
```python
# Use list comprehensions for concise, readable filtering and mapping
results = [item.name for item in items if item.is_active]
```

## Anti-Patterns (What to Avoid and Why)

- **Avoid Mutable Default Arguments:** Using `def append_item(item, lst=[]):` causes the list to be shared across all function calls.
  *Why:* It leads to unpredictable state. Use `lst=None` and initialize it inside the function.
- **Avoid Bare Excepts:** `except:` catches `KeyboardInterrupt` and `SystemExit`, making it hard to stop the program and masking subtle bugs.
  *Why:* It makes debugging significantly harder. Always catch specific exceptions.
- **Avoid Over-Engineering with Classes:** Don't create a class with only an `__init__` and one other method if a simple function will do.
  *Why:* Python supports first-class functions; forcing object-orientation where it's not needed adds boilerplate and reduces readability.
