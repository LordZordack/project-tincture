# Entities

All entities in the dungeon follow the same core rules: they can carry items, engage in combat, and become a corpse upon death. Their bodies can be looted for any items they were carrying. See [Combat](combat.md) for combat mechanics and [Items](items.md) for the item system.

---

## Alliances

Three fairy factions dominate the dungeon. Each NPC belongs to one (or none), which determines their disposition toward the player and other NPCs.

### Arete (White Fairy)
- Name derived from the Greek word for "virtue/excellence"
- **White magic** — associated with healing, protection, and light
- Typically **attack only when provoked**
- Generally neutral or friendly toward the player unless threatened

### Eophyll (Green Fairy)
- Name derived from the Greek word for "first leaf of seedling"
- **Green magic** — associated with nature, growth, and decay
- Typically **attack only when provoked**
- May be hostile to Skia-aligned entities

### Skia (Black Fairy)
- Name derived from the Greek word for "shadow"
- **Black magic** — the dark force that saturates the dungeon
- Typically **attack on sight**
- The dungeon itself is steeped in Skia magic; these entities are its native inhabitants

### Alliance Interactions

| | Arete | Eophyll | Skia | Player |
|---|---|---|---|---|
| **Arete** | Friendly | Neutral | Hostile | Provoked only |
| **Eophyll** | Neutral | Friendly | Hostile | Provoked only |
| **Skia** | Hostile | Hostile | Friendly | Hostile on sight |

> NPCs of the same alliance are friendly to each other. NPCs of opposing alliances will fight each other if they get too close, regardless of the player's involvement.

---

## NPCs

All NPCs have differing levels of aggression and alliances. Some will attack the player on sight, others only when provoked. Some NPCs will be hostile to each other and will attack each other if they get too close.

NPCs use the same combat rules as the player — they carry items, swing weapons, block, and drop corpses on death.

### Aggression Levels

| Level | Behavior |
|-------|----------|
| Passive | Never attacks. Flees when threatened. |
| Defensive | Attacks only when damaged or cornered. |
| Provoked | Attacks when the player gets too close or damages them. |
| Aggressive | Attacks the player on sight. |
| Berserk | Attacks anything nearby — player, other NPCs, even allies. |

### NPC Properties

Every NPC has the following properties:

| Property | Description |
|----------|-------------|
| Alliance | Arete, Eophyll, Skia, or Unaligned |
| Aggression | Passive, Defensive, Provoked, Aggressive, or Berserk |
| Carry items | Items the NPC is holding / equipped with |
| Health | Damage threshold before death |
| Movement | Speed and patrol/chase behavior |

---

## Key Characters

### Anaxarkas (The Trapped King)
- The last human king, imprisoned deep within the dungeon
- Impaled by a sword that binds his soul
- When the sword is pulled free, his soul possesses Apolest — the game's ending
- See [Player](player.md) for full narrative details

### Pelagios (The Magus)
- Tasks Apolest with entering the dungeon
- Not present inside the dungeon (pre-game NPC)

---

## Death & Corpses

- All entities become a **corpse** upon death
- Corpses are items — they can be picked up, carried, thrown, or used as improvised weapons
- Corpses can be **looted** for any items the entity was carrying or had equipped
- Corpse weight is based on the entity's size
