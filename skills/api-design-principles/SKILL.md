---
name: api-design-principles
description: Design intuitive, scalable, and maintainable REST and GraphQL APIs. Covers resource naming, HTTP methods, status codes, schema design, and best practices.
---

# API Design Principles

This skill provides a comprehensive guide to designing high-quality APIs, covering both REST and GraphQL paradigms. Use these principles to create APIs that are easy to use, robust, and scalable.

## Core Concepts

### RESTful Design
*   **Resource-Oriented**: Focus on resources (nouns) rather than actions (verbs). e.g., `/users` instead of `/getUsers`.
*   **HTTP Methods**: Use standard methods for their intended purpose:
    *   `GET`: Retrieve resources (safe, idempotent).
    *   `POST`: Create new resources.
    *   `PUT`: Replace a resource entirely (idempotent).
    *   `PATCH`: Update part of a resource.
    *   `DELETE`: Remove a resource (idempotent).
*   **Statelessness**: Each request must contain all necessary context; the server should not store client state between requests.
*   **Status Codes**: Use standard HTTP status codes to communicate outcomes (e.g., `200 OK`, `201 Created`, `400 Bad Request`, `401 Unauthorized`, `404 Not Found`, `500 Internal Server Error`).

### GraphQL Design
*   **Schema-First**: Define the types and operations (Query, Mutation, Subscription) before implementation.
*   **Single Endpoint**: Expose a single endpoint (usually `/graphql`) for all interactions.
*   **Strongly Typed**: Leverage the type system to validate inputs and outputs.
*   **Client-Driven**: Clients specify exactly what data they need, preventing over-fetching and under-fetching.

## Best Practices

### General
*   **Versioning**: Plan for changes. Use URL versioning (e.g., `/v1/users`), header versioning, or query parameters.
*   **Security**: Implement authentication (e.g., OAuth2, JWT) and authorization. Use HTTPS everywhere.
*   **Documentation**: Provide clear, up-to-date documentation (e.g., OpenAPI/Swagger for REST, GraphiQL/Apollo Studio for GraphQL).
*   **Error Handling**: Return consistent, structured error responses with meaningful messages and codes.
*   **Rate Limiting**: Protect your API from abuse by limiting the number of requests a client can make.

### REST Specific
*   **Pagination**: Always paginate collection endpoints. Use `limit`/`offset` or cursor-based pagination.
*   **Filtering, Sorting, Searching**: meaningful query parameters for filtering and sorting results.
*   **HATEOAS**: (Optional) Include hypermedia links in responses to guide clients through available actions.

### GraphQL Specific
*   **Mutations**: Return specific payload types that include the modified object and any user-facing errors.
*   **Pagination**: Use the Connection pattern (Relay style) for lists to support cursor-based pagination.
*   **N+1 Problem**: Use DataLoaders to batch and cache database requests, preventing performance issues with nested resolvers.
*   **Complexity Analysis**: Monitor and limit query depth/complexity to prevent denial-of-service attacks.

## Checklist

### REST API
- [ ] Resources use plural nouns (e.g., `/users`, `/orders`).
- [ ] HTTP verbs are used correctly (GET, POST, PUT, PATCH, DELETE).
- [ ] Status codes accurately reflect the result.
- [ ] Response bodies are consistent (e.g., always JSON).
- [ ] Filtering, sorting, and pagination are implemented for collections.
- [ ] Error responses follow a standard format.

### GraphQL API
- [ ] Schema is clearly defined with appropriate types.
- [ ] Queries and mutations have descriptive names.
- [ ] Input types are used for arguments.
- [ ] N+1 problems are addressed (e.g., using DataLoaders).
- [ ] Deprecation strategies are used (`@deprecated`) instead of breaking changes.

## Common Pitfalls
*   **Breaking Changes**: Removing fields or changing types without a major version update.
*   **Leaking Implementation Details**: Exposing internal database column names or structures directly in the API.
*   **Inconsistent Naming**: Mixing `camelCase` and `snake_case`. Stick to one convention (usually `camelCase` for JSON/GraphQL).
*   **Ignoring Performance**: Returning large datasets without pagination or allowing deeply nested queries without limits.
*   **Improper Auth**: Failing to authorize resource access at the object level (IDOR vulnerabilities).
