# Ticket 14: Consumables

**Phase**: 6 — Consumables & Throwing Polish

## Description
Implement consumable items: healing, buffs, cursed items, and consumable clothing.

## Requirements

### Consume Action
- Press F to consume the active held item (if it's consumable)
- Item is destroyed after consumption

### Consumable Types
- **Healing** (potions, food): Restore health, reduce bleeding visual
- **Buff** (elixirs, scrolls): Temporary stat boosts with a duration timer
- **Cursed** (rotten food, tainted potions): Negative effects (poison damage over time, stat debuffs)
- **Consumable clothing**: Some clothing consumed on use with negative benefits (e.g., cursed cloak that poisons)

### Visual Feedback
- Healing: bleeding reduces visibly
- Buff: subtle visual indicator (glow, color tint) while active
- Poison: periodic damage ticks, distinct visual effect

## Files
- `systems/consumable.lua` [NEW]
- `entities/item.lua` [MODIFY] — consumable properties and effect definitions
- `entities/player.lua` [MODIFY] — buff/debuff tracking, poison tick

## Acceptance Criteria
- Press F with a healing item — health increases, bleeding decreases
- Press F with a buff item — temporary stat boost with visible indicator, wears off after duration
- Press F with a cursed item — negative effect applied (poison ticks damage)
- Consumed item disappears from carried items
- Non-consumable items cannot be consumed (F does nothing)
