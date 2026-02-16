# Ticket 07: Melee Combat

**Phase**: 3 — Combat (Melee, Block, Damage)

## Description
Implement melee attack with the active held item. The two brothers automatically mirror the player's attack with their orbiting items.

## Requirements
- **Left click**: Swing active item in a melee arc
- Hitbox based on item properties (heavier items = wider/slower swing, lighter = faster)
- Damage based on item's damage quality and weight
- **Brothers mirror**: When Apolest attacks, both orbiting items simultaneously swing from their orbital positions
- Attack cooldown based on item weight (heavier = slower)
- Visual: polygon swing arc animation

## Files
- `systems/combat.lua` [NEW]
- `entities/player.lua` [MODIFY] — attack state, animation
- `main.lua` [MODIFY] — integrate combat system

## Acceptance Criteria
- Left click swings the active item with a visible arc
- The two orbiting items simultaneously swing from their positions
- Entities in the swing arc take damage
- Heavier items swing slower but deal more damage
- Cannot attack again until cooldown completes
