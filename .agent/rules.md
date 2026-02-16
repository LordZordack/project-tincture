# Project: Hack-and-Slash Shooter (Project Tincture)

## Tech Stack
- **Engine**: LÖVE2D (Love2D) — Lua-based 2D game framework
- **Language**: Lua (LuaJIT runtime)
- **OS**: WSL2 (coding) → Windows (running). Hybrid workflow.

## Project Structure
```
main.lua         — Entry point, game loop (load/update/draw)
conf.lua         — LÖVE configuration (1280x720)
entities/        — Game entities: player, enemies, projectiles, pickups
systems/         — Game systems: collision, physics, AI, rendering
assets/          — images/, sounds/, fonts/
lib/             — Third-party Lua libraries
```

## Key Conventions

### Debugging
- The game uses **Local Lua Debugger** (Tom Blind) in VS Code.
- `main.lua` conditionally requires `lldebugger` when `LOCAL_LUA_DEBUGGER_VSCODE=1`.
- The launch config uses `program.command` (NOT `program.lua`) to avoid LÖVE-incompatible `-e` flag injection.
- LÖVE is installed at `C:\Program Files\LOVE\love.exe` (accessed via `/mnt/c/` from WSL2).

### Running the Game
- **From VS Code**: Press F5 (uses `.vscode/launch.json`).
- **From terminal**: `/mnt/c/Program\ Files/LOVE/love.exe .`
- Do NOT use `program.lua` in launch.json — LÖVE doesn't support the `-e` flag that the debugger injects.

### Code Style
- Use `local` for all variables unless they must be global.
- Each entity/system should be its own `.lua` file returning a table or class.
- Use `require` for module loading.

### Lua Language Server
- `.luarc.json` is configured with `love` as a recognized global and `LuaJIT` runtime.

### Git
- Remote: `https://github.com/LordZordack/project-tincture.git`
- Branch: `main`
