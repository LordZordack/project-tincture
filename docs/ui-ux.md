# UI / UX

## HUD

Minimal HUD — no health bar, no ammo counter, no score overlay.

- **Health** is communicated through **visual bleeding**. The more Apolest bleeds, the lower his health. This is purely visual — the player must read their character's appearance to gauge health.
- The **3 carried items** are always visible: the active item in front, two orbiting items held by the faintly-glowing brothers.
- **Equipment slots** (head, body, legs, accessory) are visible on the character model.

## Menus

| Menu | Access | Purpose |
|------|--------|---------|
| Main menu | Game launch | Start game, settings, quit |
| Pause menu | ESC during gameplay | Resume, settings, quit |
| Settings | From main or pause menu | Rebind keys, adjust audio/video |
| Inventory / Equipment | I key | Equip items to 4 slots (head, body, legs, accessory) |
| Loot pop-up | Interact with corpse or chest | Browse and take items from a container |

## Feedback
<!-- Not yet implemented -->
- Screen shake on heavy impacts
- Hit flash on damaged entities
- Particle effects for Skia magic, blood, item breaking

## Accessibility
<!-- Not yet implemented -->
- Key rebinding (via settings menu)
- Adjustable screen shake intensity
