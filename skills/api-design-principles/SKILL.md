---
name: api-design-principles
description: Apply API design principles for REST and GraphQL.
---

* REST: Use plural nouns for resources (e.g., `/users`).
* REST: Always paginate collection endpoints.
* REST: Version APIs explicitly (e.g., URL or header versioning).
* GraphQL: Follow Schema-First design.
* GraphQL: Return specific payload types for mutations (include modified object and errors).
* GraphQL: Use the Connection pattern (Relay style) for list pagination.
* GraphQL: Prevent N+1 issues by batching requests (e.g., DataLoaders).
* GraphQL: Use `@deprecated` instead of making breaking changes.
