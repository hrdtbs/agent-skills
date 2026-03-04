---
name: api-design-principles
description: Apply API design principles for REST and GraphQL.
---

* REST: Use plural nouns for resources, always paginate collections, and version APIs explicitly.
* GraphQL: Follow Schema-First design.
* GraphQL: Use the Connection pattern (Relay style) for list pagination.
* GraphQL: Return specific payload types for mutations (include modified object and errors).
* GraphQL: Prevent N+1 issues by batching requests (e.g., DataLoaders).
