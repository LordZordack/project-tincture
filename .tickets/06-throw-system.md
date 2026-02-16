# Ticket 06: Throw System

**Phase**: 2 — Item System & Carrying

## Description
Implement throwing the active held item as a projectile.

## Requirements
- Throw input: Q or Middle click
- Only items below the throwable weight threshold can be thrown
- Thrown item becomes a projectile moving in the player's facing direction
- Damage based on item weight and throw force
- Thrown items land on the ground after traveling a distance (can be re-picked up)
- Items may break on impact based on durability

## Files
- `systems/item_manager.lua` [MODIFY] — add throw logic and projectile state
- `entities/item.lua` [MODIFY] — add `thrown` state with velocity/position tracking

## Acceptance Criteria
- Press Q with a light item — it flies forward in the facing direction
- Heavy items can't be thrown (input is ignored or feedback given)
- Thrown item lands on ground after a distance and can be picked up again
- Thrown item with low durability breaks on impact and disappears
