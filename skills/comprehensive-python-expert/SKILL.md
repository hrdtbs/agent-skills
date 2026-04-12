---
name: comprehensive-python-expert
description: A comprehensive master skill for modern Python development. Make sure to use this skill whenever the user asks to build, refactor, debug, or write Python applications, scripts, or APIs, or whenever the user mentions Python frameworks like FastAPI, Django, or Flask. Even if the user doesn't explicitly ask for Python best practices, apply this skill to ensure high-quality Python code.
---

# Comprehensive Python Expert

This skill provides comprehensive guidelines and best practices for developing high-quality, modern, and maintainable applications using Python. It is designed to enforce consistency, type safety, and robust design patterns across all Python projects.

## Core Principles

1. **Type Hinting Everywhere:** Use Python's type hints (`typing` module) for all function arguments, return types, and class attributes.
   *Why:* Type hints significantly improve code readability, enable powerful static analysis tools (like `mypy`), and help IDEs provide better autocomplete and inline error checking, reducing runtime bugs.

2. **PEP 8 Compliance:** Follow PEP 8 guidelines for code formatting.
   *Why:* PEP 8 is the universal standard for Python code. Adhering to it ensures that your code is readable and familiar to any other Python developer who might work on it. Use tools like `black` or `ruff` for automated formatting.

3. **Modern Features:** Utilize modern Python features (Python 3.9+) such as f-strings, dataclasses, and match-case statements where appropriate.
   *Why:* Modern features are often more performant and expressive. For example, `dataclasses` drastically reduce boilerplate code for classes that primarily store data.

4. **Modular Design:** Break down large scripts into smaller, testable functions and modules. Use classes when you need to encapsulate state and behavior together.
   *Why:* Modular code is easier to test, debug, and reuse. It also reduces cognitive load by allowing developers to focus on one piece of logic at a time.

## Project Structure & Naming

- Use `snake_case` for variables, functions, and module names.
- Use `PascalCase` for class names.
- Use `UPPER_SNAKE_CASE` for constants.
- Organize projects using a standard directory layout: `src/` or package directories for source code, and `tests/` for test files.

## Documentation

- **Docstrings:** Write comprehensive docstrings for all public modules, classes, and functions. Prefer standard formats like Google style or Sphinx (reST).
   *Why:* Docstrings serve as the primary source of truth for how to use a piece of code. Good docstrings explain *what* the code does and *why*, while the code itself shows *how*.

**Example:**
```python
def calculate_discount(price: float, discount_rate: float) -> float:
    """
    Calculates the final price after applying a discount.

    Args:
        price: The original price of the item.
        discount_rate: The discount to apply, as a decimal (e.g., 0.20 for 20%).

    Returns:
        The final calculated price.

    Raises:
        ValueError: If the price or discount_rate is negative.
    """
    if price < 0 or discount_rate < 0:
        raise ValueError("Price and discount rate must be non-negative.")
    return price * (1 - discount_rate)
```

## Error Handling

- Catch specific exceptions rather than using a bare `except:` or catching broad `Exception` classes unless strictly necessary.
   *Why:* Catching specific exceptions prevents hiding unexpected bugs (like `KeyboardInterrupt` or syntax errors) and makes it clear what failures the code is designed to handle.
- Use context managers (`with` statements) for resource management (files, network connections, database sessions).
   *Why:* Context managers ensure that resources are properly cleaned up even if an exception occurs, preventing resource leaks.

## Preferred Alternatives (Instead of Anti-Patterns)

- **Instead of mutable default arguments (like `[]` or `{}`):**
  Use `None` as the default argument and initialize the mutable object inside the function.
  *Why:* Mutable default arguments are evaluated exactly once when the function is defined, which can lead to unexpected state sharing across function calls.

- **Instead of deep nesting and complex conditional logic:**
  Use early returns (guard clauses) to handle edge cases at the top of the function.
  *Why:* Early returns keep the "happy path" of the code at a lower indentation level, significantly improving readability.

- **Instead of manual string concatenation (e.g., `str1 + " " + str2` or `%s`):**
  Use f-strings for string interpolation.
  *Why:* f-strings are more readable, less prone to formatting errors, and generally faster than older string formatting methods.

- **Instead of global state (`global` keyword):**
  Pass state explicitly via function arguments or encapsulate it within class instances.
  *Why:* Global state makes code difficult to test, reason about, and use in concurrent environments, as any part of the program can modify the state unexpectedly.
