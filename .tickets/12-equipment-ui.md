# Ticket 12: Equipment & Inventory UI

**Phase**: 5 — Equipment & Inventory UI

## Description
Implement the 4-slot equipment system and an inventory screen where the player can equip items to body slots.

## Requirements

### Equipment System
- 4 equipment slots: **head**, **body**, **legs**, **accessory**
- Equipping an item applies its protection and any special effects
- Equipping replaces the current item in that slot (old item drops to ground)
- Equipment is separate from the 3 carried items
- Equipped armor reduces incoming damage in combat

### Inventory UI (I key)
- Opens a full-screen overlay (game paused)
- Displays the 4 equipment slots with currently equipped items
- Displays the 3 carried items
- Click an item to equip it (if it has an equip_slot) or swap it
- Close with I or ESC

## Files
- `systems/equipment.lua` [NEW]
- `systems/ui/inventory.lua` [NEW]
- `entities/player.lua` [MODIFY] — equipment slot references
- `systems/combat.lua` [MODIFY] — factor equipped armor into damage reduction

## Acceptance Criteria
- Press I to open inventory screen (game pauses)
- Equipment slots are visible with any currently equipped items
- Carried items are visible
- Click a carried item with an equip_slot to equip it (appears in correct slot)
- Old equipped item drops to the ground
- Equipped armor visibly reduces damage taken in combat
- ESC or I closes the inventory
