---
description: How to run and debug the Love2D game
---

# Run / Debug the Game

## Option 1: VS Code Debugger (Recommended)

1. Open the project in VS Code (WSL2 remote).
2. Press `F5` or go to Run → Start Debugging.
3. The "Debug LÖVE (WSL2 → Windows)" configuration will launch.
4. Set breakpoints in any `.lua` file — they will be hit during execution.

> The debugger connects via `lldebugger` which is conditionally loaded in `main.lua`.

## Option 2: Terminal (No Debugger)

// turbo
1. Run: `/mnt/c/Program\ Files/LOVE/love.exe .` from the project root.

## Troubleshooting

- **`-e` errors**: Make sure `launch.json` uses `program.command`, NOT `program.lua`.
- **Path errors**: `${workspaceFolder}` in args is correct — WSL2 interop translates it automatically.
- **Breakpoints not hitting**: Ensure `LOCAL_LUA_DEBUGGER_VSCODE` env var is set (the debugger extension does this automatically).
