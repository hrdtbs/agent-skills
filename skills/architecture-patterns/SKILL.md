---
name: architecture-patterns
description: Apply proven architectural patterns (Clean Architecture, Hexagonal, DDD) to design maintainable and scalable systems.
---

# Architecture Patterns

Master proven backend architecture patterns including Clean Architecture, Hexagonal Architecture, and Domain-Driven Design to build maintainable, testable, and scalable systems.

## When to Use This Skill

*   **Designing New Systems**: Establish a solid foundation for new projects.
*   **Refactoring Monoliths**: Break down large codebases into manageable components.
*   **Establishing Standards**: Create consistent architectural guidelines for teams.
*   **Migrating Architectures**: Move from tightly coupled to loosely coupled designs.
*   **Implementing DDD**: Apply domain-driven design principles effectively.
*   **Improving Testability**: Create codebases that are easy to test in isolation.

## Core Concepts

### 1. Clean Architecture (The Onion)

Organize code into concentric layers where dependencies flow inward.

*   **Entities (Inner Core)**: Enterprise-wide business rules. Independent of frameworks.
*   **Use Cases (Application Business Rules)**: Application-specific business rules. Orchestrate data flow.
*   **Interface Adapters**: Convert data from use cases to format convenient for external agents (DB, Web).
*   **Frameworks & Drivers (Outer Layer)**: UI, Database, Devices, External Interfaces.

**Key Rule**: Inner layers know nothing about outer layers.

### 2. Hexagonal Architecture (Ports & Adapters)

Isolate the core logic from external concerns using ports and adapters.

*   **Domain Core**: The business logic (inside the hexagon).
*   **Ports (Interfaces)**: Define how the outside world interacts with the application (Input Ports) and how the application interacts with external systems (Output Ports).
*   **Adapters (Implementations)**: Implement the ports.
    *   **Driving Adapters (Primary)**: Trigger the application (e.g., REST API controller, CLI).
    *   **Driven Adapters (Secondary)**: Called by the application (e.g., PostgreSQL repository, SMTP client).

**Benefit**: Easily swap implementations (e.g., replace a real database with an in-memory mock for testing).

### 3. Domain-Driven Design (DDD)

Focus on the core domain logic and complex business rules.

*   **Bounded Contexts**: Explicit boundaries within which a domain model is defined and applicable.
*   **Ubiquitous Language**: A common language shared by developers and domain experts.
*   **Tactical Patterns**:
    *   **Entities**: Objects defined by their identity, not just attributes. Mutable.
    *   **Value Objects**: Objects defined by their attributes. Immutable. No identity.
    *   **Aggregates**: A cluster of domain objects treated as a single unit for data changes.
    *   **Repositories**: Abstraction for retrieving and persisting aggregates.
    *   **Domain Events**: Something that happened in the domain that experts care about.

## Guiding Principles

1.  **Dependency Rule**: Source code dependencies must point only inward, toward higher-level policies.
2.  **Separation of Concerns**: Distinct sections of code address distinct concerns (e.g., business logic vs. UI).
3.  **Testability**: The business rules can be tested without the UI, Database, Web Server, or any other external element.
4.  **Independence**: The architecture does not depend on the existence of some library of feature-laden software.

## Common Pitfalls

*   **Anemic Domain Model**: Entities that are just data holders (getters/setters) with no behavior. Put logic in services instead.
*   **God Objects**: Classes that know too much or do too much. Break them down.
*   **Leaky Abstractions**: Exposing implementation details (e.g., database schemas) in the domain layer.
*   **Tight Coupling**: High dependency between modules, making changes ripple across the system.
*   **Over-Engineering**: Applying complex patterns (like full DDD) to simple CRUD applications.

## Architecture Checklist

### Structure & Dependencies
- [ ] Are dependencies pointing inward (towards domain)?
- [ ] Is the domain layer free of framework dependencies (e.g., ORM annotations, HTTP imports)?
- [ ] Are interfaces defined in the layer that uses them (Interface Segregation)?

### Logic & Responsibilities
- [ ] Is business logic concentrated in the domain/use-case layer?
- [ ] Are controllers/presenters thin, delegating work to use cases?
- [ ] Do entities enforce their own invariants?

### Testing
- [ ] Can use cases be unit tested with mocks for repositories/gateways?
- [ ] Are there acceptance tests for the core business rules?

### DDD Specifics (if applicable)
- [ ] Are aggregates small and transactional boundaries clear?
- [ ] Is ubiquitous language used in code (class names, methods)?
