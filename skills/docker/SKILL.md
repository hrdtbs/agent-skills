---
name: docker
description: Manage Docker containers, images, and compose stacks. Use this skill to list containers, view logs, clean up resources, and manage multi-container applications.
---

# Docker

Interact with Docker containers and images using the Docker CLI. This skill provides best practices for managing containers, inspecting logs, cleaning up unused resources, and using Docker Compose.

For detailed usage and commands, refer to the [official Docker documentation](https://docs.docker.com/).

## Usage

Run `docker` commands directly.

```bash
docker [subcommand] [flags]
```

## Common Operations

### List Containers

Use formatting to get a clean table view of running containers.

```bash
docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Names}}"
```

To list all containers (including stopped ones):

```bash
docker ps -a --format "table {{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Names}}"
```

### View Logs

Follow logs for a specific container, limiting the output to the last 100 lines to avoid flooding the console.

```bash
docker logs --tail 100 -f <container_name_or_id>
```

### Inspect a Container

Get detailed information about a container in JSON format.

```bash
docker inspect <container_name_or_id>
```

### Clean Up Resources

Remove unused data (stopped containers, unused networks, and dangling images). Be careful with this command.

```bash
docker system prune -f
```

To remove all unused images, not just dangling ones:

```bash
docker system prune -a -f
```

### Execute Command in Container

Run an interactive shell inside a running container.

```bash
docker exec -it <container_name_or_id> /bin/bash
# or if bash is not available:
docker exec -it <container_name_or_id> /bin/sh
```

## Docker Compose

Manage multi-container applications defined in `docker-compose.yml` or `compose.yml`.

### Start Services

Start services in the background.

```bash
docker compose up -d
```

### View Compose Logs

View logs for all services in the compose stack.

```bash
docker compose logs --tail 100 -f
```

### Stop Services

Stop and remove containers, networks, and volumes defined in the compose file.

```bash
docker compose down
```

## Troubleshooting

- **Permission Denied**: If you encounter permission errors, ensure the user is in the `docker` group or try using `sudo` (though `sudo` usage depends on environment configuration).
- **Daemon Not Running**: If `docker` commands fail with "Cannot connect to the Docker daemon", ensure the Docker service is running (`sudo service docker start` or equivalent).
