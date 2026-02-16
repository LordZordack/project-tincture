# Ticket 03: Input System

**Phase**: 1 — Core Movement & Test Room

## Description
Create a centralized input mapping system that reads keyboard and mouse state each frame and returns structured intent data. This decouples input handling from game logic and enables future key rebinding.

## Requirements
- Read keyboard and mouse state each frame
- Return an intent table with fields: `move_x`, `move_y`, `aim_x`, `aim_y`, `dash`, `attack`, `block`, `throw`, `consume`, `swap`, `interact`, `inventory`
- Support both pressed-this-frame and held-down states where appropriate
- Clean API that other systems can query

## Files
- `systems/input.lua` [NEW]
- `main.lua` [MODIFY] — wire input system into the update loop

## Acceptance Criteria
- All inputs from the controls table in gameplay.md are captured
- Player movement and actions are driven through the input system (not direct `love.keyboard` calls in player code)
- Input intent is accessible to any system that needs it
