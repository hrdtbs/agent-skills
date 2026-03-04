---
name: docker
description: Manage Docker containers, images, and compose stacks. Use this skill to list containers, view logs, clean up resources, and manage multi-container applications.
---

* Formatting: Use `--format "table {{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Names}}"` for `docker ps`.
* Logs: Limit log output with `--tail 100 -f`.
