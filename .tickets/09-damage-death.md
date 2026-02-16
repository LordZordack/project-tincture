# Ticket 09: Damage, Death & Corpses

**Phase**: 3 — Combat (Melee, Block, Damage)

## Description
Implement the health/damage system, death mechanics, and the bleeding visual for health feedback. When any entity dies, it becomes a corpse item that can be looted, picked up, or used as a weapon.

## Requirements

### Entity Base Class
- Create a shared base class for player and NPCs
- Properties: health, position, orientation, carry slots, equipment slots
- `take_damage(amount)`: reduce health, increase bleeding visual
- `die()`: convert entity to corpse item, drop all carried/equipped items

### Damage Calculation
- Base damage = item.damage × weight factor
- Damage reduced by target's total protection (from equipped armor)

### Bleeding Visual (Health Feedback)
- No health bar — health is shown by how much the player bleeds
- Bleeding intensity (particle effect or color change) proportional to missing health
- Healing reduces bleeding

### Corpses
- Dead entities become corpse items on the ground
- Corpse weight based on entity size
- Corpses contain the dead entity's inventory (lootable)
- Corpses can be picked up, carried, thrown, and used as improvised weapons

## Files
- `entities/entity.lua` [NEW] — base entity class
- `entities/corpse.lua` [NEW] — corpse as a special item
- `entities/player.lua` [MODIFY] — extend entity base, add bleeding visual
- `systems/combat.lua` [MODIFY] — damage calculation, death handling

## Acceptance Criteria
- Attacking an entity reduces its health
- Protection from equipped armor reduces incoming damage
- As health decreases, the entity visually bleeds more
- At 0 health, entity dies: polygon disappears, a corpse item appears at the location
- Corpse contains the dead entity's items
- Corpse can be picked up, carried, and thrown like any item
