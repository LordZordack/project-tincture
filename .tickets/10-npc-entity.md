# Ticket 10: NPC Entity

**Phase**: 4 — NPCs & AI

## Description
Create the NPC entity extending the shared entity base class. NPCs have a faction alliance, aggression level, and carry items. They are rendered as colored polygons where the color indicates faction.

## Requirements
- Extends entity base class (health, position, carry slots, equipment)
- Alliance: Arete (white), Eophyll (green), Skia (black/dark), or Unaligned
- Aggression: Passive, Defensive, Provoked, Aggressive, or Berserk
- Carries/equips items (same system as player)
- Rendered as colored polygon matching faction color
- Spawned into rooms with configurable properties

## Files
- `entities/npc.lua` [NEW]
- `systems/room.lua` [MODIFY] — NPC spawn points

## Acceptance Criteria
- NPCs appear in the test room as colored polygons
- Color matches faction (white = Arete, green = Eophyll, dark = Skia)
- NPCs hold items that are visible
- NPCs can be damaged and die (becoming corpses with lootable items)
