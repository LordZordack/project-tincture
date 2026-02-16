# Ticket 15: Multi-Room Dungeon

**Phase**: 7 — Multi-Room Dungeon & Progression

## Description
Implement a multi-room dungeon with doors connecting rooms. Some doors are locked and require keys. Rooms persist their state (corpses, items) when revisited.

## Requirements

### Dungeon Manager
- Room graph: rooms connected by doors
- Transition: player walks to a door and interacts to move to the next room
- Room state persists when leaving and re-entering (items, corpses, dead NPCs stay)

### Doors
- Visual distinction between open, closed, and locked doors
- Locked doors require a key item — key is consumed on use
- Door placement on room edges

### Room Types
- Combat rooms: hostile NPCs spawned on first load
- Loot rooms: chests and scattered items
- Locked rooms: better loot, require keys
- The King's Chamber: final room (see ticket 16)

### Room Data Format
- Each room defined by: dimensions, walls, doors (with connections), NPC spawn list, item spawn list

## Files
- `systems/dungeon.lua` [NEW]
- `systems/room.lua` [MODIFY] — room data format, multiple room support, door rendering
- `main.lua` [MODIFY] — dungeon manager integration

## Acceptance Criteria
- Multiple rooms exist with doors connecting them
- Walk to a door and interact — transitions to the connected room
- Locked doors won't open without a key; key is consumed when used
- Items and corpses persist in rooms when revisiting
- Different room types are visually distinguishable
