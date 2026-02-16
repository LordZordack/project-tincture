# Ticket 04: Item Entity

**Phase**: 2 — Item System & Carrying

## Description
Create the item data model. Every object in the game world is an item with a consistent set of qualities.

## Requirements
- Item properties: weight, damage, protection, durability, value, rarity, throwable, consumable, equip_slot
- Item states: `ground`, `carried_active`, `carried_orbit1`, `carried_orbit2`, `equipped`, `thrown`
- Rendered as simple colored shapes (size proportional to weight)
- Factory function to create items from a definition table
- Items on the ground are stationary and interactable

## Files
- `entities/item.lua` [NEW]

## Acceptance Criteria
- Items can be instantiated with varying properties
- Items render on the ground at their position
- Item size visually reflects its weight
- Item state can be changed and queried
