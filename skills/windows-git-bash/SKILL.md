---
name: windows-git-bash
description: Verifies and utilizes Git Bash or WSL on Windows to avoid PowerShell compatibility issues.
---

# Windows Git Bash / WSL Execution

This skill helps ensure that commands are executed within a Bash-compatible environment (Git Bash or WSL) on Windows systems, avoiding common issues associated with PowerShell or Command Prompt.

## How It Works

1.  **Environment Verification**: The agent can run `check-env.sh` to confirm it is operating within Git Bash or WSL.
2.  **Command Execution**: Once verified, the agent should continue to use the current shell for all subsequent commands, leveraging standard Linux/Unix tools available in Git Bash/WSL.

## Usage

```bash
bash /mnt/skills/user/windows-git-bash/scripts/check-env.sh
```

## Output

The script outputs the detected environment type.

**Example Output (Git Bash):**
```json
{
  "environment": "git-bash",
  "os_type": "msys",
  "message": "Running in Git Bash / MSYS."
}
```

**Example Output (WSL):**
```json
{
  "environment": "wsl",
  "os_type": "linux-gnu",
  "message": "Running in WSL."
}
```

## Troubleshooting

-   If the script fails to run, ensure `bash` is in the PATH.
-   If the output indicates "unknown" or "powershell" (unlikely if running via bash), you may need to explicitly launch Git Bash or WSL.
