# Docker Guidelines

These guidelines define the gold standard for writing efficient, secure, and maintainable Dockerfiles and container configurations. You must adhere to these rules whenever you containerize an application, optimize images, or configure docker-compose.

## 1. Image Optimization & Size

### Use Appropriate Base Images
Selecting the right base image significantly impacts the final image size and security surface area.
*   **Avoid full OS images** (like `ubuntu` or `debian`) unless absolutely necessary.
*   **Prefer Alpine Linux** (`alpine`) for minimal footprint when compatibility allows.
*   **Prefer Distroless images** (`gcr.io/distroless/...`) for production to reduce attack vectors (no shell, package managers, etc.).
*   **Use official, specific tags.** Avoid `latest`. (e.g., `node:20.10-alpine` instead of `node:latest`).

### Leverage Multi-Stage Builds
Multi-stage builds allow you to use a heavy base image with all build tools, compile your application, and then copy *only* the compiled artifacts into a minimal production base image.
*   **Always** use multi-stage builds for compiled languages (Go, Rust, Java, C++) or frontend apps (React, Vue) where the build tools are not needed at runtime.

```dockerfile
# BAD: Single stage, includes compiler and source code in the final image
FROM golang:1.21
WORKDIR /app
COPY . .
RUN go build -o myapp main.go
CMD ["./myapp"]

# GOOD: Multi-stage build
# Stage 1: Build environment
FROM golang:1.21 AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
# CGO_ENABLED=0 is often needed for Alpine/Distroless
RUN CGO_ENABLED=0 go build -o myapp main.go

# Stage 2: Minimal runtime environment
FROM gcr.io/distroless/static-debian12
COPY --from=builder /app/myapp /myapp
CMD ["/myapp"]
```

### Minimize Layers
Each `RUN`, `COPY`, and `ADD` instruction creates a new layer.
*   **Combine `RUN` commands** using `&&` to reduce the number of layers.
*   Clean up package manager caches in the same `RUN` step to prevent them from being baked into the layer.

```dockerfile
# BAD
RUN apt-get update
RUN apt-get install -y curl
RUN rm -rf /var/lib/apt/lists/*

# GOOD
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl && \
    rm -rf /var/lib/apt/lists/*
```

## 2. Security

### Run as a Non-Root User
By default, Docker containers run as `root`. If a vulnerability allows an attacker to escape the container, they gain root access to the host.
*   **Always** create and switch to a non-root user before running the application.

```dockerfile
FROM node:20-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .

# Create a non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Change ownership of the app directory
RUN chown -R appuser:appgroup /app

# Switch to the non-root user
USER appuser

EXPOSE 3000
CMD ["node", "server.js"]
```

### Never Hardcode Secrets
*   **Do not** put passwords, API keys, or tokens in your `Dockerfile` via `ENV` or `ARG` if they are sensitive.
*   Use Docker Buildx secrets for build-time secrets.
*   Use environment variables passed at runtime (`-e`) or secret management solutions (like Docker Secrets, HashiCorp Vault, AWS Secrets Manager) for runtime secrets.

## 3. Dockerfile Best Practices

### Optimize Caching (Order Matters)
Docker caches layers. Put instructions that change frequently (like source code) at the bottom, and instructions that change rarely (like installing dependencies) at the top.
*   Copy dependency files (`package.json`, `requirements.txt`, `go.mod`) and install dependencies *before* copying the rest of the source code.

```dockerfile
# GOOD: Leverages caching. `npm ci` only runs if package.json changes.
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
```

### COPY vs. ADD
*   **Prefer `COPY`**. `COPY` simply copies files from the host to the container.
*   Only use `ADD` when you specifically need its extra features: extracting a local tarball directly into the image, or fetching a remote URL (though fetching URLs via `RUN curl/wget` is usually preferred for better layer control).

### ENTRYPOINT vs. CMD
*   Use `ENTRYPOINT` to define the main executable of the container (e.g., `ENTRYPOINT ["node"]`).
*   Use `CMD` to provide default arguments to that executable (e.g., `CMD ["server.js"]`).
*   Always use the **exec form** (JSON array: `["executable", "param1"]`) instead of the **shell form** (`executable param1`) so that signals like SIGTERM are correctly passed to your application for graceful shutdowns.

## 4. The .dockerignore File
Always include a `.dockerignore` file at the root of your context.
*   Exclude `.git`, `node_modules`, `target`, `build`, `.env`, and other local artifacts.
*   This significantly speeds up the build context transfer and prevents sensitive local files from accidentally being included in the image.

```text
# Example .dockerignore
.git
.gitignore
node_modules/
build/
dist/
*.env
*.log
```

## 5. Docker Compose

*   Use `docker-compose.yml` to define multi-container applications.
*   Utilize named volumes for persistent data (e.g., databases) so data survives container restarts.
*   Use user-defined networks to isolate your application's components.
*   Define explicit dependencies using `depends_on`.

```yaml
version: '3.8'
services:
  api:
    build: ./api
    ports:
      - "8080:8080"
    depends_on:
      - db
    environment:
      - DB_HOST=db
  db:
    image: postgres:15-alpine
    volumes:
      - pgdata:/var/lib/postgresql/data
    environment:
      - POSTGRES_PASSWORD=secret

volumes:
  pgdata:
```