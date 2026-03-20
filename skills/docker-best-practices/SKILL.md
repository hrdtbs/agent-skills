---
name: docker-best-practices
description: "Expert guidance for writing Dockerfiles, docker-compose configurations, and managing containers. Make sure to use this skill whenever the user asks to containerize an application, write or review a Dockerfile, optimize Docker images, debug container issues, or discusses Docker best practices."
---

# Docker Best Practices

This skill provides expert guidance for writing efficient, secure, and maintainable Dockerfiles and container configurations. You must adhere to the rules in this document and the accompanying guidelines whenever you are writing, refactoring, or reviewing Docker configurations.

## Flow Control

When applying Docker best practices, you MUST follow this sequence:

1. **Read Domain Guidelines**: Before modifying or creating any `Dockerfile` or `docker-compose.yml`, read `references/docker-guidelines.md` for specific rules on image optimization, security, caching, and compose configuration.
   - Use the `read_file` tool to load `skills/docker-best-practices/references/docker-guidelines.md`.

2. **Diagnose and Plan**:
   - Analyze the current container configuration or request against the guidelines.
   - Plan your changes (e.g., implementing multi-stage builds, switching to a non-root user, combining `RUN` steps to reduce layers).

3. **Apply Guidelines**:
   - Write or refactor code strictly according to the guidelines.
   - Ensure the image size is minimized and security surface area is reduced.

4. **Verify**:
   - Verify that your Dockerfile builds successfully if possible.
   - Ensure that sensitive files are excluded via `.dockerignore`.
   - Ensure proper use of `ENTRYPOINT` and `CMD` in exec form.

## Core Directives

- **Minimize Image Size**: Prefer Alpine Linux or Distroless base images. Use multi-stage builds to exclude build tools from the final production image.
- **Security First**: Always run applications as a non-root user inside the container. Never hardcode secrets in the `Dockerfile`.
- **Optimize Caching**: Order your `Dockerfile` instructions from least likely to change (dependencies) to most likely to change (source code).
- **Reduce Layers**: Combine multiple `RUN` commands and clean up package caches in the same step.
- **Use `.dockerignore`**: Always define a `.dockerignore` file to prevent copying unnecessary or sensitive local files into the build context.

Always start by reading the guidelines in `references/docker-guidelines.md`!
