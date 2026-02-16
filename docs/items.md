# Items

## Description
Items are objects that can be picked up by the player. Some objects, such as clothing and armor, can be equipped to the player's person. Other items, such as weapons, can be equipped to fight with. The player can pick up an item and carry it around if it is not too heavy, and it will float in front of them. If it is light enough, it can be thrown. Some objects may be consumed upon use, such as potions or apples. Some objects, such as some clothing, may also be consumed, but it provides negative benefits. When an entity dies, its corpse becomes an item.

---

## Item Categories

### Weapons
Items used to deal damage. Equipped via the left mouse button attack.

| Type | Examples | Notes |
|------|----------|-------|
| Melee | Swords, axes, maces, daggers | Short range, high damage |
| Ranged | Bows, crossbows, thrown knives | Projectile-based, uses ammo |
| Improvised | Chairs, bones, corpses | Any held item can be swung or thrown |

### Armor & Clothing
Worn on the player's body. Provides protection but may affect weight/speed.

| Slot | Examples | Notes |
|------|----------|-------|
| Head | Helmets, hoods, crowns | May affect vision or perception |
| Body | Chainmail, robes, leather vest | Primary source of protection |
| Legs | Greaves, pants, boots | May affect movement speed |
| Accessory | Rings, amulets, cloaks | Special effects, buffs |

> **Consumable clothing**: Some clothing items are consumed on use (e.g., a cursed cloak that dissolves and poisons the wearer). Negative-benefit consumption should be telegraphed through visual cues.

### Consumables
Single-use items that are destroyed upon activation.

| Type | Examples | Effect |
|------|----------|--------|
| Healing | Potions, apples, bread | Restore health |
| Buff | Elixirs, scrolls | Temporary stat boosts |
| Throwable | Bombs, flasks of acid | Area damage on impact |
| Cursed | Rotten food, tainted potions | Negative effects (poison, debuff) |

### Keys & Quest Items
Special items that interact with the world.

- **Keys** — Open locked doors to new rooms. Consumed on use.
- **King's Sword** — Located in final room, stuck in the King's corpse. Required to free the King (win condition).
- **Quest items** — Unique, non-consumable items tied to progression.

### Corpses
When any entity (enemy, NPC, or boss) dies, its body becomes a pickup item.

- Corpses have high weight (hard to carry, slow movement).
- Light corpses (small creatures) can be thrown as improvised weapons.
- Some corpses may have loot that can be scavenged from them.

---

## Item Qualities

Every item has a set of base qualities that determine its behavior:

| Quality | Description | Affects |
|---------|-------------|---------|
| **Weight** | How heavy the item is | Carry speed, throwability, camera zoom |
| **Damage** | Damage dealt when used as a weapon or thrown | Combat |
| **Protection** | Damage reduction when worn | Defense |
| **Durability** | How many uses before the item breaks (if applicable) | Lifespan |
| **Value** | Worth for trading or scoring | Economy |
| **Rarity** | Drop frequency and power tier | Loot tables |
| **Throwable** | Whether the item can be thrown (based on weight threshold) | Combat, utility |
| **Consumable** | Whether the item is destroyed on use | Inventory management |
| **Equip Slot** | Where the item is worn/held (if applicable) | Equipment system |

---

## Item Interactions

### Carrying
- **All items in the world can be picked up**, provided the player can handle the item's weight class.
- The player has a carry strength that determines the maximum weight they can lift.
- The player can hold a maximum of **3 items** at a time.
  - The **active item** floats in front of the player (used for attacks/interactions).
  - The other **2 items** orbit around the player, each held by one of the brothers (see [Player](player.md)). The brothers automatically mirror the player's attacks and blocks with their items.
- Movement speed is reduced proportionally to total carried weight.
- This includes weapons, furniture, corpses, scenery objects — anything is fair game if you're strong enough.

### Throwing
- Items below a weight threshold can be thrown.
- Thrown items deal damage based on their weight and the throw force.
- Thrown items may break on impact (based on durability).

### Equipping
- Weapons are equipped to the active hand (used with left click).
- Armor/clothing is equipped to the appropriate body slot.
- Equipping replaces any item currently in that slot (old item drops).

### Consuming
- Consumables are used immediately on pickup or via an inventory action.
- Effects apply instantly (healing, buffs, debuffs).
- The item is removed from the game after consumption.

---

## Loot & Drops
- Enemies drop items on death (weapon they were using, armor, random loot).
- Room chests and containers hold fixed or randomized loot.
- Item rarity follows a tiered system affecting drop rates and power level.