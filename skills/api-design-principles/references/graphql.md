# GraphQL API Design Principles

* Follow Schema-First design.
* Use the Connection pattern (Relay style) for list pagination.
* Return specific payload types for mutations (include modified object and errors).
* Prevent N+1 issues by batching requests (e.g., DataLoaders).
