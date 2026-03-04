---
name: architecture-patterns
description: Apply proven architectural patterns (Clean Architecture, Hexagonal, DDD).
---

* Clean Architecture: Dependencies flow strictly inward. Inner layers (Entities, Use Cases) must not know outer layers (UI, Database, Frameworks).
* Hexagonal Architecture: Isolate core logic from external concerns using Input/Output Ports (interfaces) and Adapters (implementations).
* DDD: Avoid Anemic Domain Models. Entities must encapsulate business rules, not just hold data.
* Ensure the domain layer is completely free of framework-specific dependencies.
