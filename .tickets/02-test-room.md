# Ticket 02: Test Room

**Phase**: 1 — Core Movement & Test Room

## Description
Create a test room — a large rectangular walled arena — with wall collision and a camera that follows the player.

## Requirements
- Rectangular room with solid-colored walls and dark floor
- Player cannot pass through walls (collision)
- Camera smoothly follows the player (lerp-based)
- Room is large enough for gameplay testing

## Files
- `systems/room.lua` [NEW]
- `entities/camera.lua` [NEW]
- `main.lua` [MODIFY] — integrate room, camera, and player into the game loop

## Acceptance Criteria
- Game launches to a visible walled room
- Player cannot walk through walls
- Camera follows the player smoothly; room edges are visible when the player is near walls
- Room is rendered with distinct wall and floor colors
