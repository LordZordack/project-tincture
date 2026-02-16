# Ticket 05: Carry System

**Phase**: 2 — Item System & Carrying

## Description
Implement the 3-item carry system. The active item floats in front of the player; the other 2 items orbit around the player, each held by one of the brothers (faint glow effect).

## Requirements
- [ ] Press E near a ground item to pick it up (respecting carry strength / weight class)
- [ ] Maximum of **3 carried items** at a time
  - Active item: floats in front of the player, used for interactions
  - Orbit item 1 (Enas): orbits the player with a faint glow
  - Orbit item 2 (Dyo): orbits the player with a faint glow
- [ ] **Swap** (Tab / Scroll): cycle which item is active
- [ ] **Drop** (E when carrying): drop the active item to the ground
- [ ] Movement speed reduced proportionally to total carried weight
- [ ] Can't pick up items heavier than the player's carry strength

## Files
- `systems/item_manager.lua` [NEW]
- `entities/player.lua` [MODIFY] — add carry_strength, carried item slots, weight-based speed penalty
- `main.lua` [MODIFY] — integrate item_manager, spawn test items

## Acceptance Criteria
- [ ] Walk near an item and press E — item attaches to the player (floats in front)
- [ ] Pick up 2 more — they orbit around the player with a faint glow
- [ ] Can't pick up a 4th item
- [ ] Can't pick up items above carry strength
- [ ] Tab/Scroll swaps which item is active (front position changes)
- [ ] E while carrying drops the active item
- [ ] Movement is noticeably slower when carrying heavy items
