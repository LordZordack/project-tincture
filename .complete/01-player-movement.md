# Ticket 01: Player Movement

**Phase**: 1 — Core Movement & Test Room

## Description
Create the player entity as a colored polygon (triangle indicating facing direction) with full movement mechanics.

## Requirements
- WASD movement
- **Directional speed bias**: moves faster in the direction the player is oriented
- **Mouse-aim orientation**: player faces the mouse cursor
- **Turn delay**: rotating orientation by a large degree has a small delay, mimicking a real person turning
- **Dash** (Space): short burst of speed with brief invincibility
- Rendered as a colored polygon (triangle) indicating facing direction

## Files
- `entities/player.lua` [NEW]

## Acceptance Criteria
- Player polygon appears on screen
- WASD moves the player; forward movement is faster than strafing/backpedaling
- Player triangle points toward the mouse cursor
- Rapid 180° mouse movements show a visible turn delay
- Space triggers a dash with a burst of speed
- Player cannot dash again until cooldown completes
