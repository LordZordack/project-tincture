# Levels

## Level Structure

The dungeon is a series of interconnected rooms. Each room is a self-contained arena separated by doors (some locked, requiring keys). The dungeon is steeped in **Skia magic** — its architecture is twisted and unnatural.

**Current state**: For testing, a large blank room surrounded by walls.

## Rooms

Rooms vary in size and purpose:

| Type | Description |
|------|-------------|
| Combat rooms | Contain hostile NPCs; must be cleared or avoided |
| Loot rooms | Contain chests, scattered items, or NPC corpses to scavenge |
| Locked rooms | Require keys to enter; contain better loot or progression items |
| The King's Chamber | Final room. Contains **Anaxarkas** impaled by the King's Sword |

## Progression

- The player starts in the dungeon entrance with **no items** (Skia burns everything on entry).
- Rooms are connected by doors. Some doors are locked and require **keys** found elsewhere.
- Difficulty increases deeper into the dungeon — stronger enemies, better loot.
- The goal is to reach the King's Chamber and pull the **King's Sword** from Anaxarkas.

## Dungeon Environment

- Walls are impassable barriers defining room boundaries.
- All objects within rooms (furniture, scenery, decorations) are items and can be picked up.
- NPC factions (Arete, Eophyll, Skia) populate rooms according to their alliance territories. See [Entities](entities.md).

## Spawning

- NPCs are placed in rooms at level load (not wave-based).
- NPC placement is determined by faction territory and room type.
- Killed NPCs leave corpses that persist as lootable items.
