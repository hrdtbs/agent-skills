# Bash Patterns for Autonomous Agents

When running bash commands as an autonomous agent, follow these patterns to ensure reliability and observability:

## 1. Background Processes
When starting servers or dev watchers, always run them in the background and redirect output to a log file so you can inspect it later.

```bash
# Good
npm run dev > dev_server.log 2>&1 &

# Bad
npm run dev
```

## 2. Port Management
Always ensure a port is free before starting a service.

```bash
# Kill any process on port 3000
kill $(lsof -t -i :3000) 2>/dev/null || true
```

## 3. Safe Directory Traversal
Commands run by the agent are typically executed from the repository root. Ensure scripts use relative paths correctly, or explicitly `cd` within a subshell.

```bash
(cd some/nested/dir && npm install && npm run build)
```

## 4. Environment Variables
Inject required environment variables inline if possible, or source an environment file.

```bash
NODE_ENV=production npm run build
```