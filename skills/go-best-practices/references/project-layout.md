# Go Project Layout

While Go doesn't strictly enforce a directory structure, the [Standard Go Project Layout](https://github.com/golang-standards/project-layout) has become the de facto standard for structuring applications, particularly those that produce one or more executables.

## Core Directories

### `/cmd`

- **Purpose**: Main applications for this project.
- **Contents**: Each subdirectory under `cmd/` represents a separate executable. The directory name should match the name of the executable you want to build (e.g., `cmd/server/`, `cmd/cli/`).
- **Code**: The `main.go` file inside these directories should be small. Its primary job is to parse configuration, initialize dependencies, and start the application logic located elsewhere.
- **Example**:
  ```text
  myapp/
  ├── cmd/
  │   ├── myapp-server/
  │   │   └── main.go
  │   └── myapp-worker/
  │       └── main.go
  ```

### `/internal`

- **Purpose**: Private application and library code.
- **Visibility**: This is the most crucial directory. Go enforces a rule that code inside an `internal/` directory cannot be imported by code outside of the module that contains `internal/`.
- **When to use**: Put your core business logic, domain models, and service implementations here. This signals to other developers that these packages are internal implementation details and their API is not guaranteed to remain stable for external consumers.
- **Structure**: You can have multiple `internal/` directories at different levels, or one top-level `/internal` containing packages like `internal/auth`, `internal/db`, `internal/models`.

### `/pkg`

- **Purpose**: Library code that's ok to use by external applications.
- **Visibility**: Code in `pkg/` is completely public and can be imported by any other Go module.
- **When to use**: Use this *sparingly*. Only put code here if you genuinely intend for others to import it (e.g., a generic utility library, a public API client for your service).
- **Trend**: Many modern Go projects skip `/pkg` entirely and put everything in the root directory (for small libraries) or under `/internal` (for applications) to avoid prematurely committing to a public API.

## Supporting Directories

### `/api`

- **Purpose**: OpenAPI/Swagger specs, Protocol Buffer definitions, JSON schema files, etc.

### `/configs`

- **Purpose**: Configuration file templates or default configs (e.g., `config.yaml`, `example.json`).

### `/scripts`

- **Purpose**: Scripts to perform various build, install, analysis, etc operations. (e.g., shell scripts, Makefiles).

### `/test`

- **Purpose**: Additional external test apps and test data. Feel free to structure the `/test` directory anyway you want. Note: Unit tests (`_test.go` files) should always live next to the code they test in the same directory, not in `/test`.

## Example Project Structure

```text
my-go-service/
├── cmd/
│   └── server/
│       └── main.go         # App entrypoint
├── internal/
│   ├── api/                # HTTP handlers/routers
│   │   ├── handler.go
│   │   └── handler_test.go
│   ├── config/             # Configuration loading
│   │   └── config.go
│   ├── domain/             # Core business models/interfaces
│   │   └── user.go
│   └── storage/            # Database implementations
│       └── postgres.go
├── pkg/
│   └── logger/             # Example of a generic, public utility
│       └── logger.go
├── go.mod                  # Module definition
├── go.sum                  # Dependency checksums
├── Makefile                # Build/test commands
└── README.md
```

## "Flat" Structure (Alternative)

For very small applications, microservices, or single-package libraries, a flat structure is often preferred. Instead of `cmd/` and `internal/`, everything lives in the root directory.

```text
small-service/
├── main.go          # Contains func main()
├── handler.go       # HTTP logic
├── handler_test.go
├── db.go            # Database logic
├── go.mod
└── go.sum
```
Use the standard layout when the flat structure becomes difficult to navigate.