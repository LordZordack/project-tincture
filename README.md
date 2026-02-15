# Hack-and-Slash Shooter

A top-down hack-and-slash shooter built with LÖVE2D.

## Project Structure

```
.
├── main.lua           # Main game entry point with game loop
├── conf.lua           # LÖVE configuration (1280x720)
├── entities/          # Player, enemies, projectiles, etc.
├── systems/           # Game systems (physics, collision, AI, etc.)
├── assets/
│   ├── images/        # Sprites and textures
│   ├── sounds/        # Sound effects and music
│   └── fonts/         # Custom fonts
├── lib/               # Third-party libraries
└── .vscode/
    └── launch.json    # VS Code debugger configuration
```

## Development Setup (WSL2 + Windows Hybrid)

This project uses a hybrid workflow: code in WSL2, run on Windows LÖVE for low-latency audio/input.

### Prerequisites

1. **Windows LÖVE Installation**: Install LÖVE at `C:\Program Files\LOVE\love.exe`
2. **VS Code Extensions**:
   - Lua (sumneko.lua)
   - Local Lua Debugger (tomblind.local-lua-debugger-vscode)

### Running the Game

**Option 1: Debug with VS Code**
1. Press `F5` or use "Run → Start Debugging"
2. The debugger will launch the Windows LÖVE executable with your WSL2 workspace

**Option 2: Manual Launch**
```bash
# From WSL2, if you have LÖVE in your Windows PATH
/mnt/c/Program\ Files/LOVE/love.exe .
```

### Debugger Usage

The project includes conditional debugger support:
- Set breakpoints in VS Code
- Press `F5` to start debugging
- The debugger only loads when launched via VS Code (no performance impact in production)

### Controls

- **ESC**: Quit game

## Project Guidelines

- Place entity classes (player, enemies) in `entities/`
- Place game systems (collision, rendering layers) in `systems/`
- Place all assets in appropriate `assets/` subfolders
- Place third-party libraries in `lib/`
