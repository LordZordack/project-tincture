# Ticket 16: Win Condition

**Phase**: 7 — Multi-Room Dungeon & Progression

## Description
Implement the King's Chamber and the win condition: pulling the King's Sword from Anaxarkas.

## Requirements

### The King's Chamber
- Final room in the dungeon
- Contains **Anaxarkas** — a unique entity, impaled and immobile
- The **King's Sword** is visually embedded in him

### Win Interaction
- Player approaches Anaxarkas and interacts (E) to pull the sword
- Triggers end-game sequence:
  - Anaxarkas' soul is released
  - Anaxarkas possesses Apolest's body
  - Apolest's soul and the two brothers are ripped into the void
- Transition to an end screen (victory/credits or narrative closing)

### End Screen
- Simple screen with narrative text describing the outcome
- Option to return to main menu

## Files
- `systems/win_condition.lua` [NEW]
- `systems/dungeon.lua` [MODIFY] — King's Chamber as a special room type
- `main.lua` [MODIFY] — end-game state handling

## Acceptance Criteria
- King's Chamber is reachable as the final room
- Anaxarkas is visible, impaled by the sword
- Press E near Anaxarkas — triggers end-game sequence
- End screen displays with narrative text
- Player can return to main menu from end screen
