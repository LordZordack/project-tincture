# Ticket 08: Blocking

**Phase**: 3 — Combat (Melee, Block, Damage)

## Description
Implement blocking with the active held item. Brothers automatically block with their orbiting items, providing flanking defense.

## Requirements
- **Right click**: Raise active item to block incoming damage
- Damage reduction based on item's protection value
- Durability consumed when blocking — items can break mid-fight
- **Brothers mirror**: Both orbiting items are raised to block from their orbital positions (flanking defense)
- Any item can be used to block, but fragile/improvised items break quickly
- Player movement slowed while blocking

## Files
- `systems/combat.lua` [MODIFY] — add blocking logic
- `entities/player.lua` [MODIFY] — blocking state

## Acceptance Criteria
- Right click raises the active item (visual change)
- Incoming damage is reduced by the item's protection value
- Item durability decreases when blocking hits
- Item breaks and disappears when durability reaches 0
- Brothers visibly raise their items when blocking
- Player moves slower while blocking
