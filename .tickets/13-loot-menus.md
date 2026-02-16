# Ticket 13: Loot & Menus

**Phase**: 5 — Equipment & Inventory UI

## Description
Implement the loot popup for corpses/chests and the main menu, pause menu, and settings screen.

## Requirements

### Loot Popup
- Press E while near a corpse or chest to open a loot popup
- Displays items contained in the target
- Click an item to take it (added to carried items, respecting 3-item limit)
- If carrying 3 items already, must drop one first or swap
- Close popup with ESC or E

### Main Menu
- Displayed on game launch
- Options: Start Game, Settings, Quit

### Pause Menu
- ESC during gameplay opens pause menu
- Options: Resume, Settings, Quit to Main Menu

### Settings
- Accessible from main menu and pause menu
- Key rebinding (reads/writes to the input system)
- Audio volume and video settings (placeholder for now)

## Files
- `systems/ui/loot_popup.lua` [NEW]
- `systems/ui/menu.lua` [NEW]
- `systems/input.lua` [MODIFY] — support key rebinding from settings
- `main.lua` [MODIFY] — game state management (menu, playing, paused)

## Acceptance Criteria
- Press E near a corpse — loot popup appears showing contained items
- Click item in loot popup — item transfers to player (if carrying < 3)
- ESC in gameplay opens pause menu with Resume/Settings/Quit
- Game launches to a main menu with Start/Settings/Quit
- Settings menu shows key rebinding options
