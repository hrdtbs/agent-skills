---
name: architecture-patterns
description: Apply proven architectural patterns (Clean Architecture, Hexagonal, DDD).
---

* Clean Architecture: Dependencies must flow strictly inward. Inner layers (Entities, Use Cases) must know nothing about outer layers (UI, Database, Frameworks).
* Hexagonal Architecture: Core logic must be isolated from external concerns. Use Input/Output Ports (interfaces) and Adapters (implementations) to allow swapping dependencies (e.g., swapping a DB for an in-memory mock).
* DDD: Model Entities (mutable, has identity) and Value Objects (immutable, no identity) correctly.
* DDD: Avoid Anemic Domain Models. Entities must encapsulate business rules, not just hold data (getters/setters).
* Ensure the domain layer is completely free of framework-specific dependencies (e.g., ORM annotations, HTTP imports).
