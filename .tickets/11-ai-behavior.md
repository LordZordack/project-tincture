# Ticket 11: AI Behavior

**Phase**: 4 — NPCs & AI

## Description
Implement AI behavior for NPCs including perception, alliance-based hostility, and aggression-driven combat decisions.

## Requirements

### Perception
- NPCs detect the player and other NPCs within a configurable range
- Line of sight not required for Phase 4 (radius-based detection)

### Alliance Checks
Determine hostility based on the alliance interaction matrix:

| | Arete | Eophyll | Skia | Player |
|---|---|---|---|---|
| Arete | Friendly | Neutral | Hostile | Provoked only |
| Eophyll | Neutral | Friendly | Hostile | Provoked only |
| Skia | Hostile | Hostile | Friendly | Hostile on sight |

### Aggression Behaviors
- **Passive**: Wander randomly, flee when damaged
- **Defensive**: Wander, attack only when damaged or cornered
- **Provoked**: Wander, attack when target gets too close or damages them
- **Aggressive**: Chase and attack hostile targets on sight
- **Berserk**: Attack nearest entity regardless of alliance

### Combat AI
- NPCs attack with their held items (same melee system as player)
- NPCs block when threatened (if holding an item)
- NPCs flee when health is low (Passive/Defensive)

## Files
- `systems/ai.lua` [NEW]
- `main.lua` [MODIFY] — integrate AI system into update loop

## Acceptance Criteria
- Skia NPCs chase and attack the player on sight
- Arete/Eophyll NPCs only attack the player when provoked (damaged or approached too closely)
- Opposing-faction NPCs fight each other when in range
- Same-faction NPCs ignore each other
- Passive NPCs flee when damaged
- Berserk NPCs attack anything nearby
- NPCs use melee attacks and blocking in combat
