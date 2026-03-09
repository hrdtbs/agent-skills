---
name: rest-api-design
description: "Master REST API design principles to build intuitive, scalable, and maintainable APIs. Use when designing new REST APIs, reviewing API specifications, or refactoring existing endpoints. Focuses on resource-oriented architecture, standard HTTP methods, and consistent JSON response formats."
---

# REST API Design Principles

Master REST API design principles to build intuitive, scalable, and maintainable APIs that delight developers and stand the test of time.

## Core Concepts

### 1. Resource-Oriented Architecture
* Resources are nouns (e.g., `users`, `orders`, `products`), not verbs.
* Use HTTP methods for actions:
  * `GET`: Retrieve a resource or a collection of resources.
  * `POST`: Create a new resource.
  * `PUT`: Update an existing resource entirely.
  * `PATCH`: Partially update an existing resource.
  * `DELETE`: Remove a resource.
* URLs represent resource hierarchies (e.g., `/users/123/orders`).

### 2. Standardized JSON Responses
* ALWAYS wrap API responses in a consistent format containing `status`, `message`, and `data`/`error` fields.

**Success Response Format:**
```json
{
  "status": "success",
  "message": "Resource retrieved successfully",
  "data": { ... }
}
```

**Error Response Format:**
```json
{
  "status": "error",
  "message": "Invalid user ID provided",
  "error": {
    "code": "INVALID_ID",
    "details": "User ID must be an integer"
  }
}
```

### 3. HTTP Status Codes
* `200 OK`: Successful `GET`, `PUT`, or `PATCH`.
* `201 Created`: Successful `POST` (creation).
* `204 No Content`: Successful `DELETE`.
* `400 Bad Request`: Client error (e.g., invalid input).
* `401 Unauthorized`: Missing or invalid authentication.
* `403 Forbidden`: Authenticated, but lacking permissions.
* `404 Not Found`: Resource does not exist.
* `422 Unprocessable Entity`: Validation errors.
* `500 Internal Server Error`: Server failure.

### 4. Pagination, Filtering, and Sorting
* Use query parameters for collections.
* **Pagination:** `?page=1&limit=20` or `?cursor=xyz&limit=20`.
* **Filtering:** `?status=active&role=admin`.
* **Sorting:** `?sort=-created_at` (descending) or `?sort=name` (ascending).

### 5. Versioning
* Version your APIs to prevent breaking changes for existing clients.
* Prefer URI versioning: `/api/v1/users`.

## Anti-Patterns to Avoid
* **Verbs in URLs:** Do NOT use `/getUsers` or `/createUser`. Use `GET /users` and `POST /users`.
* **Inconsistent Naming:** Pick `snake_case` or `camelCase` for JSON keys and stick to it universally.
* **Returning 200 for Errors:** Do NOT return `HTTP 200 OK` with an error payload. Always use the appropriate `4xx` or `5xx` status code.
