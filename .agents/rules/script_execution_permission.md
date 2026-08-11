---
trigger: always_on
---

# Automatic Script Execution & Sandbox Rule

- **Automatic Scratch Script Execution**: Always run helper and scratch scripts (e.g., located in `<appDataDir>/brain/.../scratch/`) automatically without asking permission, provided the script only accesses/modifies files within the workspace directory.
- **Standard Sandbox First**: Always execute python/shell helper scripts using standard sandbox mode (`BypassSandbox: false`). Never use `BypassSandbox: true` for scripts that only read and write files inside the current project workspace.
