# Combat

Combat in Project Tincture revolves around the item system. Every item in the game can be used as a weapon — from proper swords to furniture and corpses. The player (Apolest) fights with his active held item, while his two brothers automatically mirror his actions with their orbiting items.

---

## The Three-Point System

Apolest can carry up to 3 items at once. All three participate in combat simultaneously:

| Position | Holder | Role |
|----------|--------|------|
| Active (front) | Apolest | Primary attack/block — directly controlled by the player |
| Orbit 1 | Enas (brother) | Automatically mirrors Apolest's attacks and blocks |
| Orbit 2 | Dyo (brother) | Automatically mirrors Apolest's attacks and blocks |

The brothers act as spectral copies, swinging or blocking with whatever item they hold when Apolest does. The player can **swap** which item is active at any time, cycling between the three.

---

## Actions

### Melee Attack
- Swing the active held item at close range.
- Damage is based on the item's **damage** quality and **weight**.
- Any item can be swung — a sword deals more damage than a chair, but both work.
- The brothers simultaneously swing their held items when Apolest attacks.

### Throw (Projectile)
- Throw the active held item as a projectile.
- Only items below the **throwable weight threshold** can be thrown.
- Thrown items deal damage based on weight and throw force.
- Thrown items may **break on impact** (based on durability).
- The thrown item is lost unless retrieved from where it lands.

### Block
- Raise the active held item to absorb incoming damage.
- Damage reduction depends on the item's **protection** and **durability**.
- Any item can be used to block, but fragile items may break.
- The brothers automatically block with their items when Apolest blocks, providing additional coverage from the sides.

### Consume
- Use the active item if it's consumable (potions, food, etc.).
- Effect applies immediately; item is destroyed.
- Some consumables have **negative effects** (cursed items, rotten food).

---

## Weapons

Any item can deal damage, but purpose-built weapons are more effective:

| Type | Range | Speed | Notes |
|------|-------|-------|-------|
| Melee (swords, axes, maces) | Short | Varies by weight | High damage, reliable |
| Daggers, knives | Very short | Fast | Low damage, rapid strikes |
| Ranged (bows, crossbows) | Long | Slow | Require ammo |
| Improvised (furniture, bones, corpses) | Short | Slow | Low damage, high weight, breaks easily |

---

## Blocking

- Any held item can be used to block.
- **Protection value** determines how much damage is absorbed.
- **Durability** is consumed when blocking — items can break mid-fight.
- The brothers provide **passive flanking defense** by blocking simultaneously from their orbital positions.
- Shields and armor pieces provide the best block values; improvised items are fragile.

---

## Damage System

### Damage Calculation
- Base damage is determined by the weapon/item's **damage** quality.
- Heavier items deal more damage when swung or thrown but are slower.
- Target's **protection** (from equipped armor) reduces incoming damage.

### Death & Corpses
- All entities (player, NPCs, enemies) become a **corpse** on death.
- Corpses can be looted for any items the entity was carrying.
- Corpses themselves are items — they can be picked up, carried, and used as improvised weapons or thrown.

---

## NPC Combat Behavior

NPCs have varying levels of aggression and alliances (see [Entities](entities.md)):

| Behavior | Description |
|----------|-------------|
| Hostile on sight | Attacks the player immediately |
| Provoked only | Attacks only when damaged or threatened |
| Inter-NPC hostility | Some NPCs fight each other when in proximity |

NPCs use the same combat rules as the player — they carry items, swing weapons, and drop corpses on death.
