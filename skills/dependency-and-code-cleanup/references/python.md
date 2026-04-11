# Python Cleanup

When working with Python projects, dependency bloat and dead code are common issues that can increase maintenance costs and security risks.

## 1. Finding Unused Code and Dependencies

A practical tool for reducing Python dependency bloat is **pytrim**.

pytrim is an end-to-end system designed to automate the process of eliminating unused imports and package declarations across a variety of file types, including Python source files and configuration files like `requirements.txt` and `setup.py`.

### Using PyTrim

*Note: You may need to verify how pytrim is installed or invoked in the specific project context, as it might be installed globally, within a virtual environment, or run via a specific script.*

While pytrim can help automate the removal, you should always carefully review the changes it proposes.

## 2. Removing Dependencies

If you are managing dependencies manually after identifying them as unused:

*   **Virtual Environments:** Always ensure you are operating within the project's activated virtual environment (e.g., `source venv/bin/activate` or `poetry shell`).
*   **Removal Command:**
    ```bash
    pip uninstall <package-name>
    ```
*   **Updating Configuration:** After uninstalling the package, ensure that project configuration files like `requirements.txt`, `Pipfile`, `pyproject.toml`, or `setup.py` are updated to remove the dependency declaration.

## 3. Removing Dead Code

When tools identify dead code, unused functions, or unused variables:

1.  **Verify Usage:** Python's dynamic nature means that functions might be called dynamically (e.g., via `getattr()`) or used in frameworks (e.g., Django signals, Flask routes) in ways static analysis tools might miss. Always perform a codebase-wide search (e.g., using `grep` or standard search commands) before deleting the code.
2.  **Edit Source Files:** Edit the Python files to remove the dead code blocks.
3.  **Clean Imports:** If you remove a class or function, check if the imports required *only* by that code can also be removed.

## 4. Verification

After performing any cleanup in a Python project, it is critical to verify the project still functions correctly.

1.  **Run Tests:** Execute the project's test suite (e.g., `pytest`, `unittest`).
    ```bash
    python -m pytest
    ```
2.  **Run the Application:** Attempt to start the main application script or server to ensure it boots without `ImportError` or other startup crashes.